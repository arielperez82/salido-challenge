require 'active_admin/base_controller'
ActiveAdmin::BaseController.class_eval do
  rescue_from ActiveRecord::RecordNotUnique, with: :show_errors

  def show_errors(e)
    flash[:error] = ["You've attempted to add a duplicate entry! Please check your entries and try again."]
    redirect_to collection_url
  end
end