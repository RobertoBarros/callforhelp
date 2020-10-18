class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update]

  def index
    @rooms = policy_scope(Room).order(created_at: :desc)
  end

  def show
    @tickets = @room.tickets.where(solved: false).order(:created_at)

    respond_to do |format|
      format.html
      format.json do
        response = { tickets_html: render_to_string(partial: 'rooms/tickets',
                                                    locals: { room: @room, tickets: @tickets },
                                                    formats: :html) }

        render json: response.to_json
      end
    end
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
      update_teachers
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      update_teachers
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  private

  def update_teachers
    @room.teachers.destroy_all
    params[:room][:user_ids]&.each do |user_id|
      Teacher.create(room: @room, user_id: user_id)
    end
  end

  def set_room
    @room = Room.find(params[:id])
    authorize @room
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
