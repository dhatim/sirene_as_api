class API::V1::NomAdresseController < ApplicationController
  def show
    query = nom_adresse_params[:text].split().join('%')
    r = Etablissement.where("nom_raison_sociale || ' ' || l4_normalisee || ' ' || l6_normalisee ILIKE :query",
                            query: "%#{query}%").limit(20)


    if r.nil?
      render json: { message: 'no results found' }, status: 404
    else
      render json: { etablissement: r }, status: 200
    end

  end

  private

  def nom_adresse_params
    params.permit(:text)
  end
end
