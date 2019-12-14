<template>
    <v-alert
        border="right"
        colored-border
        :type="getMessageType"
        elevation="2"
        v-if="alert"
    >
        {{ getMessageContent }}
    </v-alert>
</template>
<script>
export default {
    data: () => ({
        alert: false
    }),
    computed: {
        getMessageContent() {
            return this.$store.state.message.content
            //console.log(this.$store.state.message.content)
            //return this.$store.getters['Message/content']
        },
        getMessageType() {
            return this.$store.state.message.type
            //return this.$store.getters['Message/type']
        }
    },
    watch: {
        getMessageContent(val, oldVal){
            this.alert = (oldVal && val === '') ? false : true
        }
    }

}
</script>