class PadesSignaturesController < ApplicationController
  before_action :set_expired_page_headers

  def index
    redirect_to new_pades_signature_path
  end

  def new
    begin
    @file_name = Rails.root.join('public', 'uploads', '01.pdf')
    @pades_signature = RestPki::PadesSignature.new(@file_name,
                                        RestPki::StandardSecurityContexts::PKI_BRAZIL,
                                        RestPki::StandardSignaturePolicies::PADES_BASIC
    ).start_with_web_pki
    rescue => ex
      @errors = ex.error.to_hash
      render 'layouts/_error'
    end
  end

  def create
    begin
    @pades_signature = RestPki::PadesSignature.finisher(params[:token])
    file_token = SecureRandom.hex(10).to_s + '.pdf'
    File.open(Rails.root.join('public', 'uploads', file_token), 'wb') do |file|
      file.write(Base64.decode64(@pades_signature.signedPdf))
    end
    @pades_signature.file_name = file_token
    rescue => ex
      @errors = ex.error.to_hash
      render 'layouts/_error'
    end
  end

  def upload
  end

  def sign_upload
    begin
    uploaded_io = params[:pades][:file]
    @file_token = SecureRandom.hex(10).to_s + '.pdf'
    File.open(Rails.root.join('public', 'uploads', @file_token), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @pades_signature = RestPki::PadesSignature.new(Rails.root.join('public', 'uploads', @file_token),
                                                   RestPki::StandardSecurityContexts::PKI_BRAZIL,
                                                   RestPki::StandardSignaturePolicies::PADES_BASIC
    ).start_with_web_pki
    render 'new'
    rescue => ex
      @errors = ex.error.to_hash
      render 'layouts/_error'
    end
  end

end
