class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # URLパラメータのidを使ってユーザーを検索
    @posts = @user.posts.order(created_at: :desc) # ユーザーに紐づく投稿を新しい順に取得
    @post_count = @posts.count # 投稿の総数を計算
  end
end