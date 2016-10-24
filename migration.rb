require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'dev.sqlite3'
  })

class InitialMigration < ActiveRecord::Migration[5.0]

  def up
    create_table :developers do |t|
      t.string :name
      t.string :email_address
      t.date :start_date
    end

    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.integer :client_id
    end

    create_table :clients do |t|
      t.string :name
      t.integer :industry_id
    end

    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.integer :parent_task_id
    end

    create_table :time_entry do |t|
      t.integer :developer_id
      t.integer :tasks_id
      t.date :work_date
      t.float :hours
    end

    create_table :industry do |t|
      t.string :name
    end

    create_table :comments do |t|
      t.integer :developer_id
      t.integer :project_id
      t.integer :client_id
      t.integer :industry_id
    end

    create_table :groups do |t|
      t.string :name
    end

    create_join_table :developers, :projects
    create_join_table :developers, :groups

  end

  def down
    drop_table :developers
    drop_table :projects
    drop_table :clients
    drop_table :tasks
    drop_table :time_entry
    drop_table :industry
    drop_table :comments
    drop_table :groups
    drop_join_table :developers, :projects
    drop_join_table :developers, :groups
  end

end


begin
  InitialMigration.migrate(:down)
rescue
end

InitialMigration.migrate(:up)
