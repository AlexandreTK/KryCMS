class MenuItem < ActiveRecord::Base
  belongs_to :menu

  belongs_to :parent, class_name: "MenuItem"
  has_many :children, class_name: "MenuItem", foreign_key: "parent_id"

  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: lambda { |a| a[:title].blank?}

  def parent_name
  	parent.try(:name)
  end

  def has_parent?
  	parent.present?
  end

  def has_children?
  	children.exists?
  end

end
