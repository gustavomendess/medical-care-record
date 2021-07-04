class Patient < ActiveRecord::Base
  validates_cpf_format_of :cpf
  validates :name, :birth_date, :cpf, presence: true
  validate :cpf_as_integer

  def cpf_as_integer
    self.cpf = cpf.gsub(/[^\d]/, '')
    if Patient.where(cpf: cpf).exists?
      errors[:base] << 'Cpf já está em uso'
    end
  end
end
