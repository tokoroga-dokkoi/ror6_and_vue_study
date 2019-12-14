<template>
    <v-file-input
        :label="label"
        :value="value"
        :prepend-icon="icon"
        filled
        outlined
        dense
        @change="updateValue"
    >
    </v-file-input>
</template>
<script>
export default {
    props: ['value', 'label', 'icon'],
    methods: {
        updateValue(e) {
            this.$emit("upload", e)
        }
    }
}
</script>