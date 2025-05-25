class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 12)
  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.find(params[:id])
    @events = @project.events.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.draft.new(create_project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.expect(project: [ :title, :description, :status ])
    end

    def create_project_params
      params.expect(project: [ :title, :description ])
    end
end
