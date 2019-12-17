<template>
  <div id="app">
    <div id="container">
      <!-- <locations-search class="search-bar" v-on:filter-locations="handleSearch"></locations-search> -->
      <div id="nav">
        <div id="icon1">
          <router-link class="icons" :to="{ name: 'home' }" exact><img src="@/assets/logoIcon.png"/></router-link>
        </div>
        <div id="icon2">
          <router-link class="icons" :to="{ name: 'profile' }" exact><img src=@/assets/user.png/></router-link>
        </div>
        <div id="icon3">
          <router-link class="icons" :to="{ name: 'NearbyLocations' }" exact><img src="@/assets/gpsButton.png"/></router-link>
        </div>
      </div>
      <router-view class="content"/>
      <div id="silhouette">
          <img src="@/assets/silhouette.svg"/>
      </div>
    </div>
  </div>
</template>

<script>
import LocationsSearch from '@/components/LocationsSearch.vue';
import NearbyLocationsList from '@/components/NearbyLocationsList.vue';
import Register from '@/views/Register.vue';
import Login from '@/views/Login.vue';
import DetailsPage from '@/components/DetailsPage.vue';
import Profile from '@/views/Profile.vue';

export default {
  name: 'app',
  components: {
      LocationsSearch,
      NearbyLocationsList,
      Register,
      Login,
      DetailsPage,
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
  .search-bar {
    z-index: 100;
  }

  #container {
    position: absolute;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    z-index: -102;
  }

  #app {
    margin-top: 40px;
    z-index: 50;
  }


  #silhouette img {
    width: 100%;
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: -100;
    /* Silhouette shadow yes/no? */
    -webkit-filter: drop-shadow(2px 2px 8px rgba(0,0,0,0.5));
    
  }

  #nav {
    margin-top: 40px;
    position:fixed; right:10px; top:10px;
    padding: 0px;
    width: 95px;
  }

  #nav #icon1 {
    text-align: right;
  }

  #nav #icon2 {
    text-align: right;
  }

  #nav #icon3 {
    text-align: right;
  }

  #nav .icons {
    display: block;
  }

  #nav img {
      width: 100%;
      -webkit-filter: drop-shadow(4px 4px 25px rgba(0,0,0,0.5));
    }

  #nav img:hover {
    opacity: 60%;
  }

</style>