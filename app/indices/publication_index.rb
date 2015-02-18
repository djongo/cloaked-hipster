ThinkingSphinx::Index.define :publication, :with => :active_record do
    indexes title, :sortable => true
    indexes abstract
    indexes language.name, :as => :language_name
    indexes publication_type.name, :as => :publication_type
    indexes :id, :as => :publication_id
    indexes state, :sortable => true
    indexes reference
    indexes target_journal.name, :as => :target_journal_name
    indexes populations.name, :as => :inclusion_name
    indexes surveys.name, :as => :foundation_name
    # indexes notes.content, :as => :note_content
    
    # Keywords, mediators, outcomes, and determinants
    # indexes keyword_variables(:name), :as => :keyword_name
    indexes variables.name, :as => :variable_name

    # People information
    indexes [user.first_name, user.last_name, user.email], :as => :responsible_author

    # Author information
    indexes authors.name, :as => :author_name
    indexes authors.email, :as => :author_email
    indexes authors.country_team.name, :as => :country_team_name
    indexes authors.focus_group.name, :as => :focus_group_name

  # SOLUTION FOR HMT: http://railsforum.com/viewtopic.php?id=28917
    has created_at, updated_at, :id
    where "archived = 'false'"  
end