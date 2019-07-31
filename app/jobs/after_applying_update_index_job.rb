class AfterApplyingUpdateIndexJob < SireneAsAPIInteractor

  def call
    stdout_warn_log("Creating necessary indexes for database")

    indexes_to_add_queries.each do |query|
      stdout_info_log("Executing : #{query}")
      ActiveRecord::Base.connection.execute(query)
    end

    stdout_success_log("Created indexes for database")
  end

  def indexes_to_add_queries
    ["CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_idx_etablissements_on_siret ON etablissements USING gin(siret gin_trgm_ops)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_idx_etablissements_on_siren ON etablissements USING gin(siren gin_trgm_ops)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_nom_raison_sociale ON etablissements USING gin (nom_raison_sociale gin_trgm_ops)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_l6_normalisee ON etablissements USING gin (l6_normalisee gin_trgm_ops)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS trgm_on_l4_normalisee ON etablissements USING gin (l4_normalisee gin_trgm_ops)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS index_etablissements_on_siret ON public.etablissements USING btree (siret)",
     "CREATE INDEX CONCURRENTLY IF NOT EXISTS index_etablissements_on_siren ON public.etablissements USING btree (siren)"
    ]
  end
end
