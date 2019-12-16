<template>  <!--Creating template for each location-->
    <div>
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

.nearbylocations > h1{
    text-align: center;
    margin: auto;
    left: 0;
    right: 0;
    width: 650px;
}

</style>
