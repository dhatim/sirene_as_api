require 'rails_helper'

describe API::V1::NumeroRNAController do
  context 'when doing a search that isnt found', type: :request do
    it 'doesnt return anything' do
      rna_not_found = '9999999999999999999999'
      get "/v1/rna/#{rna_not_found}"
      expect(response.body).to look_like_json
      expect(body_as_json).to match(message: 'no results found')
      expect(response).to have_http_status(404)
    end
  end

  context 'when doing a simple search', type: :request do
    rna_found = '123456789'
    let!(:etablissement) { create(:etablissement_v2, nom_raison_sociale: 'foobarcompany', numero_rna: rna_found) }
    it 'return the correct results' do
      EtablissementV2.reindex

      get "/v1/rna/#{rna_found}"

      expect(response.body).to look_like_json
      expect(response).to have_http_status(200)
      result_hash = body_as_json

      name_etablissement = result_hash[:etablissement][:nom_raison_sociale]
      expect(name_etablissement).to match('foobarcompany')
    end
  end
end
