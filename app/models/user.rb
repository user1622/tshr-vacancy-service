class User < ApplicationRecord
  self.table_name = :user

  has_many :users_job_platforms
  has_many :job_platforms, through: :users_job_platforms
end
