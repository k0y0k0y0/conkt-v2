class AddResponseToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :response, :boolean, array: true, default: []
  end
end
