class UsuarioController < ApplicationController
  before_action :authenticate_usuario!, only: [:show] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  def show
    @usuario = current_usuario
  end


  private

  def params_login
    params.require(:usuario).permit(:email, :password)
  end

  def params_cadastrar
    params.require(:usuario).permit(:nome, :email, :telefone, :password, :password_confirmation)
  end
end
