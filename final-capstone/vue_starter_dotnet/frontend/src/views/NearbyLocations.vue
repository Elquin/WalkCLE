<template>  <!--Creating template for each location-->
    <div class="container">
        <locations-search v-on:filter-locations="handleSearch"></locations-search>
        <div class="nearbylocations">
            <h1>Nearby Locations</h1>
            <nearby-locations-list v-bind:search="search" ></nearby-locations-list>
        </div>
    </div>
</template>

<script>
import NearbyLocationsList from '@/components/NearbyLocationsList'
import LocationsSearch from '@/components/LocationsSearch'

export default {
    name: 'nearby-locations',
    components: {
        NearbyLocationsList,
        LocationsSearch
    },
      data() {
    return {
      search: ''
    }
  },

    methods: {
        handleSearch(query) {
            console.log('NearbyLocations query: ', query);
            this.search = query;
      }
  }
}
</script>

<style scoped>

.container {
  margin-top: 40px;
}

.nearbylocations > h1{
    background-image: url('../assets/nearby-tab-background.png');
    text-align: center;
    margin: auto;
    left: 0;
    right: 0;
    width: 40.5%;
    position: fixed;
    border-radius: 0px 0px 2px 2px;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    margin-top: -4px;

}



</style>
