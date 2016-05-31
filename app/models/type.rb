class Type < ActiveRecord::Base

  has_many :field_definitions, dependent: :destroy
  has_many :pages
  has_many :fields, through: :pages


  EXISTING_TYPES = {image: 1, homepage_type1: 2, homepage_type2: 3}

  accepts_nested_attributes_for :field_definitions, reject_if: :all_blank


end
