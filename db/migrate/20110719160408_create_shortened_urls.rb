class CreateShortenedUrls < ActiveRecord::Migration
  # Up and Down refer to rolling the database Up or Down
  # Up is creation and Down is full deletion
  # ActiveRecord: http://ar.rubyonrails.org/
  #  Create_Table: http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-create_table
  #  Add_Index: http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_index
  #  Drop_Table: http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-drop_table

  def self.up
	# Outlines the table (everything but the index)
	create_table :shortened_urls do |t|
		t.string :url
	end
	# attaches the index counter based on the url
	add_index :shortened_urls, :url
  end

  def self.down
	drop_table :shortened_urls
  end
end
