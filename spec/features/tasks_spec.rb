require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  context "create new tasks" do
    before(:each) do
      visit new_task_path
      within('form') do
        choose 'task_priority_2'
        choose 'task_status_0'
      end
    end


    scenario "should be successful" do
      within('form') do
        fill_in 'task_title', with: 'new task test'
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('successful-create'))
    end
    
    
    scenario "should fail" do
      click_button 'commit'
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end


  context "update tasks" do
    scenario "should be successful" do
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      visit edit_task_path(task)
      within('form') do
        fill_in 'task_title', with: '測試修改'
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('successful-update'))
      expect(page).to have_content('測試修改')
    end
  end
  
  
  context "destory tasks" do
    scenario "should be successful" do
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      visit tasks_path
      expect{ click_link I18n.t('delete') }.to change(Task, :count).by(-1)
      expect(page).to have_content(I18n.t('successful-delete'))
    end
  end


  context "sort tasks" do
    scenario "sort by creation time" do
      task = Task.create(id: 1, title: 'title1', content: 'string', created_at: DateTime.now, start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      task1 = Task.create(id: 0, title: 'title0', content: 'string', created_at: DateTime.now+1.hour, start: DateTime.now, end: (DateTime.now + 1.week), priority: 0, status: 0)
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)
      
      visit sort_create_url
      expect(page).to have_content(/title1.+title0/)
    end
  end
  

end
