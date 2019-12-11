<template>
  <div class="flex-container">
    <div class="flex-section" v-for="location in locationsList" v-bind:key="location.name">
      <div class="flex-image"><img src="@/assets/trophy.png"/></div>
        <div class="flex-details">
          <ul>
              <li>
                  <h3>{{location.name}}</h3>
                  <p>{{location.shortDescription}}</p>
                  <p>{{location.address}}</p>
              </li>
          </ul>
        </div>
    </div>
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
    .flex-container {
      display: flex;
      flex-direction: row;
    }

    .flex-section {
      flex-basis: 100px;
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


