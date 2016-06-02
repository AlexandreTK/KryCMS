class UserRole < ActiveRecord::Base
  belongs_to :user


  private
  DEFAULT_ROLES = [["Content_Manager", 1], ["Product_Manager", 2], ["Full_Manager", 3] ]

end
