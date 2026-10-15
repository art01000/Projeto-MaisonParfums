class Carrinho < ApplicationRecord
  belongs_to :usuario
  has_many :itens_carrinhos, dependent: :destroy
  has_many :produtos, through: :itens_carrinhos
end
