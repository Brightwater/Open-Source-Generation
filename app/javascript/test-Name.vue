<template>
    <ApolloQuery :query="query">
        <template slot-scope="{ result: { loading, error, data } }">
            <span v-if="loading">Loading...</span>
            <span v-else-if="error">An error occured</span>

            <section v-if="data">
                <ul v-if="data.data.length">
                    <li :key=key="name.id" v-for="name in data.data" >
                        {{ name.name }}
                    </li>
                </ul>

                <span v-else>No names, oh no:(</span>

            </section>
        </template>
    </ApolloQuery>

</template>

<script>
    import { getName } from "./queries.js";

    export default {
        testName: "Name",
        data() {
            return {
                query: getName
            };
        }
    };

</script>

<style scoped>
</style>