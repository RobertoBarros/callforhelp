class RoomsController < ApplicationController
  before_action :set_room, only: %i[show tickets]

  def index
    @rooms = policy_scope(Room).order(created_at: :desc)
  end

  def show
    @tickets = @room.tickets.where(solved: false).order(:created_at)
  end

  def new
    @room = Room.new
    authorize @room
  end

  def create
    @room = Room.new(room_params)
    authorize @room

    @room.user = current_user
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  def tickets
    @tickets = @room.tickets.where(solved: false).order(:created_at)

    response = { tickets_html: render_to_string(partial: "rooms/tickets", locals: { tickets: @tickets }) }

    render json: response.to_json
  end

  private

  def set_room
    @room = Room.find(params[:id])
    authorize @room
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
