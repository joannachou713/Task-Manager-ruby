class Label < ApplicationRecord
  has_many :label_relations, dependent: :delete_all
  has_many :tasks, through: :label_relations
end
