require 'rails_helper'
 
RSpec.describe 'Home', type: :system do
  before do
    driven_by :rack_test
  end
 
  describe 'トップページアクセスの検証' do
    it 'Home#top という文字列が表示される' do
      visit '/'
 
      expect(page).to have_content('Home#top')
    end
  end
 
  describe 'ナビゲーションバーの検証' do
    context 'ログインしていない場合' do
      before { visit '/' }
 
      it 'ユーザー登録リンクを表示する' do
        expect(page).to have_link('ユーザー登録', href: '/users/sign_up')
      end
 
      it 'ログインリンクを表示する' do
        expect(page).to have_link('ログイン', href: '/users/sign_in')
      end
 
      it 'ログアウトリンクは表示しない' do
        expect(page).not_to have_content('ログアウト')
      end
    end
 
    context 'ログインしている場合' do
      # Factory Botを使って、テスト用のユーザーデータをデータベースに作成
      before do
        user = create(:user) # ログイン用のユーザーを作成
        sign_in user # 作成したユーザーでログイン(Deviseの認証ライブラリが提供するヘルパーメソッド)
        visit '/' # ログイン後にトップページにアクセス
      end
 
      it 'ユーザー登録リンクは表示しない' do
        expect(page).not_to have_link('ユーザー登録', href: '/users/sign_up')
      end
 
      it 'ログインリンクは表示しない' do
        expect(page).not_to have_link('ログイン', href: '/users/sign_in')
      end
 
      it 'ログアウトリンクを表示する' do
        expect(page).to have_content('ログアウト')
      end
 
      it 'ログアウトリンクが機能する' do
        click_button 'ログアウト'
 
        # ログインしていない状態のリンク表示パターンになることを確認
        expect(page).to have_link('ユーザー登録', href: '/users/sign_up')
        expect(page).to have_link('ログイン', href: '/users/sign_in')
        expect(page).not_to have_content('ログアウト')
      end
    end
  end
end