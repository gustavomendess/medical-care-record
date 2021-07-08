class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy]

  def index
    @patients = Patient.all
                       .paginate(page: params[:page], per_page: 5)
  end

  def show
    @appointment_by_patient = Appointment.where('patient_id = ?',
                                                params[:id])
  end

  def new
    @patient = Patient.new
  end

  def edit; end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patients_url, notice: 'Paciente criado com sucesso!'
    else
      render :new
    end
  end

  def update
    if @patient.update(patient_params)
      redirect_to patients_url, notice: 'Paciente atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    if @patient.destroy
      redirect_to patients_url, notice: 'Paciente apagado com sucesso!'
    else
      redirect_to patients_url, notice: 'Ocorreu um problema ao apagar o cadastro do paciente!'
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :birth_date, :cpf)
  end
end
