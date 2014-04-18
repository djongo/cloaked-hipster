class TargetJournalsController < ApplicationController
  filter_resource_access
  # GET /target_journals
  # GET /target_journals.json
  def index
    @target_journals = TargetJournal.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      # json used for autocomplete on form
      format.json { render json: @target_journals.where("name like ?", "%#{params[:term]}%").map(&:name) }
    end
  end

  # GET /target_journals/1
  # GET /target_journals/1.json
  def show
    #@target_journal = TargetJournal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @target_journal }
    end
  end

  # GET /target_journals/new
  # GET /target_journals/new.json
  def new
    #@target_journal = TargetJournal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @target_journal }
    end
  end

  # GET /target_journals/1/edit
  def edit
    #@target_journal = TargetJournal.find(params[:id])
  end

  # POST /target_journals
  # POST /target_journals.json
  def create
    #@target_journal = TargetJournal.new(params[:target_journal])

    respond_to do |format|
      if @target_journal.save
        format.html { redirect_to @target_journal, notice: 'Target journal was successfully created.' }
        format.json { render json: @target_journal, status: :created, location: @target_journal }
      else
        format.html { render action: "new" }
        format.json { render json: @target_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /target_journals/1
  # PUT /target_journals/1.json
  def update
    #@target_journal = TargetJournal.find(params[:id])

    respond_to do |format|
      if @target_journal.update_attributes(params[:target_journal])
        format.html { redirect_to @target_journal, notice: 'Target journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @target_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_journals/1
  # DELETE /target_journals/1.json
  def destroy
    #@target_journal = TargetJournal.find(params[:id])
    @target_journal.destroy

    respond_to do |format|
      format.html { redirect_to target_journals_url }
      format.json { head :no_content }
    end
  end
end
