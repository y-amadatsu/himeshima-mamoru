# frozen_string_literal: true

class Reservations::ImportsController < ApplicationController
  def new; end

  def create
    upload_params[:file]
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
