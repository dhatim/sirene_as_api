class KeepMinIndexAddTrgm < ActiveRecord::Migration[5.0]

  execute "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_idx_nom_raison_sociale_l4_l6 ON etablissements USING gin ((nom_raison_sociale || ' ' || l4_normalisee || ' ' || l6_normalisee) gin_trgm_ops);"
  execute "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_nom_raison_sociale ON etablissements USING gin (nom_raison_sociale gin_trgm_ops);"
  execute "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_l6_normalisee ON etablissements USING gin (l6_normalisee gin_trgm_ops);"
  execute "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_l4_normalisee ON etablissements USING gin (l4_normalisee gin_trgm_ops);"

  execute "DROP INDEX CONCURRENTLY IF EXISTS index_etablissements_on_l6_normalisee;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS index_etablissements_on_nom_raison_sociale;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS index_etablissements_on_numero_rna;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS query_etablissements_on_activite_principale;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS entreprises_to_tsvector_idx;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS entreprises_to_tsvector_idx1;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS entreprises_to_tsvector_idx2;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS entreprises_to_tsvector_idx3;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS etablissements_to_tsvector_idx;"
  execute "DROP INDEX CONCURRENTLY IF EXISTS entreprises_to_tsvector_idx4;"

end
