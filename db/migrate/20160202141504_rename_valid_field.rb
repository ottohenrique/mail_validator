class RenameValidField < ActiveRecord::Migration
  def change
    rename_column :emails,:valid,:email_valid
  end
end
