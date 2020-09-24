class Etablissement < ApplicationRecord
  include Scopable::Model
  belongs_to :unite_legale, optional: true

  AUTHORIZED_FIELDS = %w[id siret nic siren statut_diffusion unite_legale unite_legale_id date_dernier_traitement created_at updated_at].freeze

  def self.latest_mise_a_jour
    # probabilist search for true latest update. Date time must be exact but a wrong time is tolerated
    # always works if at least one new entry had been inserted the previous day otherwise works well in most cases (>99.9% confidence)
    # 20 000 can be a good upper bound since every patch seems to have less than 20 000 lines
    last_update_nb_entries_tol = 20_000

    sql = "SELECT max(date_mise_a_jour)
           FROM (SELECT date_mise_a_jour FROM etablissements
                 ORDER BY id DESC
                 LIMIT #{last_update_nb_entries_tol}
           ) as x"

    ActiveRecord::Base.connection.exec_query(sql).first["max"]
  end

  def self.header_mapping
    ETABLISSEMENT_HEADER_MAPPING
  end

  def nullify_non_diffusable_fields
    return if statut_diffusion == 'O'

    attributes.each_key do |attribute|
      send("#{attribute}=", nil) unless AUTHORIZED_FIELDS.include?(attribute)
    end
  end
end
