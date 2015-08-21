require 'spec_helper'

describe ForgetPasswordController do 
  describe "POST create" do 

    context "with blank input" do 
      it "render forget password page" do 
        get :create, email: ""
        expect(flash[:danger]).to eq("Please enter your email address")
      end
      it "shows the error message 'Please enter your email address' " do 
        get :create, email: ""
        expect(response).to redirect_to forget_password_path
      end
    end

    context "with valid input" do 
      before do 
        @user = Fabricate(:user, name: 'sammy', email: 'sammy@example.com')
        get :create, email: 'sammy@example.com'
      end

      it "redirect to confirm password page" do 
        expect(response).to redirect_to confirm_reset_password_path
      end 
      it "generate the token for that email's owner" do 
        expect(@user.reload.token).not_to be_blank
      end
      it "sends out the email with the right content" do 
        expect(ActionMailer::Base.deliveries.last.to).to eq(["sammy@example.com"])
      end
    end

    context "with invalid input" do 
      before do 
        @user = Fabricate(:user, name: 'sammy', email: 'sammy@example.com')
        get :create, email: 'invalid@gmail.com'
      end

      it "render forget password page" do 
        expect(response).to redirect_to forget_password_path
      end
      it "shows the error message 'Your email input is invalid' " do 
        expect(flash[:danger]).to eq("Your email enter is invalid")
      end
    end
  end

  describe "POST reset_password" do 
    context "with valid password input" do 
      before do 
        @sammy = Fabricate(:user, token: '12345')
        post :reset_password, token: '12345', new_password: 'new_password'
      end

      it "redirect to sign_in page" do 
        expect(response).to redirect_to signin_path
      end
      it "retrive the right user" do 
        expect(assigns(:user)).to eq(@sammy)
      end
      it "reset the user's password" do 
        expect(@sammy.reload.authenticate("new_password")).to be_truthy
      end
      it "shows the success message" do 
        expect(flash[:success]).to eq("You changed the password, please log in with new password")
      end
      it "clear the user's token" do 
        expect(@sammy.reload.token).to be_blank
      end
    end

    context "with invalid password input" do 
      before do 
        @sammy = Fabricate(:user, token: '12345')
        post :reset_password, token: '12345', new_password: ''
      end

      it "show the error message" do 
        expect(flash[:danger]).not_to  be_blank
      end
      it "redirect to reset password page" do 
        expect(response).to redirect_to reset_password_page_path(token: @sammy.token)
      end
    end
  end
end