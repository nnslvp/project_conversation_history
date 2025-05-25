class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 12)
  end

  def show
    @project = Project.find(params[:id])
    @events = @project.events.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.draft.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy!

    redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed."
  end

  private

  def set_project
    @project = Project.find(params.expect(:id))
  end

  def project_params
    params.expect(project: [ :title, :description ])
  end
end
