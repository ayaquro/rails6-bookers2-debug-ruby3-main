class RemoveEvaluationFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :evaluation, :float
  end
end
