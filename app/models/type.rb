class Type < ActiveRecord::Base

  has_many :field_definitions, dependent: :destroy
  has_many :pages
  has_many :fields, through: :pages

  before_destroy :rem_types_pgs
  #remove categories from pages
  def rem_types_pgs
  	pages = Page.where(type_id: self.id)
	pages.each do |p|
	  p.fields.each do |f|
	  	puts '#'*50 + f.value
	  	f.destroy
	  end
	  p.type_id = nil
	  p.save
	end

	# DIDNT IMPROVE ANYTHING
	
	# fds = FieldDefinition.where(type_id: self.id)
	# fds.each do |fd|
	# 	fs = Field.where(field_definition_id: fd.id)
	# 	fs.each do |f|
	# 		page = f.page
	# 		f.destroy
	# 		page.type_id = nil
	# 	end
	# end

  end


  EXISTING_TYPES = {image: 1, homepage_type1: 2, homepage_type2: 3}

  accepts_nested_attributes_for :field_definitions, reject_if: :all_blank


end
