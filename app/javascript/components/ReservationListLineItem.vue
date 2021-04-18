<template>
  <div>
    <template v-if="reservation">
      <div>
        <div
          v-bind:id="'reservation-list-line-item_' + reservation.id"
          class="reservation-list-line-item"
          v-bind:class="{'not_reserved': isNotReserved, 'senior_over_65': isSeniorOver65, 'senior_over_60': isSeniorOver60, 'other': isOther}"
          v-on:mouseover="$emit('reservation-hover', reservation ? reservation.id : null)"
        ></div>
        <b-tooltip
          v-bind:target="'reservation-list-line-item_' + reservation.id"
          triggers="hover">
          {{reservation.name}} / {{reservation.age}} 歳
        </b-tooltip>
      </div>
    </template>
    <template v-else>
      <div
        class="reservation-list-line-item"
        v-bind:class="{'not_reserved': isNotReserved, 'senior_over_65': isSeniorOver65, 'senior_over_60': isSeniorOver60, 'other': isOther}"
        v-on:mouseover="$emit('reservation-hover', reservation ? reservation.id : null)"
      ></div>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    reservation: {
      type: Object
    },
  },
  computed: {
    isNotReserved() {
      return !this.reservation
    },
    isSeniorOver65() {
      return !this.isNotReserved && this.reservation.age >= 65
    },
    isSeniorOver60() {
      return !this.isNotReserved && this.reservation.age >= 60
    },
    isOther() {
      return !this.isNotReserved && !this.isSeniorOver65 && !this.isSeniorOver60
    },
  }
}
</script>

<style scoped>
  .reservation-list-line-item {
    width: 12px;
    height: 12px;
    margin-right: 2px;
    border: solid 1px darkblue;
  }
  .not_reserved {
    background-color: snow; 
  }
  /* .health-care-worker {
    background-color: cornflowerblue;
  } */
  .senior_over_65 {
    background-color: khaki;
  }
  /* .patient {
    background-color: palegreen;
  } */
  /* .caregiver {
    background-color: blueviolet;
  } */
  .senior_over_60 {
    background-color: cyan;
  }
  .other {
    background-color: blue;
  }

</style>