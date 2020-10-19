require 'rails_helper'

RSpec.describe UserSessions, type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context '入力値が正常' do
      it 'ログインが成功する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: '123456789'
        click_button 'login'
      end
    end
    context '入力値が異常' do
      it 'ログインに失敗する'do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        click_button 'login'
      end
    end
  end
end