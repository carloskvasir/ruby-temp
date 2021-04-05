require 'net/http'
class CEP
  attr_reader :logradouro, :bairro, :localidade, :uf

  def initialize(cep)
    cep_found =  find(cep)
    set_data(cep_found)
  end

  def endereco
    "#{@logradouro} / #{@bairro} / #{@localidade} - #{uf}"
  end

  private

  def set_data(cep_found)
    @logradouro = cep_found["logradouro"]
    @bairro     = cep_found["bairro"]
    @localidade = cep_found["localidade"]
    @uf         = cep_found["uf"]
  end

  def find(cep)
    ActiveSupport::JSON.decode(
      Net::HTTP.get(
        URI("https://viacep.com.br/ws/#{cep}/json")
      )
    )
  end
end
