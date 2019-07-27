class API::V1::SirenLikeController < ApplicationController
  def show
    query = siren_params[:siren]
    if /\A\d{1,9}\z/.match?(query)
      r =
        if query.size == 9
          Etablissement.where(:siren => query).order('is_siege DESC')
        else
          Etablissement.where("siren LIKE :query",
                              query: "#{query}%")
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

  def siren_params
    params.permit(:siren)
  end
end