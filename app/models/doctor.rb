class Doctor < ActiveRecord::Base
  has_many :appointment, dependent: :restrict_with_error

  validates :name, :crm, :crm_uf, presence: true
  validate :duplicated_doctor

  def duplicated_doctor
    return unless new_record?

    if Doctor.where(crm: crm, crm_uf: crm_uf).exists?
      errors.add(:base, "O CRM (#{crm} - #{crm_uf}) já está em uso")
    end
  end
end
