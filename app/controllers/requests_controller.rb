class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    authorize @request

    if @request.save!
      redirect_to conversations_path
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:status, :user_id, :product_id)
  end

end
