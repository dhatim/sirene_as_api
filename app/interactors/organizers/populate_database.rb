class PopulateDatabase
  include Interactor::Organizer

  organize SetApplyPatches, ImportLastMonthlyStock, SaveLastMonthlyStockName, SelectAndApplyPatches
end
