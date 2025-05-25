class EventsController < ApplicationController
  before_action :set_project

  def create
    @event = @project.events.build(event_params)
    @event.user = current_user

    ActiveRecord::Base.transaction do
      if event_params[:to_status].present? && event_params[:to_status] != @project.status
        @event.from_status = @project.status
        @project.status = event_params[:to_status]
      end

      @event.save!
      @project.save! if @project.changed?
    end

    redirect_to @project, notice: "Event was successfully added."
  rescue ActiveRecord::RecordInvalid
    redirect_to @project, alert: "Failed to add event."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def event_params
    params.require(:event).permit(:content, :to_status)
  end
end
