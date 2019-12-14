<template>
    <v-text-field
        :value="value"
        :label="label"
        :rules="rules"
        :type="show ? 'text' : 'password'"
        :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
        @click:append="show = !show"
        @input="updateValue"
    >
    </v-text-field>
</template>
<script>
export default {
    props: ["value", "rules", "label"],
    data: () => ({
        show: false
    }),
    methods: {
        updateValue: function(e){
            this.$emit("input", e)
        }
    }
}
</script>