class Produto < ApplicationRecord
  has_many :itens_carrinho, dependent: :destroy
  has_many :carrinhos, through: :itens_carrinho
  has_many :itens_pedidos, dependent: :destroy
  has_many :pedidos, through: :itens_pedidos
  #has_one_attached :imagem

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than: 0 }

  =======
  after_create_commit do
    broadcast_prepend_to "produtos_#{categoria}", target: "produtos", partial: "produto/produto", locals: { produto: self }
  end

  enum :fragancia, {
    floral: "floral",
    amadeirada: "amadeirada",
    citrica: "citrica",
    oriental: "oriental",
    fougere: "fougere",
    chipre: "chipre",
    gourmand: "gourmand",
    aromatica: "aromatica",
    aquatica: "aquatica"
  }

  enum :categoria, {
    feminino: "feminino",
    masculino: "masculino",
    unissex: "unissex"
  }


  enum :momento, {
    dia: "dia",
    noite: "noite",
    ambos: "ambos"
  }

  enum :intensidade, {
    baixa: "baixa",
    media: "média",
    alta: "alta"
  }

  enum :piramide_olfativa, {
    saida: "saida",
    coracao: "coracao",
    base: "base"
  }

  enum :concentracao {
    parfum: "parfum",
    EDP: "EDP",
    EDT: "EDT",
    EDC: "EDC",
    splash: "splash"
  }

  # "tamanho_5ml" -> "5ml" -> 5 | "Lacrado" -> nil
  def volume_ml
    v = self.class.tamanhos[tamanho].to_i
    v.positive? ? v : nil
  end

  def decant?
    frasco_mae.present? && volume_ml.present?
  end

  # RN02: tem líquido suficiente para essa quantidade?
  def disponivel?(qtd = 1)
    decant? ? frasco_mae.estoque_ml >= volume_ml * qtd : estoque.to_i >= qtd
  end

  # RN02 + RN03: quantidade máxima que o cliente pode pedir
    # RN02: quantidade máxima que o estoque permite
  def quantidade_maxima
    return estoque.to_i unless decant?
    frasco_mae.estoque_ml / volume_ml
  end

  # RN01: baixa o estoque (chame quando o pedido for pago)
  def baixar_estoque!(qtd)
    alvo = decant? ? frasco_mae : self
    alvo.with_lock do
      raise "Estoque insuficiente de #{nome}" unless disponivel?(qtd)
      if decant?
        frasco_mae.update!(estoque_ml: frasco_mae.estoque_ml - volume_ml * qtd)
      else
        update!(estoque: estoque - qtd)
      end
    end
  end
end
>>>>>>> main

end
