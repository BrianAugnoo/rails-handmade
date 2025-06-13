require "httparty"

class ArtController < ApplicationController
  def new
    @art = Art.new
  end

  def create
    @art = Art.new(set_params)
    @art.user = current_user
    @ia_verification = ia_verification
    if @ia_verification[:succes]
      if @ia_verification[:ai_detected]
        flash[:alert] = "AI-generated content detected with a confidence of #{@ia_verification[:ai_confidence]}%. Please upload original content."
        render :new
      else
        if @art.save
          flash[:notice] = "Art created successfully! \n AI detection: #{@ia_verification[:ai_confidence]}% confidence."
          redirect_to root_path
        else
          flash[:alert] = "Failed to create art. Please check the errors."
          render :new
        end
      end
    else
      flash[:alert] = @ia_verification[:error]
      render :new
    end
  end

  private
  def set_params
    params.require(:art).permit(:description, :photo, :video, :tags)
  end

  def ia_verification
    response = api_request
    if response
      {
        succes: true,
        ai_detected: response.dig("report", "ai", "is_detected"),
        ai_confidence: (response.dig("report", "ai", "confidence") * 100).round(2)
      }
    else
      raise
      {
        succes: false,
        error: "API request exceeded or failed."
      }
    end
  end

  def api_request
    file = params.dig(:art, :photo).tempfile
    options = {
      headers: {
        "Authorization" => "Bearer #{ENV['AI_OR_NOT']}"
      },
      body: {
        object: file
      }
    }

    response = HTTParty.post("https://api.aiornot.com/v1/reports/image", options)
    response.code == 403 ? false : JSON.parse(response.body)
  end
end
