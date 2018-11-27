class AddEmployeeToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :employee_id, :integer
  end
end
