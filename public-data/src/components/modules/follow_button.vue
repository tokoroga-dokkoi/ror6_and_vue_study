<template>
    <v-btn
        class="ma-2"
        color="blue lighten-2"
        v-if="!user.following"
        @click="follow()"
    >
        フォローする
        <v-icon dark right>
            mdi-account-plus
        </v-icon>
    </v-btn>
    <v-btn
        class="ma-2"
        color="blue lighten-2"
        v-else
        @click="unfollow()"
    >
        フォローを外す
        <v-icon dark right>
            mdi-account-minus
        </v-icon>
    </v-btn>
</template>
<script>
export default {
    props: ["user"],
    methods: {
        follow(){
            this.$emit('follow')
        },
        unfollow() {
            this.$emit('unfollow')
        }
    }
}
</script>