<template>
  
  <div class="grid-container">
    <div id="floating-panel">
    <b>Mode of Travel: </b>
    <select id="mode">
      <option value="WALKING">Walking</option>
      <option value="DRIVING">Driving</option>
    </select>
    </div>
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
                    <div class="checkin-button" >
                            <button v-on:click="checkIn()">
                        Check In
                      </button>
                    </div>
                </ul>
            </div>
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
        // markers: [{
        //     position: {
        //         lat: 41.503370,
        //         lng: -81.639050
        //     },
        // }],
        location: {},
        map: '',
        userLat: '',
        userLong: ''
      };
  },
  mounted () {
    // this.fetchUserLocation();
    // this.createMap();
    // this.getLocation(this.$route.params.id);
  },
  created() {
    this.fetchUserLocation();
    this.getLocation(this.$route.params.id);
    // this.createMap();
    
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
            navigator.geolocation.getCurrentPosition(this.locationSuccess, this.error, 
            {enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0} )
            // navigator.geolocation.getCurrentPosition(pos => {
                // this.userLocation = pos;
                // this.userLat = this.userLocation.coords.latitude;
                // this.userLong = this.userLocation.coords.longitude;
                // console.log('fetched location: ' + this.userLocation);
                // console.log('fetched lat: ' + this.userLat);
                // console.log('fetched long: ' + this.userLong);
            },
    error () {
      errorStr = err.message;
      },
    locationSuccess (pos){
      const crd = pos.coords;
      this.userLocation = pos;
      this.userLat = this.userLocation.coords.latitude;
      this.userLong = this.userLocation.coords.longitude;
      console.log('fetched location: ' + this.userLocation);
      console.log('fetched lat: ' + this.userLat);
      console.log('fetched long: ' + this.userLong);
      this.createMap();
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
    createMap () {
        // this.fetchUserLocation();
        // const userLocation = new google.maps.LatLng(41.503370, -81.639050);
        console.log('CreateMap User Lat: ' + this.userLat);
        console.log('CreateMap User Long: ' + this.userLong);
        const userLocation = new google.maps.LatLng(this.userLat, this.userLong);
        const directionsRenderer = new google.maps.DirectionsRenderer;
        const directionsService = new google.maps.DirectionsService;

        console.log("map: ", google.maps)
            this.map = new google.maps.Map(document.getElementById('map-container'), {
            center: userLocation,
            scrollwheel: true,
            zoom: 15,
            mapTypeControlOptions: {
              style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
              mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain']
              }
            })

        directionsRenderer.setMap(this.map);
        directionsRenderer.setPanel(document.getElementById('directions-box'));
        
        this.calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation);
        document.getElementById('mode').addEventListener('change', function() {
          this.calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation);
        });

        // const marker = new google.maps.Marker({
        //   position: userLocation,
        //   map: this.map,
        //   animation: google.maps.Animation.DROP,
        // });
    },
    calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation){
        // const destinationLatlng = 'Cleveland Botanical Garden';
        console.log('Details Name: ' + location.name)
        const destinationLatlng = 'Playhouse Square';
        const start = userLocation
        const end = destinationLatlng
        const selectedMode = document.getElementById('mode').value;
        console.log('Selected: ' + selectedMode);
        directionsService.route({
          origin: start,
          destination: end,
          // travelMode: 'WALKING',
          travelMode: google.maps.TravelMode[selectedMode]
        }, function(response, status){
          if(status === 'OK') {
            directionsRenderer.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
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
    z-index: 51;
    margin-top: 40px;
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
    
    /* had to comment out z-index for drop-down to work; */
    /* z-index: 51; */
    background-color: white;
    border-radius: 10px;
    grid-area: map;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    height:479px;
    
}

#directions-box {
  z-index: 51;
  grid-area: directions;
  background-color: white;
  height:479px;
  overflow-y:scroll;
  }





/* #map {
    width: 100%;
    height: 100%;
} */

.details-card {
    z-index: 51;
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


.checkin-button button{
  background-color: #5f0101;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
}

.checkin-button:hover button{
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
  cursor: pointer;
}



.checkin-button {
  margin-top: 50px;
  padding-top: 50px;
}
#floating-panel {
        position: absolute;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        padding-left: 10px;
      }
</style>