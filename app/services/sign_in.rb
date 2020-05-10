class SignIn < ApplicationService
  def initialize(job_platform, user, username, password)
    @job_platform = job_platform
    @user = user
    @username = username
    @password = password
    @job_platform_client = JobPlatformClient::JobPlatformFactory.client(@job_platform)
  end

  def call
    result = @job_platform_client.sign_in(username: @username, password: @password)
    save_session(result) if result[:success]
    result
  rescue JobPlatformClient::SignInError => error
    error
  end

  protected

  def save_session(result)
    users_job_platform = UsersJobPlatform.new
    users_job_platform.user = @user
    users_job_platform.job_platform = @job_platform
    users_job_platform.session_type = result[:session_type]
    users_job_platform.session_data = result[:session_data]
    users_job_platform.save!
  end
end