<template>
<div>
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
    div{
        margin-top: 300px;
    }
</style>