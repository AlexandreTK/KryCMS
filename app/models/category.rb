class Category < ActiveRecord::Base
  has_many :pages

  before_destroy :rem_cat_pages

  #remove categories from pages
  def rem_cat_pages
	self.pages.each do |p|
	  p.category_id = nil
	  p.save
	end
  end

end