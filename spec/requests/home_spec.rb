require 'rails_helper' # rails_helper で定義した設定を読み込み
 
RSpec.describe 'Home', type: :request do # テスト対象モジュールとテストの種類
  describe 'GET /' do # テストする機能に関する説明
    it 'HTTP ステータス 200 を返す' do # どういう結果を期待しているか
      get '/' # 確認したい操作: / というパスに GET でリクエストを投げる
      expect(response).to have_http_status(200) # 期待する確認結果
    end
  end
end