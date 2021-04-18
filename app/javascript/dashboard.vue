<template>
  <div id="app">
    <div id="calendar-title">
      <h3>
        <a v-on:click="prev_month"><i class="fas fa-arrow-circle-left"></i></a>
        {{ target_month.format('YYYY年MM月') }}
        <a v-on:click="next_month"><i class="fas fa-arrow-circle-right"></i></a>
      </h3>
    </div>
    <div id="calendar-title">
      <div class="row">
        <div class="d-flex col-12">
          <div class="calender_item_width text-center">日</div>
          <div class="calender_item_width text-center">月</div>
          <div class="calender_item_width text-center">火</div>
          <div class="calender_item_width text-center">水</div>
          <div class="calender_item_width text-center">木</div>
          <div class="calender_item_width text-center">金</div>
          <div class="calender_item_width text-center">土</div>
        </div>
      </div>
    </div>
    <div id="calendar-body">
      <div v-for="(calendar, index) in calenders" v-bind:key="index" class="row">
        <div class="d-flex col-12">
          <div class="calender_item_width" v-for="(day, index) in calendar" v-bind:key="index">
            <template v-if="day">
              <div class="text-right">{{ day ? day.day.format('MM/DD') : '' }}</div>
              <ReservationListLine
                v-for="(list, index) in day.lists"
                v-bind:key="index"
                v-bind:time_zone="list.time_zone"
                v-bind:reservations="list.reservations"
              >
              </ReservationListLine>
            </template>
            <template v-else>
            </template>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
import axios from 'axios'

import ReservationListLine from './components/ReservationListLine'

export default {
  data: function () {
    return {
      message: `Hello Vue! ${moment().format('YYYY-MM-DD')}`,
      today: moment(),
      target_month: moment().startOf('month'),
      time_zones: ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30'],
      time_zone_unit_min: 30, // 分で指定
      reservations_count_by_unit: 10, // 30分で10人 
      reservations: []
    }
  },
  components: {
    ReservationListLine
  },
  computed: {
    start_of_month() {
      return this.target_month.clone();
    },
    end_of_month() {
      return this.start_of_month.clone().endOf('month', 'YYYY-MM-DD');
    },
    // 各週ごとの2重配列になる
    calenders() {
      let days = this.get_days_with_reservation(this.start_of_month, this.end_of_month);

      let calenders = [];
      
      // カレンダーの形に整える（カレンダーの空白部分を作成する)
      for (let i = this.start_of_month.day() - 1; i >= 0; i--){
        calenders.push(null);
      }      
      calenders = calenders.concat(days);
      for (let i = this.end_of_month.day() + 1; i < 7; i++){
        calenders.push(null);
      }

      // 各週毎の配列に変換する
      calenders = this.each_cons(calenders, 7);
      
      return calenders;
    },
    display_reservations() {
      // 対象月のデータだけに絞り込む
      return this.reservations.filter((reservation, _) => {
        let reserved_at = moment(reservation.reserved_at);
        return reserved_at.isSameOrAfter(this.start_of_month) && reserved_at.isSameOrBefore(this.end_of_month);
      });
    }
  },
  methods: {
    load_reservations() {
      const vm =  this;
      // TODO: 日付の絞り込み
      axios.get('/reservations.json')
        .then(response => {
          return response.data;
        })
        .then(data => {
          vm.reservations = data;
        });
    },
    get_days_with_reservation(start_date, end_date) {
      let days = [];
      for (let day = start_date; day <= end_date; day = day.clone().add(1, 'day')){
        let lists = [];
        // 1日分の予約情報をセットする
        this.time_zones.forEach((time_zone, _) => {
          let base = moment(`${day.clone().format('YYYY-MM-DD')} ${time_zone}`, 'YYYY-MM-DD HH:mm');
          let reservations = this.display_reservations
            .filter((reservation) => {
              let reserved_at = moment(reservation.reserved_at);
              // 前後15分以内はその時間に含める
              return reserved_at.isSameOrAfter(base.clone().subtract(this.time_zone_unit_min / 2, 'minutes')) && 
                reserved_at.isSameOrBefore(base.clone().add(this.time_zone_unit_min / 2, 'minutes'))
            });

          // もし定員に足りない場合はnullをセットする
          for (let i = reservations.length; i < this.reservations_count_by_unit; i++) {
            reservations.push(null);
          }

          lists.push({
            time_zone: time_zone,
            reservations: reservations
          })
        });
        days.push({
          day: day,
          lists: lists
        });
      }
      return days;
    },
    each_cons(array, n){
      return array.reduce(
        (a, e, i) => i % n ?
            [...a.slice(0, a.length-1), [...a[a.length-1], e] ]
            :
            [...a, [e]]
        ,[]
      )
    },
    prev_month() {
      this.target_month = this.target_month.clone().subtract(1, 'month');
    },
    next_month() {
      this.target_month = this.target_month.clone().add(1, 'month');
    }
  },
  mounted() {
    this.load_reservations();
  },
}
</script>

<style scoped>
.calender_item_width {
  width: 14.28%;
}
</style>
