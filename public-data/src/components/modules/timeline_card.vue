<template>
    <v-card
        class="mr-auto mb-2"
        width="90%"
    >
        <v-list-item>
            <v-list-item-avatar color="grey"></v-list-item-avatar>
            <v-list-item-content>
                <v-list-item-title class="headline">
                    UserName
                </v-list-item-title>
                <v-list-item-subtitle>
                    {{ timeline.created_at }}
                </v-list-item-subtitle>
            </v-list-item-content>
        </v-list-item>
        <v-img
            :src="image"
            :height="image_height"
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
                ファボ
            </v-btn>
        </v-card-actions>
    </v-card>
</template>
<script>
export default {
    props: ["timeline", "image"],
    data: () => ({
        image_height: 194
    })
}
</script>