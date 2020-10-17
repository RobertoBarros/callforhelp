class TicketsController < ApplicationController
  before_action :set_room, only: %i[new create]
  before_action :set_ticket, only: %i[assign_teacher cancel solved destroy]

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

  def destroy
    @ticket.destroy
    redirect_to room_path(@ticket.room)
  end

  def assign_teacher
    @ticket.teacher = current_user
    @ticket.save

    RoomChannel.broadcast_to(
      @ticket.room,
      render_to_string(partial: "rooms/ticket", locals: { ticket: @ticket })
    )

    redirect_to room_path(@ticket.room)
  end

  def solved
    @ticket.solved = true
    @ticket.save
    redirect_to room_path(@ticket.room)
  end

  def cancel
    @ticket.teacher = nil
    @ticket.save
    redirect_to room_path(@ticket.room)
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
    authorize @ticket
  end

  def ticket_params
    params.require(:ticket).permit(:description)
  end
end
