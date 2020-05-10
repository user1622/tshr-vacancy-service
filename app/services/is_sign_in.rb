class IsSignIn < ApplicationService
  def initialize(job_platform, user)
    @job_platform = job_platform
    @user = user
    @job_platform_client = JobPlatformClient::JobPlatformFactory.client(@job_platform)
  end

  def call
    result = @job_platform_client.sign_in?(@user.users_job_platforms.where('users_job_platforms.job_platform_id': @job_platform.id).first.session_data)
    @user.users_job_platforms.destroy_all unless result
    result
  rescue JobPlatformClient::SignInError => error
    error
  end
end