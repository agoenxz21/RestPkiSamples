class AuthenticationsController < ApplicationController
  before_action :set_expired_page_headers

  def index
    redirect_to new_authentication_path
  end

  def new
    begin
      @auth = RestPki::Authentication.new(RestPki::StandardSecurityContexts::PKI_BRAZIL).start_with_web_pki
    rescue => ex
      @errors = ex.error.to_hash
      render 'layouts/_error'
    end
  end

  def create
    token = params[:token]
    begin
      @auth = RestPki::Authentication.new(RestPki::StandardSecurityContexts::PKI_BRAZIL).complete_with_web_pki(token)
    rescue => ex
      @errors = ex.error.to_hash
      render 'layouts/_error'
    end
  end

end
