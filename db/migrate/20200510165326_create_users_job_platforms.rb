class CreateUsersJobPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :users_job_platforms do |t|
      t.belongs_to :user
      t.belongs_to :job_platform
      t.column :session_type, "enum('cookie', 'token')"
      t.column :session_data, :binary, :limit => 1.megabyte
      t.timestamps
    end
  end
end
