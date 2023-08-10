class RemoveResponseFromAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_column :answers, :response, :boolean
  end
end
