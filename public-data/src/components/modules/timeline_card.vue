<template>
    <v-card
        class="mr-auto mb-2"
        width="90%"
    >
        <v-list-item>
            <v-list-item-avatar color="grey"></v-list-item-avatar>
            <v-list-item-content>
                <v-list-item-title class="headline">
                    {{ user.name }}
                </v-list-item-title>
                <v-list-item-subtitle>
                    {{ timeline.created_at }}
                </v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action>
                <FollowButton :user="user" v-if="!isOwnTweet" @follow="follow" @unfollow="unFollow"></FollowButton>
            </v-list-item-action>
        </v-list-item>
        <v-img
            :src="image"
        >
        </v-img>
        <v-card-text>
            {{ timeline.content }}
        </v-card-text>
        <v-card-actions>
            <v-btn
                text
                color="deep-blue accent-4"
            >
                シェア
            </v-btn>
            <v-btn
                text
                color="deep-red accent-4"
            >
                行った!!
            </v-btn>
        </v-card-actions>
    </v-card>
</template>
<script>
import FollowButton from '../modules/follow_button'
import request from '../../utils/request'
export default {
    components: {
        FollowButton
    },
    props: ["user","timeline", "image"],
    computed: {
        isOwnTweet(){
            const uid = localStorage.getItem("uid")
            return uid === this.user.uid
        }
    },
    methods: {
        unFollow() {
            const options = {
                auth: true
            }
            const url = process.env.VUE_APP_API_URL_BASE ?
                        process.env.VUE_APP_API_URL_BASE + `/relationships/${this.timeline.user_id}` :
                        `/api/v1/relationships/${this.timeline.user_id}`
            request.delete(url, options).then( (response) => {
                console.log(response)
                this.$store.commit('message/setMessage', {'content': 'フォローを外しました'}, {root: true})
                this.$emit("unfollow", this.timeline.user_id)
            }).catch( (error) => {
                console.error(error)
                this.$store.commit('message/setMessage', {'content': 'エラーが発生しました', 'type':'error'}, {root: true})
            })
        },
        follow() {
            const params  = {
                followed_id: this.timeline.user_id
            }
            const options = {
                auth: true,
                params: params
            }
            const url     = process.env.VUE_APP_API_URL_BASE ? 
                            process.env.VUE_APP_API_URL_BASE + '/relationships' :
                            '/api/v1/relationships'
            request.post(url, options).then( (response) => {
                console.log(response)
            }).catch( (error) => {
                console.error(error)
                this.$store.commit('message/setMessage', {'content': 'フォローできませんでした', 'type': 'error'}, {root: true})
            })
        }
    }
}
</script>