class UserRole < ActiveRecord::Base
  belongs_to :user


  private
  CONTENT_M = 1
  PRODUCT_M = 2
  FULL_M = 3
  DEFAULT_ROLES = [["Content_Manager", CONTENT_M], 
  ["Product_Manager", PRODUCT_M], 
  ["Full_Manager", FULL_M] ]

end
