class IbgeDataService
  def ufs
    HTTParty.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados')
  end
end