require 'spec_helper'

describe Event do
  context 'イベントがない状態から' do
    describe 'ユーザを作る' do
      before :all do
        FactoryGirl.create(:user)
      end
      it 'イベントが7つできているはず' do
        expect(Event.all.count).to eq 7
      end
      it '登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).count_registers
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it 'のべ3人ログインしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).cumulative_users
        expect(recs).to match_array [0, 0, 1, 0, 1, 0, 1, 0, 0]
      end
      it '3回ログインしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).unique_users
        expect(recs).to match_array [0, 0, 1, 0, 1, 0, 1, 0, 0]
      end
      it '1回相談しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).counsel_counts
        expect(recs).to match_array [0, 0, 0, 0, 0, 1, 0, 0, 0]
      end
      it '1人相談しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).counsel_users
        expect(recs).to match_array [0, 0, 0, 0, 0, 1, 0, 0, 0]
      end
      it '1回チケット購入しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).ddq_purchases
        expect(recs).to match_array [0, 0, 0, 500, 0, 0, 0, 0, 0]
      end
      it '1人プロ版にアップグレードしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).pro_purchases
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 800, 0]
      end
    end
  end
end
