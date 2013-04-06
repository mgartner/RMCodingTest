describe "Application 'CodingTest'" do
  it "has one window" do
    user_current = User.current
    module_user = SomeModule::User.new
    module_user.herpderp = "goodbye"

    user = User.new
    user.name = "hello"
    user.save

    user_current = User.current
    user_current.should.not == nil
    true.should == true
  end
end
