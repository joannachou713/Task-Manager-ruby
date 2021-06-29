require 'rails_helper'

RSpec.describe Task, type: :model do
  
  context "validation tests" do
    let!(:user) { build(:user) }
    let!(:task) { build(:task, user: user) }

    it "ensures title presence" do
      task.title = ''
      expect(task.save).to eq(false)
    end

    it "ensures start & end presence" do
      task.start = ''
      task.endtime = ''
      expect(task.save).to eq(false)
    end

    it "ensures priority & status presence" do
      task.priority = ''
      task.status = ''
      expect(task.save).to eq(false)
    end

    it "should save successfully" do
      expect(task.save).to eq(true)
    end

    it "ensures start < end time" do
      task.start = (DateTime.now + 1.week)
      task.endtime = DateTime.now
      expect(task.save).to eq(false)
    end
  end


end
