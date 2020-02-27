# frozen_string_literal: true

class PostcodesController < BaseController
  def lookup
    @form = PostcodeForm.new
    return unless params[:commit]

    @form.attributes = postcode_params
    @results = PostcodeService.lookup(@form.postcode_array) if @form.valid?
  end

  private

  def postcode_params
    params.require(:postcode).permit(:postcodes)
  end
end
