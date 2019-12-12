<template>
  <div id="app">
    <locations-search v-on:filter-locations="handleSearch"></locations-search>
    <div id="nav">
      <router-link class="icons" :to="{ name: 'home' }" exact><img src="@/assets/logoIcon.png"/></router-link>
      <router-link class="icons" :to="{ name: 'profile' }" exact><img src=@/assets/user.png/></router-link>
      <router-link class="icons" :to="{ name: 'NearbyLocations' }" exact><img src="@/assets/gpsButton.png"/></router-link>
    </div>
    <router-view class="content"/>
    <div id="silhouette">
        <img src="@/assets/silhouette.svg"/>
    </div>
  </div>
</template>

<script>
import LocationsSearch from '@/components/LocationsSearch.vue';
import NearbyLocationsList from '@/components/NearbyLocationsList.vue';
import Register from '@/views/Register.vue';
import Login from '@/views/Login.vue';
import Details from '@/components/Details.vue';
import Profile from '@/views/Profile.vue';

export default {
  name: 'app',
  components: {
      LocationsSearch,
      NearbyLocationsList,
      Register,
      Login,
      Details,
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
  #app {
    margin-top: 40px;
    z-index: -101
  }

  #silhouette img {
    width: 100%;
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: -100;
  }

  #nav {
    margin-top: 40px;
    text-align: right;
    position:fixed; right:10px; top:10px;
  }

  #nav .icons {
    display: block;
    
  }

  #nav img {
      width: 10%;
      -webkit-filter: drop-shadow(4px 4px 25px rgba(0,0,0,0.5));
    }

  #nav img:hover {
    opacity: 60%;
  }

</style>