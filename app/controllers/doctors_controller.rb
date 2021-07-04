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
      redirect_to doctors_url, notice: 'Doutor criado com sucesso!'
    else
      render :new
    end
  end

  def update
    pick_ufs
    if @doctor.update(doctor_params)
      redirect_to doctors_url, notice: 'Doutor atualizado com sucesso!'
    else
      flash[:notice] = 'Não foi possível atualizar o doutor'
      render :edit
    end
  end

  def destroy
    if @doctor.destroy
      redirect_to doctors_url, notice: 'Doutor apagado com sucesso!'
    else
      flash[:error] = 'Não é possível apagar doutor pois ele possui atendimentos cadastrados'
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
