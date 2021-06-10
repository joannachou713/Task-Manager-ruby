class Task < ApplicationRecord
    validates :title, presence: true
    validates :start, presence: true
    validates :end, presence: true
    validates :status, presence: true
    validates :priority, presence: true
end
