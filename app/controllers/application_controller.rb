class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :dispatch_user
  include Pundit

  def dispatch_user
    return unless current_user && request.get?
    path = new_profile_path unless current_user.valid?
    path = rooms_path if request.path == root_path
    redirect_to path unless path.nil? || path == request.path
  end

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^profiles$)/
  end
end
