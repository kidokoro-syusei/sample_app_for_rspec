require 'rails_helper'

RSpec.describe Users, type: :system do
  describe 'ログイン前' do
    describe 'ユーザーの新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          let(:user) { bulid(:user) }
          expect(user).to be_valid
        end
      end
      context 'フォームの入力値が異常' do
        it 'メールアドレスが未入力の時新規作成に失敗' do
          let(:user) { bulid(:user, :email nil) }
          expect(user).to be_invalid
          expect(user.error[:email]).to eq ["が未入力です"]
        end
        it '登録済メールアドレス使用時にユーザーの新規登録' do
          user = create[:user]
          let(:user) { build(:user) }
          expect(user).to be_invalid
          expect(user.error[:email]).to eq ["はすでに存在しています"]
        end
      end
    end
  end  
  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          let(:user) { bulid(:user) }
          expect(user).to be_valid
        end
      end
      context 'メールアドレスが未入手' do
        it 'ユーザーの編集が失敗する' do
          let(:user) { bulid(:user, :email nil) }
          expect(user.error[:email]).to eq ["が未入力です"]
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          user = create[:user]
          let(:user) { bulid(:user) }
          expect(user).to be_invalid
          expect(user.error[:email]).to eq ["はすでに存在しています"]
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it 'ユーザーの編集が失敗する' do
          user = create[:user]
          let(:user) { bulid(:user) }
        end
      end
    end
  end
end