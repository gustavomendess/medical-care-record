class DashboardsController < ApplicationController
  def index
    all_doctors
    all_dashboards_data
  end

  def search
    doctor_id = params[:doctor][:id]
    if doctor_id.empty?
      redirect_to :dashboards
    else
      dashboard_by_doctor(doctor_id)
    end
  end

  private

  def dashboard_by_doctor(doctor_id)
    all_doctors
    @doctor = Doctor.find(doctor_id)
    @dashboards = Appointment.where('doctor_id = ?', doctor_id)
    @appointments_by_doctor = Appointment.where('doctor_id = ?', doctor_id)
                                         .count
    @patients_by_doctor = Appointment.where('doctor_id = ?', doctor_id)
                                     .distinct
                                     .count(:patient_id)
  end

  def all_doctors
    @doctors = Doctor.all
  end

  def all_dashboards_data
    @dashboards = Appointment.all
                             .paginate(page: params[:page], per_page: 10)
    @appointments_count = Appointment.all
                                     .count
    @patients_count = Appointment.distinct
                                 .count(:patient_id)
  end
end
