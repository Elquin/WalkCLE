<template>
  <div class="flex-container">
    <div class="message-box">
      <h1>Hello User!</h1>
      <h3>We have so many places to explore today!</h3>
      <p>Click on "Nearby Locations" or enter a location in the search bar above to get started.</p>
    </div>
    <div class="nearby-button"><router-link :to="{ name: 'NearbyLocations' }" exact><img src="@/assets/gpsButton.png"/><h2 id="nearby-location-text">NEARBY LOCATIONS</h2></router-link></div>
  </div>
</template>

<script>
export default {
  name: 'profile'
}
</script>


<style scoped>


</style>

