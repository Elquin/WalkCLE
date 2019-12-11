<template>
  <div class="nearbylocations-list">
      <ul>
          <li v-for="location in locationsList" v-bind:key="location.name">
            <img src="@/assets/trophy.png"/>
              <h3>{{location.name}}</h3>
              <p>{{location.shortDesc}}</p>
              <p>{{location.address}}</p>
          </li>
      </ul>
  </div>
</template>

<script>
export default {
    name: 'nearby-locations-list',
    data(){
        return {
            locationsList: []
        }
    },
    created() {
        this.fetchLocations()
    },
    methods: {
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
        }
    }
}
</script>

<style scoped>
    div {
      margin: 20px;
    }
    
    ul {
      list-style-type: none;
      width: 550px;
      margin: auto;
    }
    
    h3 {
      font: bold 20px/1.5 Helvetica, Verdana, sans-serif;
    }
    
    li img {
      float: left;
      margin: 0 15px 0 0;
      width: 20%;
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
    }
</style>


