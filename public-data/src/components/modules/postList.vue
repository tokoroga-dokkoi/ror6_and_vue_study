<template>
    <div id="post">
        <PostCard
         v-for="timeline in timelines"
         :key="timeline.id"
         :timeline="timeline.timeline"
         :image="timeline.image"
        >
        </PostCard>
    </div>
</template>
<script>
import PostCard from '../modules/timeline_card'
export default {
    props: ["timelines"],
    data: () => ({
        page: 1,
    }),
    components: {
        PostCard
    }
}
</script>
<style scoped>
@media (max-width:960px){
    #post{
        width: 100%;
        margin-top: 0em;
    }
}
@media (min-width:960px){
    #post{
        width: 100%;
        margin-top: 2em;
    }
}
</style>