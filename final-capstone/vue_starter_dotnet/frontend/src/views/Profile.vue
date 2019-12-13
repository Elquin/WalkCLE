<template>
  <div class="grid-container">
    <div class="portrait">
        <img src="@/assets/user.png">
        <h3>Samantha</h3>
    </div>
    <div class="history">
        <div class="history-content">
            <p>Placeholder History</p>
        </div>
    </div>
    <div class="badges">
        <div class="badges-content">
            <p>Placeholder Badge</p>
        </div>
    </div>
  </div>
</template>

<script>


</script>


<style scoped>
/* #region Content */
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
    background-image: url('../assets/map.png');
    border-radius: 15px;
    grid-area: history;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    opacity: 95%;
}

.history-content {
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 10%, rgb(255, 255, 255) 75%);
    height: 100%;
    border-radius: 15px;
}


.badges {
    background-image: url('../assets/trophybkgd.png');
    border-radius: 15px;
    grid-area: badges;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    opacity: 95%;
}

.badges-content {
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 10%, rgb(255, 255, 255) 75%);
    height: 100%;
    border-radius: 15px;
}

.portrait > img {
    width: 20%;
}
/* #endregion Content */
</style>

