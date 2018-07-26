require "rails_helper"

RSpec.describe User, type: :model do

  describe "db schema" do
    context "columns" do
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:address).of_type(:string) }
      it { should have_db_column(:phone).of_type(:string) }
      it { should have_db_column(:image).of_type(:string) }
      it { should have_db_column(:password_digest).of_type(:string) }
    end
  end

  describe "associations" do
    it { should have_many(:dishes).through(:reviews) }
    it { should have_many(:tables).through(:bookings) }
    it { should have_many(:bookings) }
    it { should have_many(:bills) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :address }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_length_of(:password).is_at_least 6 }
    it { should validate_length_of(:address).is_at_most 255 }
    it { should validate_length_of(:phone).is_at_most 11 }
  end

  describe "order_by_name" do
    let!(:demo1){FactoryBot.create(:user, name:"hung", email: "hung@gmail.com", address: "ha noi", phone: "0934589868",password: "123456")}
    let!(:demo2){FactoryBot.create(:user, name:"tuan", email: "tuan@gmail.com", address: "ha noi", phone: "0934589868",password: "123456")}
    context "user order by desc" do
      it{expect(User.order_by_name).to eq [demo2, demo1]}
    end
  end
end

