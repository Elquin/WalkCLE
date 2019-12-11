<template>
<div>
    <p>location lat: {{userLocation.coords.latitude}}</p>
    <p>location long: {{userLocation.coords.longitude}}</p>
    <ul>
        <li v-for="location in locationsList" v-bind:key="location.name">
            <p>{{location.name}}</p>
            <p>{{location.address}}</p>
        </li>
    </ul>
</div>
</template>

<script>
export default {
    name: 'list-locations',
    data(){
        return {
            locationsList: [],
            userLocation: null
        }
    },
    created() {
        this.fetchLocations();

        this.fetchUserLocation();

        this.directionsTest();
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
        directionsTest(){
            fetch(`https://maps.googleapis.com/maps/api/directions/json?origin=41.4973,-81.6933&destination=41.500670,-81.680910&mode=walking&units=imperial&key=AIzaSyA8qsiApLrQeAAIrs-Rx8lGQHOxa_lxHc0`).then(
                (resp) => {
                    if (resp.ok) {
                        resp.json().then(
                            (data) => {
                                this.directions = data;
                                console.log(this.directions);
                            }
                        )
                    }else {
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
    div{
        margin-top: 300px;
    }
</style>