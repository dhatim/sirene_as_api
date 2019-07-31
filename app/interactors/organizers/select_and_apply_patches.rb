class SelectAndApplyPatches
  include Interactor::Organizer

  organize GetRelevantPatchesLinks, ApplyPatches, AfterApplyingUpdateIndexJob
end
