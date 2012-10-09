class AddActiveField < ActiveRecord::Migration
	def change
		add_column :zombies, :active, :boolean, :default => true, 
			:null => false, :required => true
		add_column :zombies, :wins, :integer, :default => 0,
			:null => false, :required => true
		add_column :zombies, :losses, :integer, :default => 0,
			:null => false, :required => true
	end
end
