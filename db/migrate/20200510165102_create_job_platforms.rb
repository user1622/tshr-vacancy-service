class CreateJobPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :job_platforms do |t|
      t.string :url
      t.string :name
      t.timestamps
    end
  end
end
