<template>
  <div id="app">
    <div id="nav">
      <router-link :to="{ name: 'home' }" tag="li" exact>>Home</router-link>
      <router-link :to="{ name: 'NearbyLocations' }" tag="li" exact>>NearbyLocations</router-link>
    </div>
    <router-view class="content"/>
  </div>
</template>
