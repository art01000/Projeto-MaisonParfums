module ProdutoHelper
    def formatar_preco(preco)
        return "Sob consulta" if preco.blank? || preco.zero?

        number_to_currency(preco, unit: "R$ ", separator: ",", delimiter: ".")
    end
end
