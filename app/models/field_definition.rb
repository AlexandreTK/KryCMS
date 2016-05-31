class FieldDefinition < ActiveRecord::Base
  belongs_to :type

  before_destroy :rem_fields
  #remove categories from pages
  def rem_fields
  	type = self.type
  	pages = Page.where(type_id: type.id)
	pages.each do |p|
	  p.fields.each do |f|
	  	puts '#'*50 + f.value
	  	f.destroy
	  end
	  p.type_id = nil
	  p.save
	end
  end

end
