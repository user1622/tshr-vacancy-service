class UsersJobPlatform < ApplicationRecord
  belongs_to :user
  belongs_to :job_platform
end
