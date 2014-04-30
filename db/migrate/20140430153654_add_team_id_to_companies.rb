class AddTeamIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :team_id, :integer
  end
end
