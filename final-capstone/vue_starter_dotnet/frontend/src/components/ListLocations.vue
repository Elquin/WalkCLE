<template>
<div></div>
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
            fetch(`https://localhost:44392/api/locations`).then(
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

</style>