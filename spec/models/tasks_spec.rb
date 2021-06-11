require 'rails_helper'

RSpec.describe Task, type: :model do
  
  context "validation tests" do
    it "ensures title presence" do
      task = Task.new(id: 1, content: 'string', start: 'datetime', end: 'datetime', priority: 0, status: 0).save
      expect(task).to eq(false)
    end

    it "ensures start & end presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', priority: 0, status: 0).save
      expect(task).to eq(false)
    end

    it "ensures priority & status presence" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week)).save
      expect(task).to eq(false)
    end

    it "should save successfully" do
      task = Task.new(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0).save
      expect(task).to eq(true)
    end
  end


end
