# == Schema Information
#
# Table name: publications
#
#  id                  :integer          not null, primary key
#  title               :text
#  abstract            :text
#  state               :string(255)      default("preplanned")
#  reference           :text
#  url                 :string(255)
#  change              :text
#  archived            :boolean          default(FALSE)
#  language_id         :integer          default(1)
#  publication_type_id :integer          default(1)
#  target_journal_id   :integer
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Publication < ActiveRecord::Base
  include AASM

  attr_accessible :abstract, :archived, :change, :language_id, 
    :publication_type_id, :reference, :state, :target_journal_id, 
    :title, :url, :user_id, :keyword_tokens, :survey_tokens, 
    :population_tokens, :target_journal_name, :authors_attributes, 
    :keywords, :mediators, :outcomes, :determinants, :inclusions,
    :foundations, :outcome_tokens, :determinant_tokens, :mediator_tokens, :keywords_yml
  
  has_paper_trail :meta => { 
    :keywords => Proc.new { |publication|  publication.hmt_list(publication.keywords) },
    :mediators => Proc.new { |publication|  publication.hmt_list(publication.mediators) }, 
    :outcomes => Proc.new { |publication|  publication.hmt_list(publication.outcomes) },    
    :determinants => Proc.new { |publication|  publication.hmt_list(publication.determinants) },   
    :inclusions => Proc.new { |publication|  publication.inclusions_list },    
    :foundations => Proc.new { |publication|  publication.foundations_list }            
    }, :on => [:update, :destroy]  

  belongs_to :language
  belongs_to :publication_type
  belongs_to :user
  belongs_to :target_journal

	has_many :notes, :dependent => :destroy
# remember to destroy in join tables

  has_many :keywords
  has_many :keyword_variables, through: :keywords, source: :variable
  attr_reader :keyword_tokens
  has_many :determinants
  has_many :determinant_variables, :through => :determinants, source: :variable
  attr_reader :determinant_tokens
  has_many :mediators
  has_many :mediator_variables, :through => :mediators, source: :variable
  attr_reader :mediator_tokens
  has_many :outcomes
  has_many :outcome_variables, :through => :outcomes, source: :variable
  attr_reader :outcome_tokens
  has_many :foundations
  has_many :surveys, :through => :foundations
  attr_reader :survey_tokens
  has_many :inclusions
  has_many :populations, :through => :inclusions
  attr_reader :population_tokens

  has_many :authors, :order => "number", :dependent => :destroy
  accepts_nested_attributes_for :authors, allow_destroy: true

  validates_presence_of :title, :language_id, :publication_type_id, :user_id
  
  # Tagging methods
  def keyword_tokens=(tokens)
    self.keyword_variable_ids = Variable.ids_from_tokens(tokens)
  end

  def outcome_tokens=(tokens)
    self.outcome_variable_ids = Variable.ids_from_tokens(tokens)
  end

  def determinant_tokens=(tokens)
    self.determinant_variable_ids = Variable.ids_from_tokens(tokens)
  end

  def mediator_tokens=(tokens)
    self.mediator_variable_ids = Variable.ids_from_tokens(tokens)
  end

  def survey_tokens=(ids)
    self.survey_ids = ids.split(",")
  end

 def population_tokens=(ids)
    self.population_ids = ids.split(",")
  end

  # Methods (getter and setter) for Target Journal
  def target_journal_name
    target_journal.try(:name)
  end

  def target_journal_name=(name)
    self.target_journal = TargetJournal.find_or_create_by_name(name) if name.present?
  end

  # methods for meta data for versions
  def hmt_list(hmt)
    l = []
    hmt.each do |k|
#      puts "just before adding to array: #{k}"
      l << k.variable_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

  # given a yaml list of variable ids return names as concatenated string
  def list_variable_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Variable.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  def inclusions_list
    l = []
    self.inclusions.each do |k|
      l << k.population_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

  def list_inclusion_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Population.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  def foundations_list
    l = []
    self.foundations.each do |k|
      l << k.survey_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

  def list_foundation_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Survey.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  # Methods for import
  def self.import(file)
    # Set defaults
    undecided = PublicationType.find_by_name("Undecided")
    english = Language.find_by_name("English")
    pg_user = User.find_by_email('bho@si-folkesundhed.dk')

    CSV.foreach(file.path, :headers => true, :col_sep => ";", :encoding => 'u') do |row|
      r = row.to_hash

      # Variables to be user in publication table
      given_state = r["Status (state)"] 
      title = r["Title"]
      created_at = r["Created at"] # Convert to correct format or insert default
      id = r["ID"]      
      reference = r["Reference"]
      target_journal = r["Target journal"]
      url = r["Publication URL"]

      # Default state to preplanned if not included or incorrect
      if given_state
        given_state_cleaned = given_state.downcase.gsub(/\s+/, "") # Set to lowercase and remove whitespaces
        if ["preplanned","planned","inprogess","submitted","accepted","published"].include?(given_state_cleaned) 
          state = given_state_cleaned
        else
          state = "preplanned"
        end
      end
      
      if created_at.blank?
        created_at = Time.now
      else
        begin
          created_at = DateTime.parse(created_at)
        rescue
          created_at = Time.now
        end
      end
      
      # other variable
      surveys = r["Survey data"]
      populations = r["Populations"]
      authors = r["Author(s)"]
      user_hbsc_member = r["First author: registered member?"] #.downcase.gsub(/\s+/, "")
      responsible_author = r["HBSC responsible author "]
      responsible_author_email = r["HBSC responsible author email "]
      country_team = r["Country team"]
      date_submitted = r["Date submitted"]
      date_accepted = r["Date accepted"]
      date_published = r["Date published"]

      # Find country team. They should be given per author, but import spreadsheet is incorrect, will get first value if given
      if country_team.to_s.strip.gsub(/\s+/, "\"").strip.length > 0 
        country_teams = country_team.split(",")
        country_teams.each do |ct|
          ctname = ct.strip
          unless CountryTeam.find_by_name(ctname) || ctname.blank?
            CountryTeam.create!(:name => ctname)
          end
        end
        first_country = country_teams.first.strip
        given_country_team_id = CountryTeam.find_by_name(first_country).id
      end

      # Sorting local db sync issue
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end;nil
      
    
      # Does publication exist, so we can add a new version?
      publication = Publication.find_by_id(id) || Publication.new
      publication.id = id
      publication.title = title
      publication.state = state # check that correct in csv before uploading
      publication.created_at = created_at
      publication.updated_at = Time.now
      publication.publication_type_id = undecided.id
      publication.language_id = english.id
      publication.reference = reference
      publication.archived = false
      publication.url = url

      # Set up Target Journal
      if target_journal
        unless TargetJournal.find_by_name(target_journal.strip)
          tj = TargetJournal.new
          tj.name = target_journal.strip
          tj.save
        end
        publication.target_journal_id = TargetJournal.find_by_name(target_journal.strip).id 
      end

      # Set up authors
      if publication.id.to_i > 0
        existing_authors = []  
        publication.authors.each do |ea|
          existing_authors.push( ea.name )
        end
      end

      if authors != nil
        authors_arr = authors.split(",")
        authors_arr.each do |a|
          unless existing_authors.include? a.strip
            # author = Author.new
            # author.name = a.strip
            # author.number = authors_arr.index(a)
            # author.publication_id = publication.id
            # author.country_team_id = given_country_team_id
            Author.create name: a.strip, number: authors_arr.index(a), publication_id: publication.id, country_team_id: given_country_team_id
          end
        end
      end
      
      # Set up survey data
      if surveys
        surveys.split(",").each do |s|
          s_name = s.strip
          survey = Survey.find_by_name(s_name) || Survey.new
          unless Survey.find_by_name(s_name) || s_name.blank?
            survey.name = s_name            
            survey.save!
          end
          unless Foundation.find_by_publication_id_and_survey_id(publication.id, survey.id)
            if publication.id.to_i > 0 && survey.id.to_i > 0 
              Foundation.create(:publication_id => publication.id, :survey_id => survey.id)
            end
          end
        end
      end

      # Set up populations
      if populations
        populations.split(",").each do |p|
          p_name = p.strip
          population = Population.find_by_name(p_name) || Population.new
          unless Population.find_by_name(p_name)
            population.name = p_name
            population.save!
          end
          unless Inclusion.find_by_publication_id_and_population_id(publication.id, population.id)
            if publication.id.to_i > 0 && population.id.to_i > 0
              Inclusion.create!(:publication_id => publication.id, :population_id => population.id)
            end
          end
        end
      end

      # Publication has to be tied to a user, in this case it is the HBSC responsible author
      # if none is listed, default to Bjørn (pg_user)
      if responsible_author_email
        rae = responsible_author_email.downcase.strip
        ra = responsible_author.strip
        if User.find_by_email(rae)
          user = User.find_by_email(rae)
        else
          if rae.include?(";") || rae.include?(" ")
            user = pg_user
          else
            user = User.new
            user.name = ra
            user.email = rae
            user.password = "user1234"
            user.password_confirmation = "user1234"
            user.hbsc_member = true
            user.roles_mask = 2
            user.save!
          end
        end      
      else
        user = pg_user
      end
  
      # Save publication
      publication.user_id = user.id
      publication.save
    end
  end # end import

  # Methods for export
  def self.to_csv(selection, options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      selection.each do |pub|
        csv << pub.attributes.values_at(*column_names)
      end
    end
  end

  # Defining the workflow with 
  aasm :column => 'state' do
  	state :preplanned, :initial => true
  	state :preplanned_submitted
  	state :planned
  	state :planned_submitted
  	state :inprogress
  	state :inprogress_submitted
  	state :submitted
  	state :submitted_submitted
  	state :accepted
  	state :accepted_submitted
  	state :published
  	state :locked

		# Locked to unlocked (preplanned)
		event :unlock do 
			transitions :from => :locked, :to => :preplanned
		end

		# Preplanned to planned 
		event :preplanned_submit do
			transitions :from => :preplanned, :to => :preplanned_submitted
		end

		event :preplanned_reject do
			transitions :from => :preplanned_submitted, :to => :locked
		end

		event :preplanned_accept do
			transitions :from => :preplanned_submitted, :to => :planned
		end

	  event :preplanned_remind do
	    transitions :to => :preplanned, :from => :preplanned
	  end	  

	  # Planned to Inprogress
	  event :planned_submit do
	    transitions :to => :planned_submitted, :from => [:planned]
	  end
	  
	  event :planned_reject do
	    transitions :to => :planned, :from => [:planned_submitted]
	  end

	  event :planned_accept do
	    transitions :to => :inprogress, :from => [:planned_submitted]
	  end
	  
	  event :planned_remind do
	    transitions :to => :planned, :from => [:planned]
	  end
	    
	  # Inprogress to Submitted
	  event :inprogress_submit do
	    transitions :to => :inprogress_submitted, :from => [:inprogress]
	  end
	  
	  event :inprogress_reject do
	    transitions :to => :inprogress, :from => [:inprogress_submitted]
	  end

	  event :inprogress_accept do
	    transitions :to => :submitted, :from => [:inprogress_submitted]
	  end
	  
	  event :inprogess_remind do
	    transitions :to => :inprogress, :from => [:inprogess]
	  end
	  
	  # Submitted to Accepted
	  event :submitted_submit do
	    transitions :to => :submitted_submitted, :from => [:submitted]
	  end
	  
	  event :submitted_reject do
	    transitions :to => :submitted, :from => [:submitted_submitted]
	  end

	  event :submitted_accept do
	    transitions :to => :accepted, :from => [:submitted_submitted]
	  end
	  
	  event :submitted_remind do
	    transitions :to => :submitted, :from => [:submitted]
	  end
	  
	  # Accepted to Published
	  event :accepted_submit do
	    transitions :to => :accepted_submitted, :from => [:accepted]
	  end
	  
	  event :accepted_reject do
	    transitions :to => :accepted, :from => [:accepted_submitted]
	  end

	  event :accepted_accept do
	    transitions :to => :published, :from => [:accepted_submitted]
	  end
	  
	  event :accepted_remind do
	    transitions :to => :accepted, :from => [:accepted]
	  end
  end

  # the functions      
  def send_preplanned_accept
    flash[:notice] = "Accepted as planned"
  end
  
  def send_preplanned_reject
    flash[:error] = "Rejected"
  end

  def send_planned_accept
    flash[:notice] = "Accepted as inprogress"
  end
  
  def send_planned_reject
    flash[:error] = "Rejected"
  end

  def send_inprogress_accept
    flash[:notice] = "Accepted as submitted"
  end
  
  def send_inprogress_reject
    flash[:error] = "Rejected"
  end

  def send_submitted_accept
    flash[:notice] = "Accepted as accepted"
  end
  
  def send_submitted_reject
    flash[:error] = "Rejected"
  end

  def send_accepted_accept
    flash[:notice] = "Accepted as published"
  end
  
  def send_accepted_reject
    flash[:error] = "Rejected"
  end


end
