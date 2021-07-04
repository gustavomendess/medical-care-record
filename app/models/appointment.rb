class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_date, :starts_at, :ends_at,
            :doctor_id, :patient_id, presence: true
  validate :appointment_on_time
  validate :exceeded_thirty_minutes
  validate :appointments_times
  validate :inconsistent_hours

  def appointment_on_time
    return unless new_record?

    appointment = Appointment.where(starts_at: starts_at,
                                    ends_at: ends_at,
                                    appointment_date: appointment_date)
    return if appointment.empty?

    errors.add(:base, I18n.t('errors.appointments.appointment_by_date_time',
                             starts_at: starts_at.strftime('%H:%M'),
                             ends_at: ends_at.strftime('%H:%M'),
                             appointment_date: appointment_date.strftime('%d/%m/%Y')))
  end

  def inconsistent_hours
    errors.add(:base, I18n.t('errors.appointments.inconsistent_hours')) if ends_at < starts_at
  end

  def exceeded_thirty_minutes
    appointment_time = (ends_at - starts_at) / 60
    errors.add(:base, I18n.t('errors.appointments.appointment_minutes')) if appointment_time > 30
  end

  def appointments_times
    start = are_in_appointment_time?(starts_at.strftime('%H:%M'))
    final = are_in_appointment_time?(ends_at.strftime('%H:%M'))
    errors.add(:base, I18n.t('errors.appointments.not_in_appointment_times')) if !start || !final
  end

  def are_in_appointment_time?(time)
    (time >= '09:00' && time <= '12:00') || (time >= '13:00' && time <= '18:00')
  end
end
