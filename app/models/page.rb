class Page < ActiveRecord::Base
  belongs_to :category

  belongs_to :type
  has_many :fields, dependent: :destroy
  has_many :field_definitions, through: :type


  accepts_nested_attributes_for :fields, reject_if: :all_blank

  # page.url
  def method_missing name, *args, &block
    field = self.fields.find { |field| field.field_definition.key == name.to_s }
    if field
      field.value
    else
      super
    end
  end

  # def self.build type, page
  #   if (page==nil)
  #     page = Page.new type: type
  #   else
  #     page.type = type
  #   end
  #   if(page.type != nil)
  #     page.type.field_definitions.each do |definition|
  #       page.fields.build field_definition: definition
  #     end
  #   end
  #   page
  # end

      #   @page = Page.new type: Type.where(name: params[:type]).first
      # if(@page.type != nil)
      #   @page.type.field_definitions.each do |definition|
      #     @page.fields.build field_definition: definition
      #   end
      # end

end
