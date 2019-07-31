class DropAllIndexes < SireneAsAPIInteractor

  def call
    indexes_to_be_removed.each do |index|
      stdout_info_log("Trying to drop index : #{index}")
      ActiveRecord::Base.connection.execute("DROP INDEX CONCURRENTLY IF EXISTS #{index}")
    end

  end

  def indexes_to_be_removed
    %w(
     trgm_on_l6_normalisee
     trgm_on_l4_normalisee
     trgm_idx_etablissements_on_siren
     trgm_idx_etablissements_on_siret
     trgm_on_nom_raison_sociale
     index_etablissements_on_siren
     index_etablissements_on_siret
    )
  end

end
