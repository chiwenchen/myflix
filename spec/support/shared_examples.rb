shared_examples 'require_sign_in' do 
  it 'redirect_to front_videos_path' do 
    session[:user_id] = nil
    action
    expect(response).to redirect_to front_videos_path
  end
end

shared_examples 'generates_token' do 
  it 'generates_toekn' do 
    object.generate_token
    expect(object.token).to be_present
  end
end