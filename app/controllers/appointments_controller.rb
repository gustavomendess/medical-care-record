class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[edit destroy update]
  before_action :doctor_and_patients, only: %i[new edit create update]

  def index
    @appointments = Appointment.order(starts_at: :asc)
                               .paginate(page: params[:page], per_page: 5)
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    render :edit
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:notice] = 'Consulta agendada com sucesso!'
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @appointment.update appointment_params
      flash[:notice] = 'Consulta atualizada com sucesso!'
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    flash[:notice] = 'Consulta apagada com sucesso'
    redirect_to root_url
  end

  private

  def doctor_and_patients
    @doctors = Doctor.all
    @patients = Patient.all
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :starts_at,
                                        :ends_at, :patient_id,
                                        :doctor_id, :appointment_description)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
