class Type < ActiveRecord::Base

  has_many :field_definitions, dependent: :destroy
  has_many :pages
  has_many :fields, through: :pages

  accepts_nested_attributes_for :field_definitions, allow_destroy: true, reject_if: :all_blank

  before_destroy :rem_types_pgs
  #remove categories from pages
  def rem_types_pgs
  	pages = Page.where(type_id: self.id)
	pages.each do |p|
	  p.fields.each do |f|
	  	f.destroy
	  end
	  p.type_id = nil
	  p.save
	end
  end

  EXISTING_TYPES = {image: 1, homepage_type1: 2, homepage_type2: 3}



end
