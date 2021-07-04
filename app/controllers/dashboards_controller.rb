class DashboardsController < ApplicationController
  def index
    @doctors = Doctor.all
    @dashboards = Appointment.all
                             .paginate(page: params[:page], per_page: 10)
    @appointments_count = Appointment.all
                                     .count
    @patients_count = Appointment.distinct
                                 .count(:patient_id)
  end

  def search
    doctor_id = params[:doctor][:id]
    @doctor = Doctor.find(doctor_id)
    @doctors = Doctor.all
    @dashboards = Appointment.where('doctor_id = ?', doctor_id)
    @appointments_by_doctor = Appointment.where('doctor_id = ?', doctor_id)
                                         .count
    @patients_by_doctor = Appointment.where('doctor_id = ?', doctor_id)
                                     .distinct
                                     .count(:patient_id)
  end
end
