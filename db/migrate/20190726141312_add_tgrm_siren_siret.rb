class AddTgrmSirenSiret < ActiveRecord::Migration[5.0]

  execute "create index trgm_idx_etablissements_on_siret on etablissements using gin(siret gin_trgm_ops);"
  execute "create index trgm_idx_etablissements_on_siren on etablissements using gin(siren gin_trgm_ops);"
end
