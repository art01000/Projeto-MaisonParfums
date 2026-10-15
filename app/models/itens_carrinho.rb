class ItensCarrinho < ApplicationRecord
  belongs_to :carrinho
  belongs_to :produto
  validates :quantidade, presence: true, numericality: { greater_than: 0 }
end
