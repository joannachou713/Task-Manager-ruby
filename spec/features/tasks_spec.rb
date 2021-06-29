require 'rails_helper'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.feature "Tasks", type: :feature do
  context "create new tasks" do
    let!(:label) { build(:label) }

    let!(:login) do
      label.save
      sign_in

      visit new_task_path
      within('form') do
        choose 'task_priority_2'
        choose 'task_status_0'
        check 'label test'
      end
    end


    scenario "should be successful" do
      within('form') do
        fill_in 'task_title', with: 'new task test'
        fill_in 'task_start', with: DateTime.now
        fill_in 'task_endtime', with: DateTime.now+1.week
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('flash.task.successful-create'))
    end
    
    
    scenario "should fail" do
      click_button 'commit'
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end


    scenario "failed (end<create)" do
      within('form') do
        fill_in 'task_start', with: DateTime.now
        fill_in 'task_endtime', with: DateTime.now-1.week
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('flash.task.end_start'))
    end
  end


  context "update tasks" do
    scenario "should be successful" do
      sign_in
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now,
        endtime: (DateTime.now + 1.week), priority: 0, status: 0, user: User.first)
      visit edit_task_path(task)
      within('form') do
        fill_in 'task_title', with: '測試修改'
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('flash.task.successful-update'))
      expect(page).to have_content('測試修改')
    end
  end
  
  
  context "destory tasks" do
    scenario "should be successful" do
      sign_in
      task = Task.create(id: 1, title: 'title', content: 'string', start: DateTime.now,
        endtime: (DateTime.now + 1.week), priority: 0, status: 0, user: User.first)
      visit tasks_path
      expect{ click_link 'delete-1' }.to change(Task, :count).by(-1)
      expect(page).to have_content(I18n.t('flash.task.successful-delete'))
    end
  end


  context "sort tasks" do
    let!(:login) do
      sign_in
      task = Task.create(id: 0, title: 'title0', content: 'string', created_at: DateTime.now+1.hour,
        start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 0, status: 1, user: User.first)
      task1 = Task.create(id: 1, title: 'title1', content: 'string', created_at: DateTime.now,
        start: DateTime.now, endtime: (DateTime.now + 1.week), priority: 1, status: 0, user: User.first)
    end

    scenario "search by title" do
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)

      within('form') do
        fill_in 'q_title_cont', with: 'title1'
      end
      click_button 'search'
      expect(page).to have_no_content(/title0/)
    end

    scenario "filter by status" do
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)

      within('form') do
        select(I18n.t('show.status')[0], :from => 'q_status_eq')
      end
      click_button 'search'
      expect(page).to have_no_content(/title0/)
    end

    scenario "sort by creation time" do
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)
      
      click_link I18n.t('show.created')
      expect(page).to have_content(/title1.+title0/)
    end

    scenario "sort by priority" do
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)
      
      click_link I18n.t('show.priority-text')
      expect(page).to have_content(/title1.+title0/)
    end

    scenario "sort by status" do
      visit tasks_path
      expect(page).to have_content(/title0.+title1/)
      
      click_link I18n.t('show.status-text')
      expect(page).to have_content(/title1.+title0/)
    end
  end
  

end
