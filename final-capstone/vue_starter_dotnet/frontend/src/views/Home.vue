<template>
  <div class="flex-container">
    <!-- <video class="video" width="320" height="240" loop autoplay>
      <source src="@/assets/video.mp4" type="video/mp4">
    </video> -->
    <div class="message-box">
      <h1>Welcome to WalkCLE</h1>
      <h3>We have so many places to explore today!</h3>
      <p>Click on "Nearby Locations" to begin your journey.</p>
    </div>
    <div class="nearby-button"><router-link :to="{ name: 'NearbyLocations' }" exact><img src="@/assets/gpsButton.png"/><h2 id="nearby-location-text">NEARBY LOCATIONS</h2></router-link></div>
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
    width: 30%;
    margin: auto;
    margin-top: 60px;
    text-align: center;
    padding: 5px;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    border-radius: 2px;
  }

  .message-box > h1 {
    color: #607c85;
    margin-bottom: 0px;
  }

  .message-box > h3 {
    margin-bottom: 0px;
    margin-top: 10px;
  }

  .message-box > p {
    margin-top: 0px;
  }

  .nearby-button {
    width: 40%;
    margin: auto;
    text-align: center;
  }

  .nearby-button img {
    width: 50%;
    margin-top: 30px;
    -webkit-filter: drop-shadow(6px 6px 25px rgba(0,0,0,0.5));
  }

  .nearby-button img:hover {
    width: 55%;
  }

  .nearby-button img:active {
    width: 50%;
  }

  #nearby-location-text {
    margin-top: 0px;
    color: black;
  }

  a:link {
    text-decoration: none;
  }

  a:visited {
    text-decoration: none;
  }

  a:hover {
    text-decoration: none;
  }

  a:active {
    text-decoration: none;
  }

</style>

