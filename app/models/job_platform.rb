class JobPlatform < ApplicationRecord
  has_many :users_job_platforms
  has_many :users, through: :users_job_platforms
end
