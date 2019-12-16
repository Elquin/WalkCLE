<template>
  
  <div class="grid-container">
    <div id="map-container"></div>
    <div id="directions-box"></div>
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
    <div class="checkin-button" >
      <button v-on:click="checkIn()">
        Check In
      </button>
    </div>
  </div>
</template>

<script>
import auth from '@/auth';
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
        location: {}
      };
  },
  mounted: function() {
    this.createMap();
  },
  created() {
    this.fetchUserLocation();
    this.getLocation(this.$route.params.id);
    
  },
  methods: {
    checkIn(){
        this.location.locationId = this.location.id;
        fetch(`${process.env.VUE_APP_REMOTE_API}/checkin`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',         //remember to do
            Authorization: 'Bearer ' + auth.getToken(),  //remember to do
          },
          body: JSON.stringify(this.location),
        })
          .then((response) => {
            if (response.ok) {
              //this.$router.push({ path: `/` });
            }
          })
          .catch((err) => console.error(err));
      
    },
    fetchUserLocation(){
            navigator.geolocation.getCurrentPosition(pos => {
                this.userLocation = pos;
                let userLat = this.userLocation.coords.latitude;
                let userLong = this.userLocation.coords.longitude;
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
        var myLatlng1 = new google.maps.LatLng(41.503370, -81.639050);
        var directionsRenderer = new google.maps.DirectionsRenderer;
        var directionsService = new google.maps.DirectionsService;
        console.log("map: ", google.maps)
            this.map = new google.maps.Map(document.getElementById('map-container'), {
            center: myLatlng1,
            scrollwheel: true,
            zoom: 15,
            mapTypeControlOptions: {
              style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
              mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain']
              }
            })
        directionsRenderer.setMap(this.map);
        directionsRenderer.setPanel(document.getElementById('directions-box'));
        var marker = new google.maps.Marker({
          position: myLatlng1,
          map: this.map
        });
    }         
  }
}
</script>

<style scoped>
/* #map {
    width:300px;  
    height: 300px;
} */

.grid-container {
    
    display: grid;
    grid-column-gap: 10px;
    grid-row-gap: 10px;
    grid-template-columns: 1fr 2fr 2fr 1fr;
    grid-template-rows: 4fr 3fr;
    grid-template-areas: 
        '. map directions .'
        '. details details .';
        
}


#map-container {
    /* z-index: -50; */
    background-color: white;
    border-radius: 10px;
    grid-area: map;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    
}

#directions-box {
  grid-area: directions;
}

/* #map {
    width: 100%;
    height: 100%;
} */

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