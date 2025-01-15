class StringCalculatorsController < ApplicationController
  def index; end

  def add
    begin
      @result = StringCalculator.add(params["numbers"])
    rescue StandardError => e
      @error = e.message
    end

    # Respond with Turbo Stream to update the result/error section
    respond_to do |format|
      format.html { render :index }
      format.turbo_stream
    end
  end

end
