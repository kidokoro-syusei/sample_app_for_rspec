require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it "has a valid factory" do
      expect(FactoryBot.build(:task)).to be_valid
    end
    it 'タイトルが必須項目であること' do
      task = FactoryBot.build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to_not include("を入力してください")
    end
    it 'タイトルはユニークであること' do
      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
    end  
    it 'ステータスが必須項目であること' do
      task = Task.new(status: nil)
      task.valid?
      expect(task.errors[:status]).to_not include("を入力してください")
    end
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

  end
end
