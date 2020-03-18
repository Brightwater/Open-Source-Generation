<template>
 <div>
     <!-- Pass mkey prop to form-widget-->
    <form-widget :mKey="myKey"></form-widget>

    <div v-if="$apolloData.queries.data.loading == false">
    <DxDataGrid
        :data-source="data.employees"
        :columns="columns"
        :remote-operations="false"
        :allow-column-reordering="true"
        :row-alternation-enabled="true"
        :show-borders="true"
        :hover-state-enabled="true"
        :selection="{ mode: 'single' }"
        @selection-changed="onSelectionChanged"
    >

        <DxGroupPanel :visible="true"/>
        <DxSearchPanel
        :visible="true"
        :highlight-case-sensitive="true"
        />
        <DxGrouping :auto-expand-all="false"/>
        <DxPager
        :show-page-size-selector="true"
        />
        <DxPaging :page-size="10"/>
    </DxDataGrid>
    </div>
 </div>
</template>

<script>

    import {
        DxDataGrid,
        DxColumn,
        DxGrouping,
        DxGroupPanel,
        DxPager,
        DxPaging,
        DxSearchPanel
    } from 'devextreme-vue/data-grid';

    import DataSource from 'devextreme/data/data_source';
    import 'devextreme/data/odata/store';
    import gql from 'graphql-tag'

    import formwidget from './form-widget.vue'

    let collapsed = false;

    export default {
        components: {
            DxDataGrid,
            DxColumn,
            DxGrouping,
            DxGroupPanel,
            DxPager,
            DxPaging,
            DxSearchPanel,
            'form-widget': formwidget,
        },
        apollo: {
                data: {
                    query: gql`
                        query {
                            data {
                                id
                                name
                                description
                                balance
                                notes
                            }
                        }`,

                    update (data) {
                        console.log(data.data)
                        return {
                            employees: data.data,
                        }
                    },
                },
            },

        data()
        {
                return {
                    employees: [],
                    columns: ['id', "name", "description", "balance", "notes"],
                    showEmployeeInfo: false,
                    myKey: null,
            };
        },

        methods: 
        {
            onSelectionChanged({ selectedRowsData }) {
                const data = selectedRowsData[0];

                this.showEmployeeInfo = !!data;
                this.selectedRowID = data && data.id;
                
                this.myKey = data && data.id;
            }
        }
    };
    

</script>

<style scoped>
</style>


