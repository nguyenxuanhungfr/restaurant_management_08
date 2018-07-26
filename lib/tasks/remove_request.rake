task remove_request: :environment do
    User.last.destroy
  end
