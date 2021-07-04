class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  validates :doctor_id, :patient_id, presence: true
  validate :attributes_presence
  validate :appointment_on_time
  validate :exceeded_thirty_minutes
  validate :appointments_times
  validate :inconsistent_hours

  def attributes_presence
    errors.add(:base, I18n.t('errors.appointments.no_appointment_date')) if appointment_date.nil?
    errors.add(:base, I18n.t('errors.appointments.no_starts_date')) if starts_at.nil?
    errors.add(:base, I18n.t('errors.appointments.no_ends_date')) if ends_at.nil?
  end

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
    return if ends_at.nil? || starts_at.nil?

    errors.add(:base, I18n.t('errors.appointments.inconsistent_hours')) if ends_at < starts_at
  end

  def exceeded_thirty_minutes
    return if ends_at.nil? || starts_at.nil?

    appointment_time = (ends_at - starts_at) / 60
    errors.add(:base, I18n.t('errors.appointments.appointment_minutes')) if appointment_time > 30
  end

  def appointments_times
    return if ends_at.nil? || starts_at.nil?

    start = are_in_appointment_time?(starts_at.strftime('%H:%M'))
    final = are_in_appointment_time?(ends_at.strftime('%H:%M'))
    errors.add(:base, I18n.t('errors.appointments.not_in_appointment_times')) if !start || !final
  end

  def are_in_appointment_time?(time)
    (time >= '09:00' && time <= '12:00') || (time >= '13:00' && time <= '18:00')
  end
end
