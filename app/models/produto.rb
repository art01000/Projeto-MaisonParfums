class Produto < ApplicationRecord
  has_many :itens_carrinho, dependent: :destroy
  has_many :carrinhos, through: :itens_carrinho
  has_many :itens_pedidos, dependent: :destroy
  has_many :pedidos, through: :itens_pedidos
  #has_one_attached :imagem

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than: 0 }

<<<<<<< HEAD:app/models/perfume.rb
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

=======
>>>>>>> upstream/main:app/models/produto.rb
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

end
