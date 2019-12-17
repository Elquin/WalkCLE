<template>
  
  <div id="envelope">
    <!-- <div id="cover"></div> -->
    <div class="grid-container">
      <div id="heading"><h3>{{location.name}}</h3></div>
      <!-- DropDown not registering -->
      <div id="floating-panel">
      <b>Mode of Travel: </b>
      <select id="mode">
        <option value='WALKING'>Walking</option>
        <option value='DRIVING'>Driving</option>
      </select>
      </div>
      <div id="map-container"></div>
      <div id="directions-box"></div>
        <!-- <gmap-map id="map" :center="center" :zoom="13">
              <gmap-marker v-for="m in markers" v-bind:key="m.position" :position="m.position"/>
        </gmap-map>
      </div> -->
      <div class="details-card">
              <div class="details-content">
                  <ul id="details-list">
                      <li class="description">{{location.longDescription}}</li>
                      <li><img class="icon" src="@/assets/icons/marker.png"/> {{location.address}}</li>
                      <li><img class="icon" src="@/assets/icons/phone.png"/> {{location.phoneNumber}}</li>
                      <li><img class="icon" src="@/assets/icons/globe.png"/> <a :href="location.websiteURL">{{location.websiteURL}}</a></li>
                      <li><img id="money" v-for="n in location.priceLevel" v-bind:key="n.priceLevel" src="@/assets/money.png"/></li>
                      <div id="checkin-button" >
                              <button v-on:click="checkIn()">
                          Check In
                        </button>
                      </div>
                  </ul>
              </div>
      </div>
    </div>
    <div id="map-container"></div>
    <div id="directions-box"></div>
      <!-- <gmap-map id="map" :center="center" :zoom="13">
            <gmap-marker v-for="m in markers" v-bind:key="m.position" :position="m.position"/>
      </gmap-map>
    </div> -->
    <div class="details-card">
            <div class="details-content">
                <ul>
                    <li class="description">{{location.longDescription}}</li>
                    <li><img class="icon" src="@/assets/icons/marker.png"/> {{location.address}}</li>
                    <li><img class="icon" src="@/assets/icons/phone.png"/> {{location.phoneNumber}}</li>
                    <li><img class="icon" src="@/assets/icons/globe.png"/> <a :href="location.websiteURL">{{location.websiteURL}}</a></li>
                    <li><img id="money" v-for="n in location.priceLevel" v-bind:key="n.priceLevel" src="@/assets/money.png"/></li>
                    <div id="checkin-button" >
                            <button id="checkin-message" v-on:click="checkIn()" v-if="!isHidden">
                        Check In
                      </button>
                      <p v-if="isHidden">You checked in at {{location.name}}</p>
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
        center: {},
        location: {},
        map: '',
        userLat: '',
        userLong: '',
        locationAddress:'',
        isHidden: false
      };
  },
  mounted () {
    // this.fetchUserLocation();
    // this.createMap();
    // this.getLocation(this.$route.params.id);
  },
  created() {
    // this.getLocation(this.$route.params.id);
    this.fetchUserLocation();
    // this.isHidden = false
    // this.createMap();
  },
  methods: {
    checkIn(){
        this.location.locationId = this.location.id;
        this.isHidden = true;
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
      this.getLocation(this.$route.params.id);
      // this.createMap();
    },
    getLocation(id) {
        fetch(`${process.env.VUE_APP_REMOTE_API}/locations/${id}`)
        .then((response) => {
          if(response.ok) {
            response.json().then(
              (data) => {
                this.location = data;
                console.log(this.location);
                this.locationAddress = data.address;
                console.log('Location Name 1: ' + this.locationAddress);
                this.createMap();
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
        const userLocation = new google.maps.LatLng(this.userLat, this.userLong);
        console.log('Location Name 2: ' + this.locationAddress);
        const directionsRenderer = new google.maps.DirectionsRenderer;
        const directionsService = new google.maps.DirectionsService;

        console.log("map: ", google.maps)
            this.map = new google.maps.Map(document.getElementById('map-container'), {
            center: userLocation,
            scrollwheel: true,
            zoom: 9,
            mapTypeControlOptions: {
              style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
              mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain']
              }
            })

        directionsRenderer.setMap(this.map);
        directionsRenderer.setPanel(document.getElementById('directions-box'));
        
        this.calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation);

        //Need to Fix
        // document.getElementById('mode').addEventListener("change", function() {
        //   this.calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation);
        // });

    },
    calculateAndDisplayRoute(directionsService, directionsRenderer, userLocation){
        const destinationLatlng = this.locationAddress;
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
    margin-top: 80px;
    display: grid;
    -webkit-filter: drop-shadow(2px 2px 8px rgba(0,0,0,0.5));
    grid-column-gap: 0px;
    grid-row-gap: 0px;
    grid-template-columns: 1fr 2fr 2fr 1fr;
    grid-template-rows: 3fr 2fr;
    grid-template-areas: 
        '. map directions .'
        '. details details .';
        
}

#floating-panel {
  display: none;
}

/* #cover {
  background-color: #f2f2f2;
  text-align: center;
  line-height: 0px;
  margin: auto;
  left: 0;
  right: 0;
  width: 70%;
  height: 40px;
  position: fixed;
  margin-top: -80px;
  z-index: 55;
} */

#heading {
  background-image: url('../assets/nearby-tab-background.png');
  text-align: center;
  line-height: 0px;
  margin: auto;
  left: 0;
  right: 0;
  width: 67%;
  height: 40px;
  position: fixed;
  border-radius: 2px 2px 2px 2px;
  box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
  margin-top: -40px;
  z-index: 55;
}

#map-container {
    
    /* had to comment out z-index for drop-down to work; */
    /* z-index: 51; */
    background-color: white;
    grid-area: map;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    height:455px;
    margin: 0px; /* increase if you want spacing between grids */
}

#directions-box {
  z-index: 51;
  grid-area: directions;
  background-color: white;
  height:455px;
  overflow-y:scroll;
  margin: 0px;
  }

/* #map {
    width: 100%;
    height: 100%;
} */

.details-card {
    z-index: 51;
    background-color: white;
    border-radius: 0px 0px 3px 3px;
    grid-area: details;
    text-align: center;
    margin: 0px; /* increase if you want spacing between grids */
    overflow-y:scroll;
    height: 300px;
    position:relative;
}

::-webkit-scrollbar {
    width: 0px;
    background: transparent; /* make scrollbar transparent */
}

.details-content ul {
    list-style-type: none;
    width: 100%;
    position:absolute; top:40%; height:10em; margin-top:-5em;
}

#details-list {
  padding-left: 0px;
}

.description {
  margin-top: 15px;
  margin-bottom: 15px;
}

.icon {
  width: 20px;
}

#money {
  width: 30px;
  margin-top: 5px;
}

#checkin-button {
  margin-top: 15px;
  padding-top: 0px;
}

#checkin-button button{
  background-color: #5f0101;
  border: none;
  color: white;
  padding: 15px 32px;
  margin-top: 0px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
}

#checkin-button:hover button{
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
  cursor: pointer;
  padding: 13px 29px;
}

#checkin-button:active button{
  padding: 11px 27px;
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