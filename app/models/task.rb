class Task < ApplicationRecord
    validates :title, :start, :endtime, :status, :priority, presence: true
    validate :endtime_is_greater, if: :dates_present?

    def dates_present?
        start.presence && endtime.presence
    end

    def endtime_is_greater
        if endtime < start
            errors.add :endtime, :endtime_is_greater, message: I18n.t('error.end_start')
        end
    end
end
