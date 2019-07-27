Rails.application.routes.draw do

  concern :v1_routes do
    get 'siret/:siret' => '/api/v1/siret#show'
    get 'siren/:siren' => '/api/v1/siren#show'
    get 'siren_like/:siren' => '/api/v1/siren_like#show'
    get 'siret_like/:siret' => '/api/v1/siret_like#show'
    get 'full_text/:text' => '/api/v1/full_text#show'
    get 'suggest/:suggest_query' => '/api/v1/suggest#show'
    get 'near_etablissement/:siret' => '/api/v1/near_etablissement#show'
    get 'near_etablissement_geojson/:siret' => '/api/v1/near_etablissement_geojson#show'
    get 'near_point/' => '/api/v1/near_point#show'
    get 'rna/:rna' => '/api/v1/numero_rna#show'
  end

  concern :v2_routes do
    get 'siren/:siren' => '/api/v2/siren#show'
    get 'siren/:siren/etablissements' => '/api/v2/siren_children#show'
    get 'siren/:siren/etablissements_geojson' => '/api/v2/siren_children_geojson#show'
  end

  namespace :v1 do
    concerns :v1_routes
  end

  namespace :v2 do
    concerns :v2_routes
  end

  # DIRTY FIX (nginx configuration and url prefixing do not work)
  scope '/api/sirene/' do
    namespace :v1 do
      concerns :v1_routes
    end

    namespace :v2 do
      concerns :v2_routes
    end
  end

end
