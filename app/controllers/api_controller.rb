class APIController < ActionController::API
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found
    response = { error:
       {
        title: 'Not Found',
        message: 'The requested resource was not found.'
       }
    }

    respond_with response, status: :not_found
  end
end
