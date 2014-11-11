class Study < ActiveRecord::Base
  include ResourceTools
  include SingularResourceTools
  extend AssociatedWithRoles

  has_role(:data_access_contact)
  has_role(:slf_manager)
  has_role(:lab_manager)

  json do
    ignore(
      :projects,
      :commercially_available,
      :samples
    )
    translate(
      :id                => :id_study_lims,
      :uuid              => :uuid_study_lims,
      :sac_sponsor       => :faculty_sponsor,
      :alignments_in_bam => :aligned
    )
  end
end
