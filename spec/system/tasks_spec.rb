require 'rails_helper'

RSpec.describe Tasks, type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'タスクの新規作成' do
      context 'タスクの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          visit new_task_path
          fill_in 'title', with: 'title'
          fill_in 'content', with: 'content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: Deadline.new(2021, 1, 1, 10, 00)
          click_button 'Create Task'
          expect(page).to have_content 'Title: title'
          expect(page).to have_content 'Content: content'
          expect(page).to have_content 'Status: doing'
          expect(page).to have_content 'Deadline: 2021/1/1 10:00'
          expect(page).to eq 'task1'
        end
      end

      context 'タイトルの入力値が空白' do
        it 'タスクの新規作成が失敗する' do
          visit new_task_path
          fill_in 'title', with: ''
          fill_in 'content', with: 'content'
          click_button 'Create Task'
          expect(page).to have_content 'タイトルを入力してください'
          visit new_task_path
        end
      end
      
      context 'コンテンツの入力値が空白' do 
        it 'タスクの新規作成が失敗する' do
          visit new_task_path
          fill_in 'title', with: 'title'
          fill_in 'content', with: ''
          click_button 'Create Task'
          expect(page).to have_content 'コンテンツを入力してください'
          visit new_task_path
        end
      end
    end

    describe 'タスクの編集' do
      context 'タスクの入力値が正常' do
        it 'タスクの編集が成功する' do
          let(:task) { create(:task) }
          visit edit_task_path(edit)
          fill_in 'title', with: 'title'
          fill_in 'content', with: 'content'
          click_button 'Create Task'
          expect(page).to have_content 'title: title'
          expect(page).to have_content 'content: content'
          expect(page).to eq 'task1'
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの編集が失敗する' do
          let(:task) { create(:task) }
          visit edit_task_path(edit)
          fill_in 'title', with: ''
          fill_in 'content', with: 'content'
          click_button 'Create Task'
          expect(page).to have_content 'タイトルを入力してください'
          visit edit_task_path(task)
        end
      end
    end

    describe 'タスクの削除' do
      context 'タスクの削除が成功' do
        it 'タスクの削除が成功する' do
          let(:task) { create(:task) }
          visit tasks_path
          click_link 'Destroy'
          expect(task.destroy).to be_valid
        end
      end
    end
  end
end