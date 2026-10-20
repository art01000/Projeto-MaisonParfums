class ItensCarrinho < ApplicationRecord
  belongs_to :carrinho
  belongs_to :produto

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
  validate :dentro_do_estoque

  private

  def dentro_do_estoque
    return unless produto && quantidade
    max = produto.quantidade_maxima
    return if quantidade <= max

    errors.add(:quantidade, max.zero? ? "produto esgotado" : "máximo de #{max} unidade(s) disponível(is)")
  end
end