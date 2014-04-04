class ChangeEmpowermentsColumnSize < ActiveRecord::Migration
  def up
    change_column :empowerments, :answer_1, :text
    change_column :empowerments, :answer_2, :text
    change_column :empowerments, :answer_3, :text
    change_column :empowerments, :answer_4, :text
    change_column :empowerments, :answer_5, :text
    change_column :empowerments, :answer_6, :text
    change_column :empowerments, :answer_7, :text
    change_column :empowerments, :answer_8, :text
    change_column :empowerments, :answer_9, :text
  end

  def down
  end
end
