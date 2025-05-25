class EventsController < ApplicationController
  before_action :set_project

  def create
    @event = @project.events.build(event_params.merge(user: current_user))

    return redirect_to @project, alert: "Status is already #{@project.status}" if same_status?

    ActiveRecord::Base.transaction do
      update_project_status! if event_params[:to_status].present?
      @event.save!
      @project.save! if @project.changed?
    end

    redirect_to @project, notice: "Event was successfully added."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @project, alert: "Failed to add event"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def event_params
    params.require(:event).permit(:content, :to_status)
  end

  def same_status?
    event_params[:to_status].present? && event_params[:to_status] == @project.status
  end

  def update_project_status!
    @event.from_status = @project.status
    @project.status = event_params[:to_status]
  end
end
