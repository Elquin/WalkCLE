<template>
<div>
    <gmap-map id="map"
    :center="center" 
    :zoom="13"
    >
    
    <gmap-marker v-for="m in markers" v-bind:key="m.position" :position="m.position"/>
    </gmap-map>
    <p>Name: {{location.name}}</p>
    <p>Description: {{location.longDescription}}</p>
    <p>Address: {{location.address}}</p>
    <p>Phone Number: {{location.phoneNumber}}</p>
    <p>Website: {{location.websiteURL}}</p>
    <p>Price Level: {{location.priceLevel}}</p>
  </div>
</template>

<script>


export default {
    name: 'details-page',
    data() {
    return {
      center: {  },
      markers: [{
          position: {
              lat: 41.503370,
              lng: -81.639050
          },
      }],
      location: [],
    };
  },

  created() {
    this.geolocate();
    this.getLocation(this.$route.params.id);
  },

  methods: {
    geolocate() {
      navigator.geolocation.getCurrentPosition(position => {
        this.center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
      });
    },
    getLocation(id) {
        fetch(`${process.env.VUE_APP_REMOTE_API}/locations/${id}`)
        .then((response) => {
          if(response.ok) {
            response.json().then(
              (data) => {
                this.location = data;
                console.log(this.location);
              }
            )
          } else {
            console.log(`Error: ${response.status} ${response.statusText}`)
          }
        }).catch(
          (err) => {
          console.log(err);
          }
        )
    }
  }
}
</script>

<style>
#map {
    width:300px;  
    height: 300px;
}

</style>