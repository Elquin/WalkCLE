<template>
  
  <div class="grid-container">
    <div id="map-container"></div>
      <!-- <gmap-map id="map" :center="center" :zoom="13">
            <gmap-marker v-for="m in markers" v-bind:key="m.position" :position="m.position"/>
      </gmap-map>
    </div> -->
    <div class="details-card">
        <div class="location-title"><h3>{{location.name}}</h3></div>
            <div class="details-content">
                <ul>
                    <li class="description">{{location.longDescription}}</li>
                    <li><img class="icon" src="@/assets/icons/marker.png"/> {{location.address}}</li>
                    <li><img class="icon" src="@/assets/icons/phone.png"/> {{location.phoneNumber}}</li>
                    <li><img class="icon" src="@/assets/icons/globe.png"/> <a :href="location.websiteURL">{{location.websiteURL}}</a></li>
                    <li><img id="money" v-for="n in location.priceLevel" v-bind:key="n.priceLevel" src="@/assets/money.png"/></li>
                </ul>
            </div>
    </div>
  </div>
</template>

<script>
export default {
    name: 'details-page',
    data() {
    return {
      markers: [{
          position: {
              lat: 41.503370,
              lng: -81.639050
          },
      }],
      location: {},

    };
  },
  mounted: function() {
    this.createMap()
  },
  created() {
    this.fetchUserLocation();
    this.getLocation(this.$route.params.id);
    
  },
  methods: {
    fetchUserLocation(){
            navigator.geolocation.getCurrentPosition(pos => {
                this.userLocation = pos;
                console.log(this.userLocation);
            }, err => {
                this.errorStr = err.message;
            })
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
    },
    createMap() {
        
        var userLocation = new google.maps.LatLng(this.markers[0].position.lat, this.markers[0].position.lng);
        console.log("map: ", google.maps)
            this.map = new google.maps.Map(document.getElementById('map-container'), {
            center: userLocation,
            scrollwheel: true,
            zoom: 15,
            disableDefaultUI: true
            }) 
        var marker = new google.maps.Marker({
          position: userLocation,
          map: this.map,
          draggable: true,
          animation: google.maps.Animation.DROP,
        });     
  }
  }
 
}
</script>

<style scoped>
#map {
    width:300px;  
    height: 300px;
}

.grid-container {
    
    display: grid;
    grid-column-gap: 10px;
    grid-row-gap: 10px;
    grid-template-columns: 1fr 2fr 2fr 1fr;
    grid-template-rows: 4fr 3fr;
    grid-template-areas: 
        '. map map .'
        '. details details .';
        
}


#map-container {
    z-index: -50;
    background-color: white;
    border-radius: 10px;
    grid-area: map;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

#map {
    width: 100%;
    height: 100%;
}

.details-card {
    z-index: -50;
    background-color: white;
    border-radius: 10px;
    grid-area: details;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    opacity: 95%;
}

.details-content ul {
    list-style-type: none;
    padding-left: 0px;
}

.description {
  margin-bottom: 15px;
}

.icon {
  width: 20px;
}

#money {
  width: 30px;
  margin-top: 5px;
}

</style>