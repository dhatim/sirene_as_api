class API::V1::SiretController < ApplicationController
  def show
    query = siret_params[:siret]
    if /\A\d{14}\z/.match?(query)
      r = Etablissement.find_by(siret: query)
      if r.nil?
        render json: { message: 'no results found' }, status: 404
      else
        render json: { etablissement: r }, status: 200
      end
    else
      render json: { message: 'no results found' }, status: 404
    end
  end

  private

  def siret_params
    params.permit(:siret)
  end
end
