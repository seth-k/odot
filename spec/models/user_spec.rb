require 'spec_helper'
RSpec.configure do |c|
  c.expose_current_running_example_as :example
end

describe User do
  let(:valid_attributes) {
    {
      first_name: "Seth",
      last_name: "Kroger",
      email: "foo@example.com",
      password: "treehouse1234",
      password_confirmation: "treehouse1234"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }
    
    before do
      User.create(valid_attributes)
    end
    
    it "requires an email do" do
      expect(user).to validate_presence_of(:email)
    end
    
    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires a unique email case-insensitive" do
      user.email = "JASON@TEAMTREEHOUSE.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires the mail address to look like an email" do
      user.email = "jason"
      expect(user).to_not be_valid
    end
    
  end
  
  context "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "JASON@TEAMTREEHOUSE.COM"))
      #user.downcase_email
      #expect(user.email).to eq("jason@teamtreehouse.com")
      expect{ user.downcase_email }.to change{ user.email }
        .from("JASON@TEAMTREEHOUSE.COM")
        .to("jason@teamtreehouse.com")
    end
    
    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "MIKE@TEAMTREEHOUSE.COM"
      expect(user.save).to be true
      expect(user.email).to eq("mike@teamtreehouse.com")
    end
  end
  
end
