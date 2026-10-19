class Produto < ApplicationRecord
  has_many :itens_carrinho, dependent: :destroy
  has_many :carrinhos, through: :itens_carrinho
  has_many :itens_pedidos, dependent: :destroy
  has_many :pedidos, through: :itens_pedidos
  # has_one_attached :imagem

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than: 0 }

  after_create_commit do
    broadcast_prepend_to "produtos_#{categoria}", target: "produtos", partial: "home/produto", locals: { produto: self }
  end

  enum :categoria, {
    feminino: "Feminino",
    masculino: "Masculino",
    unissex: "Unissex"
  }

  enum :tamanho, {
    tamanho_2ml: "2ml",
    tamanho_5ml: "5ml",
    tamnho_10ml: "10ml",
    lacrado: "Lacrado"
  }

  enum :fragancia, {
    floral: "Floral",
    aítrica: "Cítrica",
    amadeirada: "Amadeirada",
    oriental: "Oriental",
    fougère: "Fougère",
    chipre: "Chipre",
    gourmand: "Gourmand",
    aromática: "Aromática",
    aquática: "Aquática"
  }

  enum :momento, {
    dia: "Dia",
    noite: "Noite",
    ambos: "Ambos"
  }

  enum :intensidade, {
    baixa: "Baixa",
    media: "Média",
    alta: "Alta"
  }
end
