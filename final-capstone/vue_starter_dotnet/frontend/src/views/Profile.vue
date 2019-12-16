<template>
  <div class="grid-container">
    <div class="portrait">
        <div class="portrait-top">
            <img src="@/assets/user.png">
        </div>
        <h3>{{ User.Username }}</h3>
    </div>
    <div class="history-card">
        <div class="history-title"><h3>Location History</h3></div>
            <div class="history-content">
                <ul>
                    <li>Location 1</li>
                    <li>Location 2</li>
                    <li>Location 3</li>
                    <li>Location 4</li>
                </ul>
            </div>
    </div>
    <div class="badges-card">
        <div class="badges-title"><h3>Badges</h3></div>
            <div class="badges-content">
                <ul>
                    <li>Badge 1</li>
                    <li>Badge 2</li>
                    <li>Badge 3</li>
                    <li>Badge 4</li>
                </ul>
            </div>
    </div>
  </div>
</template>

<script>


</script>


<style scoped>
/* #region Content */
.grid-container {
    margin-top: 40px;
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
    border-radius: 10px;
    grid-area: portrait;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

.portrait-top {
    width: 100%;
    background-image: url('../assets/clevedt.jpg');
    background-size: 100%;
    background-position:bottom;
    border-radius: 10px 10px 0px 0px;
}

.portrait-top > img {
    width: 20%;
}

.portrait h3 {
    margin: 10px;
}

.history-card {
    background-image: url('../assets/map.png');
    border-radius: 10px;
    grid-area: history;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    opacity: 95%;
}

.history-title {
    border-radius: 10px 10px 0px 0px;
    background: linear-gradient(to top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    padding: 2px 0px 2px 0px;
}

.history-content {
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    height: 100%;
    border-radius: 10px;
}

.history-content ul {
    list-style-type: none;
    padding-left: 0px;
}


.badges-card {
    background-image: url('../assets/trophybkgd.png');
    border-radius: 10px;
    grid-area: badges;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    opacity: 95%;
}

.badges-title {
    border-radius: 10px 10px 0px 0px;
    background: linear-gradient(to top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    padding: 2px 0px 2px 0px;
}

.badges-content {
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    height: 100%;
    border-radius: 10px;
}

.badges-content ul {
    list-style-type: none;
    padding-left: 0px;
}


/* #endregion Content */
</style>

