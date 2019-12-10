<template>
  <div id="app">
    <locations-search v-on:filter-locations="handleSearch"></locations-search>
    <div id="nav">
      <router-link :to="{ name: 'home' }" tag="li" exact>>Home</router-link>
      <router-link :to="{ name: 'NearbyLocations' }" tag="li" exact>>NearbyLocations</router-link>
    </div>
    <router-view class="content"/>
    <div id="silhouette">
        <img src="@/assets/silhouette.png"/>
    </div>
  </div>
</template>

<script>
import LocationsSearch from '@/components/LocationsSearch';

export default {
  name: 'app',
  components: {
      LocationsSearch,
      
  },
  methods: {
      handleSearch(query) {
          console.log('Filter Tasks: ', query);
          this.search = query;
      }
  }
}
</script>

<style scoped>
  #silhouette img {
    width: 100%;
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: -100;
  }
</style>