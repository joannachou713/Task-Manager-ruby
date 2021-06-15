require 'rails_helper'

RSpec.describe Task, type: :model do
  
  context "validation tests" do
    it "ensures title presence" do
      task = Task.new(id: 1, content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 0, status: 0).save
      expect(task).to eq(false)
    end

    it "ensures start & end presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', priority: 0, status: 0).save
      expect(task).to eq(false)
    end

    it "ensures priority & status presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week)).save
      expect(task).to eq(false)
    end

    it "should save successfully" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 0, status: 0).save
      expect(task).to eq(true)
    end

    it "ensures start < end time" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: (DateTime.now + 1.week), endtime: DateTime.now, priority: 0, status: 0).save
      expect(task).to eq(false)
    end
  end


end
