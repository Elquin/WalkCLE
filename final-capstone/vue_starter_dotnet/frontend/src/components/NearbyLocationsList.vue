<template>
  <div class="flex-container">
    <div class="flex-item" v-for="location in locationsList" v-bind:key="location.name">
      <div class="location-image"><img src="@/assets/location-image.jpg"/></div>
          <ul>
              <li>
                  
                  <h3>{{location.name}}</h3>
                  <p>{{location.shortDescription}}</p>
                  <p>{{location.address}}</p>
              </li>
          </ul>
    </div>
  </div>
</template>

<script>
export default {
    name: 'nearby-locations-list',
    data(){
        return {
            locationsList: [],
            closestLocationsList: [],
            userLocation: null
        }
    },
    created() {
        this.fetchLocations();
        this.fetchUserLocation();
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
        fetchLocations(){
            fetch(`${process.env.VUE_APP_REMOTE_API}/locations`).then(
                (resp) => {
                if (resp.ok) {
                    resp.json().then(
                    (data) => {
                        this.locationsList = data;
                        console.log(this.locationsList);
                    }
                    )
                } else {
                    console.log(`Error: ${resp.status} ${resp.statusText}`)
                }
                }
            ).catch(
                (err) => {
                console.log(err);
                }
            )
        },
        getDistanceFromLatLonInMi(lat1,lon1,lat2,lon2) {
          var R = 6371; // Radius of the earth in km
          var dLat = deg2rad(lat2-lat1);  // deg2rad below
          var dLon = deg2rad(lon2-lon1); 
          var a = 
            Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
            Math.sin(dLon/2) * Math.sin(dLon/2)
            ; 
          var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
          var d = R * c; // Distance in km
          return d * 1.609344;
        },
        deg2rad(deg) {
          return deg * (Math.PI/180)
        },
        sortLocationsByDistanceFromUser(){
          
        }
    }
}
</script>

<style scoped>

    .flex-container {
      display: flex;
      align-items: center;
      flex-direction: column;
    }

    .flex-item {
      background-color: white;
      width: 40%;
      display: flex;
      box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    }

    .flex-item:hover {
      background-color: rgb(235, 235, 235);
    }

    .flex-item ul {
      list-style-type: none;
      width: 60%;
      padding-left: 0px;
    }

    .location-image{
      width: 40%;
      padding: 20px;
    }

    .location-image img {
      width: 100%;
      height: auto;
      box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
      
    }



    /* div {
      margin: 20px;
    }
    
    ul {
      list-style-type: none;
      width: 33%;
      margin: auto;
    }
    
    li img {
      float: left;
      margin: 0 15px 0 0;
      width: 20%;
    }
    
    li h3 {
      font: bold 20px/1.5 Helvetica, Verdana, sans-serif;
    }

    li p {
      font: 200 12px/1.5 Georgia, Times New Roman, serif;
    }
    
    li {
      padding: 10px;
      overflow: auto;
      background: white;
      box-shadow: 3px 3px 10px 0px rgba(0,0,0,0.3);
    }
    
    li:hover {
      background: #eee;
      cursor: pointer;
    } */
</style>


