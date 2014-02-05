require 'spec_helper'

describe CategorizeController do

  describe "GET 'next'" do
    it "returns http success" do
      get 'next'
      response.should be_success
    end
  end

  describe "GET 'choose'" do
    it "returns http success" do
      get 'choose'
      response.should be_success
    end
  end

  describe "GET 'wrong'" do
    it "returns http success" do
      get 'wrong'
      response.should be_success
    end
  end

end
