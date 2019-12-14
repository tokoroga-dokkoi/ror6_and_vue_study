<template>
    <v-text-field
        :value="value"
        :rules="rules"
        :counter="counter"
        :label="label"
        @input="updateValue"
    ></v-text-field>
</template>
<script>
export default {
    props: ["value", "rules", "counter", "label"],
    methods: {
        updateValue: function(e){
            this.$emit("input", e)
        }
    }
}
</script>