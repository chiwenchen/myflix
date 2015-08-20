require 'spec_helper'

describe PasswordWordController do 
  describe "GET new" do 
    context "with blank input" do 
      it "render forget password page"
      it "shows the error message 'Please enter your email address' "
    end
    context "with valid input" do 
      it "redirect to sign in page"
      it "shows the error message 'Your email input is invalid' " 
    end
    context "with invalid input" do 
      it "redirect to reset password page"
      it "generate the token for that email's owner"
      it "sends out the email with the right content"
    end
  end
end