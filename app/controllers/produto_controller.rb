class ProdutoController < ApplicationController
  before_action :authenticate_usuario!, only: [:index] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  before_action :exigir_admin, only: [:index, :new, :create, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  before_action :set_produto, only: [:edit, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets

  def index
  end
  
  def new
    @produto = Produto.new
  end
  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      redirect_to admin_path, notice: "Produto criado com sucesso."
    else
      render :new
    end
  end

  def update
    @produto = Produto.find(params[:id])
    if @produto.update(produto_params)
      redirect_to admin_path, notice: "Produto atualizado com sucesso."
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy
    redirect_to admin_path, notice: "Produto excluído com sucesso."
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :marca, :descricao, :categoria, :tamanho, :fragancia, :intensidade, :momento, :piramide_olfativa, :concentracao, :preco, :estoque,)#imagem
  end
end
