class AppointmentsController < ApplicationController
  def new
    @current_user = current_user
    render :'homes/index'
  end
end
