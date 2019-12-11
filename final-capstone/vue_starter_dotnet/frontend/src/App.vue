<template>
  <div id="app">
    <router-view></router-view>
    <!-- <register></register>
    <list-locations></list-locations>
    <locations-search v-on:filter-locations="handleSearch"></locations-search>
    <div id="nav">
      <router-link class="icons" :to="{ name: 'home' }" exact><img src="@/assets/user.png"/></router-link>
      <router-link class="icons" :to="{ name: 'NearbyLocations' }" exact><img src="@/assets/trophy.png"/></router-link>
    </div>
    <router-view class="content"/>
    <div id="silhouette">
        <img src="@/assets/silhouette.svg"/>
    </div>
  </div>
</template>

<script>
import LocationsSearch from '@/components/LocationsSearch.vue';
import ListLocations from '@/components/ListLocations.vue';
import Register from '@/views/Register.vue';

export default {
  name: 'app',
  components: {
      LocationsSearch,
      ListLocations,
      Register
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
    }

  #nav img:hover {
    opacity: 60%;
  }

</style>