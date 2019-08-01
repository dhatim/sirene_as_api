Rails.application.routes.draw do

  concern :v1_routes do
    get 'siret/:siret' => '/api/v1/siret#show', :constraints => { :siret => /.*/ }
    get 'siren/:siren' => '/api/v1/siren#show', :constraints => { :siren => /.*/ }
    get 'siren_like/:siren' => '/api/v1/siren_like#show', :constraints => { :siren => /.*/ }
    get 'siret_like/:siret' => '/api/v1/siret_like#show', :constraints => { :siret => /.*/ }
    get 'nom_adresse/:text' => '/api/v1/nom_adresse#show', :constraints => { :text => /.*/ }
    get 'full_text/:text' => '/api/v1/full_text#show', :constraints => { :text => /.*/ }
    get 'suggest/:suggest_query' => '/api/v1/suggest#show', :constraints => { :suggest_query => /.*/ }
    get 'near_etablissement/:siret' => '/api/v1/near_etablissement#show', :constraints => { :siret => /.*/ }
    get 'near_etablissement_geojson/:siret' => '/api/v1/near_etablissement_geojson#show', :constraints => { :siret => /.*/ }
    get 'near_point/' => '/api/v1/near_point#show'
    get 'rna/:rna' => '/api/v1/numero_rna#show', :constraints => { :rna => /.*/ }
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
