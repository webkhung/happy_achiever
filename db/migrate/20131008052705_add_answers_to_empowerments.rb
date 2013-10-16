class AddAnswersToEmpowerments < ActiveRecord::Migration
  def change
    add_column :empowerments, :answer_8, :string
    add_column :empowerments, :answer_9, :string
  end
end
