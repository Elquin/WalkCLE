<template>
<div>
    <gmap-map id="map"
    :center="center" 
    :zoom="15"
    >
    
    <gmap-marker v-for="m in markers" v-bind:key="m.position" :position="m.position"/>
    </gmap-map>
    <p>{{location.name}}</p>
    <p>{{location.longDescription}}</p>
    <p>{{location.address}}</p>
    <p>{{location.phoneNumber}}</p>
    <p>{{location.websiteURL}}</p>
    <p>{{location.priceLevel}}</p>
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
          }
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