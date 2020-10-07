require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end
    it 'タイトルが必須項目であること' do
      task_without_title = FactoryBot.build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to eq ["を入力してください"]
    end
    it '同じタイトルが存在しないこと' do
      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to eq ["はすでに存在してます"]
    end  
    it 'ステータスが必須項目であること' do
      task = Task.new(status: nil)
      task_without_status.to be_invalid
      expect(task_without_status.errors[:status]).to_not eq ["を入力してください"]
    end
    it 'タイトルは違う名前であること' do
      task = create(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end
  end
end
