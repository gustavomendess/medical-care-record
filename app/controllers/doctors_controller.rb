class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:edit, :update, :destroy]

  def index
    @doctors = Doctor.all
                     .paginate(page: params[:page], per_page: 5)
  end

  def new
    pick_ufs
    @doctor = Doctor.new
  end

  def edit
    pick_ufs
  end

  def create
    pick_ufs
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to doctors_url, notice: 'Médico criado com sucesso!'
    else
      render :new
    end
  end

  def update
    pick_ufs
    if @doctor.update(doctor_params)
      redirect_to doctors_url, notice: 'Médico atualizado com sucesso!'
    else
      flash[:notice] = 'Não foi possível atualizar o médico'
      render :edit
    end
  end

  def destroy
    if @doctor.destroy
      redirect_to doctors_url, notice: 'Médico apagado com sucesso!'
    else
      flash[:error] = 'Não é possível apagar o médico pois ele possui atendimentos cadastrados'
      redirect_to doctors_url
    end
  end

  private

  def pick_ufs
    @ufs = HTTParty.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados')
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:name, :crm, :crm_uf)
  end
end
