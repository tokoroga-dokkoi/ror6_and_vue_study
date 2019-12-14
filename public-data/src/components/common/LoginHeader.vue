<template>
    <div>
        <v-navigation-drawer
            v-model="drawer"
            absolute
            temporary
        >
            <v-list dense>
                <v-list-item
                    v-for="item in items"
                    :key="item.title"
                    :to="item.to"
                >
                    <v-list-item-icon>
                        <v-icon>{{ item.icon }}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>{{ item.title }}</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
                <v-list-item
                    @click="logout"
                >
                    <v-list-item-icon>
                        <v-icon>mdi-logout</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>ログアウト</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>
        <v-toolbar dark color="primary" fixed>
            <v-app-bar-nav-icon
                @click.stop="drawer = !drawer"
                class="hidden-md-and-up"
            >
            </v-app-bar-nav-icon>
            <v-toolbar-title class="headline text-uppercase white--text">
                <span class="font-weight-light">Run Is Fun!!</span>
            </v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-items class="hidden-sm-and-down">
                <v-btn mx-2 px-2 text to="/home">マイページ</v-btn>
                <v-btn mx-2 px-2 text to="/signup">過去の投稿をみる</v-btn>
                <v-btn mx-2 px-2 text @click="logout">ログアウト</v-btn>
            </v-toolbar-items>
        </v-toolbar>
    </div>
</template>
<script>
export default {
    name: "LoginHeader",
    data: () => ({
        drawer: false,
        items: [
            { title: 'マイページ', icon: "mdi-home-city", to: '/home' },
            { title: '過去の投稿', icon: "mdi-account-check", to:'/home' },
            { title: 'つながりを作る', icon: "mdi-human-handsup", to:'/home' }
        ]
    }),
    methods: {
        logout() {
            const payload = {
                router: this.$router
            }
            this.$store.dispatch('auth/logout', payload, {root: true})
        }
    }
}
</script>