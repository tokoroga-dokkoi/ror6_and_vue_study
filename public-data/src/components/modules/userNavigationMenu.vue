<template>
    <v-navigation-drawer
        permanent
        :fixed="positionY > 64"
        :width="calcMaxWidth"
    >
        <template v-slot:prepend>
            <v-list-item two-line>
                <v-list-item-avatar>
                    <v-icon>
                        mdi-car
                    </v-icon>
                </v-list-item-avatar>
                <v-list-item-content class="hidden-sm-and-down">
                    <v-list-item-title>sample</v-list-item-title>
                    <v-list-item-title>Logged In </v-list-item-title>
                </v-list-item-content>
            </v-list-item>
        </template>
        <v-divider></v-divider>
        <v-list dense>
            <v-list-item
                v-for="item in items"
                :key="item.title"
            >
                <v-list-item-icon>
                    <v-icon
                        :color="item.color"
                    > 
                        {{ item.icon }} 
                    </v-icon>
                </v-list-item-icon>
                <v-list-item-content class="hidden-sm-and-down">
                    <v-list-item-title> {{ item.title }}</v-list-item-title>
                </v-list-item-content>
            </v-list-item>
        </v-list>
    </v-navigation-drawer>
</template>
<script>
export default {
    data: () => ({
        items: [
            { title: 'ホーム', icon: 'mdi-home', color:'' },
            { title: '通知をみる', icon: 'mdi-bell-outline', color:'' },
            { title: 'メッセージ', icon: 'mdi-message', color:'' },
            { title: 'プロフィール', icon: 'mdi-face', color:''},
            { title: '投稿する', icon: 'mdi-comment-plus-outline', color:'blue darken-3'}
        ],
        positionY: 0
    }),
    computed: {
        calcMaxWidth() {
            return this.positionY > 64 ? '20%' : 'auto'
        }
    },
    mounted() {
        window.addEventListener('scroll', this.handleScroll)
    },
    methods: {
        handleScroll() {
            this.positionY = window.scrollY
        }
    }
}
</script>
