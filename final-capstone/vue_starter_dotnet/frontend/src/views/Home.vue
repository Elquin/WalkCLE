<template>
  <div class="flex-container">
    <div class="message-box">
      <h1>Hello User!</h1>
      <h3>We have so many places to explore today!</h3>
      <p>Click on "Nearby Locations" or enter a location in the search bar above to get started.</p>
    </div>
    <div class="nearby-button"><img src="@/assets/gpsButton.png"/></div>
  </div>
</template>

<script>
export default {
  name: 'home'
}
</script>


<style scoped>

  .message-box {
    background-color: white;
    width: 40%;
    margin: auto;
    text-align: center;
    padding: 5px;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
  }

  .message-box > h1 {
    color: #607c85;
  }

</style>

