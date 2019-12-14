<template>
    <v-textarea
        :counter="counter"
        :value="value"
        :label="label"
        :rules="rules"
        @input="updateValue"
    >
    </v-textarea>
</template>
<script>
export default {
    props: ["value", "label", "rules", "counter"],
    methods: {
        updateValue: function(e) {
            this.$emit("input", e)
        }
    }
}
</script>