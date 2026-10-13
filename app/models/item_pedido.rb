class ItemPedido < ApplicationRecord
  belongs_to :pedido
  belongs_to :produto
  validates :quantidade, presence: true, numericality: { greater_than: 0 }
end
