class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:edit, :destroy, :update]

  def index
    @appointments = Appointment.order(starts_at: :asc)
                               .paginate(page: params[:page], per_page: 5)
  end

  def new
    @appointment = Appointment.new
    doctor_and_patients
  end

  def edit
    doctor_and_patients
    renderiza :edit
  end

  def update
    doctor_and_patients
    if @appointment.update appointment_params
      flash[:notice] = 'Consulta atualizada com sucesso!'
      redirect_to root_url
    else
      renderiza :edit
    end
  end

  def create
    doctor_and_patients
    @appointment = Appointment.new appointment_params
    if @appointment.save
      flash[:notice] = 'Consulta agendada com sucesso!'
      redirect_to root_url
    else
      renderiza :new
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

  def renderiza(view)
    @doctors = Doctor.all
    render view
  end
end
