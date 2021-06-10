require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  context "create new user" do
    before(:each) do
      visit new_task_path
      within('form') do
        choose '高'
        choose '進行中'
      end
    end


    scenario "should be successful" do
      within('form') do
        fill_in '任務名稱', with: 'new task test'
      end
      click_button 'Create Task'
      expect(page).to have_content('Task was successfully created')
    end
    
    
    scenario "should fail" do
      click_button 'Create Task'
      expect(page).to have_content('Title can\'t be blank')
    end
  end


  context "update user" do
    scenario "should be successful" do
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      visit edit_task_path(task)
      within('form') do
        fill_in '任務名稱', with: '測試修改'
      end
      click_button 'Update Task'
      expect(page).to have_content('Task was successfully updated')
      expect(page).to have_content('測試修改')
    end
  end
  
  
  context "destory user" do
    scenario "should be successful" do
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      visit tasks_path
      # click_link '刪除'
      expect{ click_link '刪除' }.to change(Task, :count).by(-1)
      expect(page).to have_content('Task was successfully deleted')
    end
  end
end
