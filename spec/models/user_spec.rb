# frozen_string_literal: true

require 'rails_helper'

describe '実際に保存してみる' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
context "空白のバリデーションチェック" do
  it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    user = User.new(name: '', email: 'example@example.com', password: 'password')
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    user = User.new(name: 'hoge', email: '', password: 'password')
    expect(user).to be_invalid
    expect(user.errors[:email]).to include("can't be blank")
  end
end

describe "アソシエーションのテスト" do
  context "Postモデルとの関係" do
    it "1:Nとなっている" do
      expect(User.reflect_on_association(:posts).macro).to eq :has_many
    end
  end
  context "Favoriteモデルとの関係" do
    it "1:Nとなっている" do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end
  end
  context "PostCommentモデルとの関係" do
    it "1:Nとなっている" do
      expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
    end
  end
end