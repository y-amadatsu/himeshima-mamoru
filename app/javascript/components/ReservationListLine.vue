<template>
  <div class="reservation-list-line row align-items-center">
    <div class="col-3 text-right pr-1">{{ time_zone }}</div>
    <div class="col-9 pl-2">
      <div class="d-flex">
        <ReservationListLineItem
          v-for="(reservation, index) in reservations"
          v-bind:key="index"
          v-bind:reservation="reservation"
          v-on:reservation-hover="hover(reservation ? reservation.id : null)"
        />
      </div>
    </div>
  </div>
</template>

<script>

import ReservationListLineItem from './ReservationListLineItem'

export default {
  props: {
    time_zone: {
      type: String,
      required: true
    },
    reservations: {
      type: Array,
      required: true
    },
  },
  components: {
    ReservationListLineItem
  },
  methods: {
    hover: function(id) {
      if (id) {
        let reservation = this.reservations.find(reservation => reservation.id === id);
        console.log(`name: ${reservation.name}`);
        console.log(`age: ${reservation.age}`);
      }
    }
  },
}
</script>
