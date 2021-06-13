class Task < ApplicationRecord
    validates :title, :start, :end, :status, :priority, presence: true
end
