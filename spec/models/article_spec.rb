require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '記事新規投稿' do
    context '新規投稿できるとき' do
      it 'image・title・contentが存在すれば登録できる' do
        expect(@article).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'imageが空では登録できない' do
        @article.image = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("Image can't be blank")
      end
      it 'titleが空では登録できない' do
        @article.title = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空では登録できない' do
        @article.content = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("Content can't be blank")
      end
    end
  end
end
