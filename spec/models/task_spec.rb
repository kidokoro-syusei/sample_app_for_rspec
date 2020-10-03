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
      FactoryBot.create(:task, title: "kidokoro")
      task = FactoryBot.build(:task, title: "kidokoro")
      task.valid?
      expect(task.errors[:title].to include("はすでに存在しています"))
    end
    it 'ステータスが必須項目であること' do
      task = Task.new(status: nil)
      task.valid?
      expect(task.errors[:status]).to_not include("を入力してください")
    end
  end
end
