class AppointmentsController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    response = SetAppointmentService.new.call(params)
    render json: response, status: response[:code]
  end
end
