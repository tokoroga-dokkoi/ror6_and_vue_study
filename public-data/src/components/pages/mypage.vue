<template>
    <v-row>
        <v-col cols="3">
            <UserNavigationMenu></UserNavigationMenu>
        </v-col>
        <v-col cols="9">
            <v-row class="hidden-sm-and-down">
                <PostForm @uploaded="appendToTimelines($event)"></PostForm>
            </v-row>
            <v-row>
                <PostList :timelines="timelines" @unfollowed="removeTimeline($event)"></PostList>
            </v-row>
        </v-col>
    </v-row>
</template>

<script>
import UserNavigationMenu from '../modules/userNavigationMenu'
import PostForm from '../modules/postForm'
import PostList from '../modules/postList'
import requests from '../../utils/request'

export default {
    data: () => ({
        timelines: [],
        posted: {}
    }),
    created() {
        const options = {
            auth: true
        }
        const url     = process.env.VUE_APP_API_URL_BASE ?
                        process.env.VUE_APP_API_URL_BASE + '/mypage' :
                        '/api/v1/mypage'
        requests.get(url, options).then( (response) => {
            this.timelines = response.data
        }).catch( (error) => {
            console.error(error)
        })
    },
    methods: {
        appendToTimelines(eventArgs){
            console.log(eventArgs)
            this.timelines.unshift(eventArgs)
        },
        removeTimeline(unfollowedUser){
            this.timelines = this.timelines.filter( timeline => timeline.timeline.user_id !== unfollowedUser)
        }
    },
    components: {
        UserNavigationMenu,
        PostForm,
        PostList
    }
}
</script>
