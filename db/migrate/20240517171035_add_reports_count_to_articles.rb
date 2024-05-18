class AddReportsCountToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :reports_count, :integer
    add_column :articles, :default, :string
    add_column :articles, :"0", :string
  end
end
