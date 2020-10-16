class TicketsController < ApplicationController
  before_action :set_room, only: %i[new create]
  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    authorize @ticket
    @ticket.student = current_user
    @ticket.room = @room
    if @ticket.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def ticket_params
    params.require(:ticket).permit(:description)
  end
end
