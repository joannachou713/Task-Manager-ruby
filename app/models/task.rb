class Task < ApplicationRecord
  belongs_to :user

  has_many :label_relations, dependent: :delete_all
  has_many :labels, through: :label_relations

  validates :title, :start, :endtime, :status, :priority, presence: true
  validate :endtime_is_greater, if: :dates_present?

  def dates_present?
    start.presence && endtime.presence
  end

  def endtime_is_greater
    if endtime < start
      errors.add :endtime, :endtime_is_greater, message: I18n.t('flash.task.end_start')
    end
  end

  def label_items
    labels.map(&:name)
  end

  def label_items=(names)
    self.labels = names.filter{ |x| x != "" }.map{|item|
      Label.find_or_create_by(name: item.strip)}
  end
end
