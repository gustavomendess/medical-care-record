class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :appointment_description
      t.date :appointment_date
      t.time :starts_at
      t.time :ends_at
      t.integer :patient_id
      t.integer :doctor_id
    end
  end
end
