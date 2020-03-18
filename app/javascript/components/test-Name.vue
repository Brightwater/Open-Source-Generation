<template>
    <div>Test</div>
    <!--
    <ApolloQuery :query="query">
        <template slot-scope="{ result: { loading, error, data } }">
            <span v-if="loading">Loading...</span>
            <span v-else-if="error">An error occured</span>

            <section v-if="data">
                <span :key="name.id" v-for="name in data.data" >
                    {{name.name}}
                </span>
            </section>
        </template>
    </ApolloQuery>-->
</template>



<script>
    import gql from 'graphql-tag'
    import { apolloClient } from '../packs/application.js';

    
    /*
    const name = gql`
        query {
            data (where: {name: {_eq: "John Smith"}}){
                id
                name
                description
                balance
                notes
            }
        }`;
    */
    

    export default {
        data() {
            return {
                employee: null,
            };
        },

        apollo: {
            data: {
                query: gql`
                    query {
                        data (where: {name: {_eq: "John Smith"}}){
                            id
                            name
                            description
                            balance
                            notes
                        }
                    }`,
                
                variables () {
                    return {
                        //name: data.name,
                    }
                },

                update (data) {
                    console.log(data.data[0].name)
                    return {
                        employee: data.data[0]
                    }
                },
            },
        },

        
        /*
        name: "Name",
        data() {
            return {
                query: name,
            };
        },
    */
    };

    
</script>

<style scoped>
</style>