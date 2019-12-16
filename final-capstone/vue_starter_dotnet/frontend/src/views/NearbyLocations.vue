<template>  <!--Creating template for each location-->
    <div class="container">
        <locations-search v-on:filter-locations="handleSearch"></locations-search>
        <div class="nearbylocations">
            <h1>Nearby Locations</h1>
            <nearby-locations-list v-bind:search="search" />           
        </div>
    </div>
</template>

<script>
import NearbyLocationsList from '@/components/NearbyLocationsList'

export default {
    name: 'nearbyLocations',
    components: {
        NearbyLocationsList
    },
      data() {
    return {
      search: ''
    }
  },

    methods: {
        handleSearch(query) {
            console.log('Filter Locations: ', query);
            this.search = query;
      }
  }
}
</script>

<style scoped>

.nearbylocations > h1{
    background-image: url('../assets/nearby-tab-background.png');
    text-align: center;
    margin: auto;
    left: 0;
    right: 0;
    width: 42%;
    position: fixed;
    border-radius: 15px 15px 5px 5px;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    margin-top: -4px;

}



</style>
