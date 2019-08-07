class API::V1::SiretLikeController < ApplicationController
  def show
    query = siret_params[:siret]
    if /\A\d{1,14}\z/.match?(query)
      r =
        if query.size == 14
          Etablissement.find_by(siret: query)
        else
          Etablissement.where("siret LIKE :query",
                              query: "#{query}%").limit(20)
        end
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