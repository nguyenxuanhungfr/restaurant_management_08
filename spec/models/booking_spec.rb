require "rails_helper"

RSpec.describe Booking, type: :model do
  describe "can booking table" do
    let!(:booking) { FactoryBot.create(:booking, user_id:1, table_id: 1) }
  end
end
