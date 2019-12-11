<template>  <!--Creating template for each location-->
    <div class="nearbylocations">
        <h1>Nearby Locations</h1>
        <nearby-locations-list/>           
    </div>
</template>

<script>
import NearbyLocationsList from '@/components/NearbyLocationsList'

export default {
    name: 'nearbyLocations',
    components: {
        NearbyLocationsList
    }
}
</script>

<style scoped>

</style>
