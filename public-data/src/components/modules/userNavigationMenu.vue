<template>
    <v-navigation-drawer
        permanent
        height="100vh"
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
                    <v-icon> {{ item.icon }} </v-icon>
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
            { title: 'ホーム', icon: 'mdi-home' },
            { title: '通知をみる', icon: 'mdi-bell-outline' },
            { title: 'メッセージ', icon: 'mdi-message' },
            { title: 'プロフィール', icon: 'mdi-face'}
        ]
    })
}
</script>