require 'spec_helper'

describe Invitation do 
  it_behaves_like 'generates_token' do 
    let(:object){Fabricate(:invitation)}
  end
end