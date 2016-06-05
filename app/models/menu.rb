class Menu < ActiveRecord::Base
  # OLD:
  # validates_presence_of :name
  # has_many :menu_items, dependent: :destroy

  # accepts_nested_attributes_for :menu_items, allow_destroy: true, reject_if: :all_blank

  # NEW
  validates_presence_of :name
  has_many :menu_items, dependent: :destroy

  accepts_nested_attributes_for :menu_items, allow_destroy: true, reject_if: lambda { |a| a[:title].blank?}

   # , class_name: "MenuItem"
end
