class TshrController < ApplicationController
  before_action :authorize_request

  def sign_in?
    job_platform = @current_user.job_platforms.where('job_platforms.id': job_platform_id).first
    result = job_platform.present?
    result = IsSignIn.call(job_platform, @current_user) if result
    render status: 200, json: { success: result }
  end

  def sign_in
    job_platform = JobPlatform.find(sign_in_params[:jobPlatformID])
    result = SignIn.call(job_platform, @current_user, sign_in_params[:username], sign_in_params[:password])
    json_result = {}
    if result[:success]
      json_result[:success] = true
    else
      json_result[:success] = false
      json_result[:error] = result[:error]
    end
    render status: 200, json: json_result
  end

  protected

  def job_platform_id
    params.require(:jobPlatformID)
  end

  def sign_in_params
    params.permit([:jobPlatformID, :username, :password])
    params
  end
end
