require 'spec_helper'

describe Event do
  context 'イベントがない状態から' do
    describe 'ユーザを作ったら' do
      before :all do
        FactoryGirl.create(:user_for_event)
        user = User.first
        user.gender = '男'
        user.birthday = Date.new(1965, 7, 28)
        user.occupation = '会社員（総合職）'
        user.height = 174
        user.initial_weight = 108
        user.current_weight = 95.2
        # user.loss_rate = 11.8
        # user.initial_bmi = 35.6
        # user.current_bmi = 31.4
        user.meal_custom = '食事にほぼ毎回気を使っている'
        user.exercising_custom = 'ほとんど運動しない'
        user.save!
      end
      it 'イベントが7つできているはず' do
        expect(Event.all.count).to eq 7
      end
      it '登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).count_registers(nil)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it 'のべ3人ログインしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).cumulative_users(nil)
        expect(recs).to match_array [0, 0, 1, 0, 1, 0, 1, 0, 0]
      end
      it '3回ログインしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).unique_users(nil)
        expect(recs).to match_array [0, 0, 1, 0, 1, 0, 1, 0, 0]
      end
      it '1回相談しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).counsel_counts(nil)
        expect(recs).to match_array [0, 0, 0, 0, 0, 1, 0, 0, 0]
      end
      it '1人相談しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).counsel_users(nil)
        expect(recs).to match_array [0, 0, 0, 0, 0, 1, 0, 0, 0]
      end
      it '1回チケット購入しているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).ddq_purchases(nil)
        expect(recs).to match_array [0, 0, 0, 500, 0, 0, 0, 0, 0]
      end
      it '1人プロ版にアップグレードしているはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        recs = Event::Counter.new(from, to).pro_purchases(nil)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 800, 0]
      end
      it '検索範囲を今日までにしたら、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            register_date_end: d
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '検索範囲を1ヶ月前から今日までにしたら、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            register_date_begin: d << 1,
            register_date_end: d
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '検索範囲を昨日までにしたら、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            register_date_end: d - 1
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '検索範囲を明日からにしたら、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            register_date_begin: d + 1
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '性別=男で、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            gender: '男',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '性別=女だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            gender: '女',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が50歳までだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_max: 50
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が45〜50歳だと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_min: 45,
            age_max: 50
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が45〜48歳だと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_min: 45,
            age_max: 48
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が48〜50歳だと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_min: 48,
            age_max: 50
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が48歳だと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_min: 48,
            age_max: 48
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が45歳以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_max: 45
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '年齢が50歳以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            age_min: 50
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '職業が会社員（総合職）だと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            occupation: '会社員（総合職）'
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '職業がその他だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            occupation: 'その他'
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '身長が170〜180cmだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            height_min: 170,
            height_max: 180
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '身長が170以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            height_max: 170,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '身長が180以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            height_min: 180
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期体重が100〜110kgだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            initial_weight_min: 100,
            initial_weight_max: 110,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期体重が100以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            initial_weight_max: 100,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期体重が110以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            initial_weight_min: 110,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在体重が90〜100kgだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            current_weight_min: 90,
            current_weight_max: 100,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在体重が90以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            current_weight_max: 90,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在体重が100以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            current_weight_min: 100,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期BMIが35〜40kgだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            initial_bmi_min: 35,
            initial_bmi_max: 40,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期BMIが35以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            initial_bmi_max: 35,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '初期BMIが40以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            initial_bmi_min: 40,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在BMIが30〜35kgだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            register_date_begin: d << 1,
            register_date_end: d,
            gender: '男',
            age_min: 45,
            age_max: 50,
            occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            current_bmi_min: 30,
            current_bmi_max: 35,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在BMIが30以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            current_bmi_max: 30,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '現在BMIが35以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            current_bmi_min: 35,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '減量度が-12〜-10kgだと、登録イベントが1つあるはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            loss_rate_min: -12,
            loss_rate_max: -10,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '減量度が-10以上だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            loss_rate_min: -10,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '減量度が-12以下だと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            loss_rate_max: -12,
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it '食事にほぼ毎回気を使っているだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            meal_custom: '食事にほぼ毎回気を使っている',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '食事に気を使っていないだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            meal_custom: '食事に気を使っていない',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it 'ほとんど運動しないだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            # meal_custom: '食事にほぼ毎回気を使っている',
            exercising_custom: 'ほとんど運動しない',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it '時々運動しているだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            # meal_custom: '食事にほぼ毎回気を使っている',
            exercising_custom: '時々運動している',
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
      it 'プロ版に契約していないだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            # meal_custom: '食事にほぼ毎回気を使っている',
            # exercising_custom: 'ほとんど運動しない',
            contract: '未契約'
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 1, 0, 0, 0, 0, 0, 0, 0]
      end
      it 'プロ版に契約しているだと、登録イベントがないはず' do
        from = Date.new(2000, 1, 1)
        to = Date.new(2000,1,9)
        d = Date.today
        params = {
            # register_date_begin: d << 1,
            # register_date_end: d,
            # gender: '男',
            # age_min: 45,
            # age_max: 50,
            # occupation: '会社員（総合職）',
            # height_min: 170,
            # height_max: 180,
            # initial_weight_min: 100,
            # initial_weight_max: 110,
            # current_weight_min: 90,
            # current_weight_max: 100,
            # initial_bmi_min: 35,
            # initial_bmi_max: 40,
            # current_bmi_min: 30,
            # current_bmi_max: 35,
            # loss_rate_min: -12,
            # loss_rate_max: -10,
            # meal_custom: '食事にほぼ毎回気を使っている',
            # exercising_custom: 'ほとんど運動しない',
            contract: '契約'
        }
        recs = Event::Counter.new(from, to).count_registers(params)
        expect(recs).to match_array [0, 0, 0, 0, 0, 0, 0, 0, 0]
      end
    end
  end
end
