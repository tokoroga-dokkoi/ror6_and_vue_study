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
                >
                    <v-list-item-icon>
                        <v-icon>{{ item.icon }}</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>{{ item.title }}</v-list-item-title>
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
                <v-btn mx-2 px-2 text>Home</v-btn>
                <v-btn mx-2 px-2 text>Login</v-btn>
                <v-btn mx-2 px-2 text>Sign Up</v-btn>
            </v-toolbar-items>
        </v-toolbar>
    </div>
</template>
<script>
export default {
    name: "Header",
    data: () => ({
        drawer: false,
        items: [
            { title: 'Home', icon: "mdi-home-city" },
            { title: 'Login', icon: "mdi-account-check" },
            { title: 'SignUp', icon: "mdi-account-plus" }
        ]
    })
}
</script>