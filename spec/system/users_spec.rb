require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザーの新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          fill_in 'Email', with: 'email@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content 'User was successfully created.'
          expect(current_path).to eq login_path
        end
      end
      context 'メールアドレスが未入力' do
        it '新規作成に失敗' do
          visit new_user_path
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content '1 error prohibited this user from being saved'
          expect(page).to have_content "Email can't be blank"
          expect(current_path).to eq users_path
        end
      context '登録済メールアドレス使用時のユーザーの新規登録'
        it '新規登録に失敗' do
          existed_user = create[:user]
          visit new_user_path
          fill_in 'Email', with: existed_user.email
          fill_in 'Password', with: 'password'
          expect(user).to have_content 'Email has already been taken'
          expect(page).to have_field 'Email', with: existed_user.email
        end
      end
    end
    describe 'マイページ' do
      context 'ログイン前にマイページに転移' do
        it 'マイページへの転移に失敗' do
          visit user_path(user)
          expect(page).to have_content 'Login required'
          expect(current_path).to eq login_path
        end
      end
    end
  end  
  describe 'ログイン後' do
    before { login_as(user) }
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          fill_in 'Email', with: 'update@example.com'
          fill_in 'Password', with: 'update_password'
          fill_in 'Password confirmation', with: 'update_password'
          click_button 'Update'
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(user)
        end
      end
      context 'メールアドレスが未入手' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: nil
          fill_in 'Password', with: 'update_password'
          fill_in 'Password confirmation', with: 'update_password'
          click_button 'Update'
          expect(page).to have_content('1 error prohibited this user from being saved')
          expect(page).to have_content("Email can't be blank")
          expect(current_path).to eq user_path(user)
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          other_user = create(:user)
          fill_in 'Email', with: 'other_user.email'
          fill_in 'Password', with: 'password'
          fill_in 'password_confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content('1 error prohibited this user from being saved')
          expect(page).to have_content("そのEmailはすでに存在しています")
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it 'ユーザーの編集が失敗する' do
          other_user = create(:user)
          visit edit_user_path(other_user)
          expect(page).to have_content('編集ページにはアクセスできません')
          expect(current_path).to eq user_path(user) 
        end
      end
    end
  end
end