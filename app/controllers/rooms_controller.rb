class RoomsController < ApplicationController
  before_action :set_room, only: %i[show]

  def index
    authorize Room
    @rooms = policy_scope(Room).order(created_at: :desc)
  end

  def show
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

  private

  def set_room
    @room = Room.find(params[:id])
    authorize @room
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
