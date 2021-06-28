require 'rails_helper'

RSpec.describe Task, type: :model do
  
  context "validation tests" do
    let!(:each) do
      @user = User.new(name: "Example User", email: "user@example.com",
        tel: "0912345678", password: '123456', password_confirmation: '123456') 
    end

    it "ensures title presence" do
      task = Task.new(id: 1, content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 0, status: 0, user: @user).save
      expect(task).to eq(false)
    end

    it "ensures start & end presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', priority: 0, status: 0, user: @user).save
      expect(task).to eq(false)
    end

    it "ensures priority & status presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week), user: @user).save
      expect(task).to eq(false)
    end

    it "should save successfully" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 0, status: 0, user: @user).save
      expect(task).to eq(true)
    end

    it "ensures start < end time" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: (DateTime.now + 1.week), endtime: DateTime.now, priority: 0, status: 0, user: @user).save
      expect(task).to eq(false)
    end
  end


end
