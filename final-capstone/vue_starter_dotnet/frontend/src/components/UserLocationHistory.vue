<template>
    <div class="history">
        <p>Placeholder History</p>
    </div>
</template>

<script>
export default {
    name: 'user-location-history',
    data(){
        return {
            userLocationsList: [],
        }
    },
    created() {
        this.fetchLocations();
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
        },
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
</style>


