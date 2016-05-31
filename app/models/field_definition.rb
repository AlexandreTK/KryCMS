class FieldDefinition < ActiveRecord::Base
  belongs_to :type
  has_many :fields, dependent: :destroy
end
