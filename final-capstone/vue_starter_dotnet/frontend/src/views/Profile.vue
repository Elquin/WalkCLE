<template>
  <div class="grid-container">
    <div class="portrait">
        <img src="@/assets/user.png">
        <h3>Samantha</h3>
    </div>
    <div class="history">
        <p>Placeholder History</p>
    </div>
    <div class="badges">
        <p>Placeholder Badge</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'profile'
}
</script>


<style scoped>

.grid-container {
    display: grid;
    grid-column-gap: 10px;
    grid-row-gap: 10px;
    grid-template-columns: 1fr 2fr 2fr 1fr;
    grid-template-rows: 1fr 3fr;
    grid-template-areas: 
        '. portrait portrait .'
        '. history badges .';
}

.portrait {
    background-color: white;
    border-radius: 15px;
    grid-area: portrait;
    text-align: center;
    padding: 5px;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

.history {
    background-color: white;
    border-radius: 15px;
    grid-area: history;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

.badges {
    background-color: white;
    border-radius: 15px;
    grid-area: badges;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

.portrait > img {
    width: 20%;
}


</style>

