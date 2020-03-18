<template>
	<div v-if="$apolloData.queries.data.loading == false" class="form-widget">
		<DxForm
			id="form"
			:form-data="data.employee"
			
			label-location="top"
			>

			<DxGroupItem
				css-class="formGroup"
			>
				
				<DxSimpleItem
					data-field="id"
					:is-required="true"
				/>
				<DxSimpleItem
					data-field="name"
					:is-required="true"
				/>
				<DxSimpleItem
					data-field="description"
				/>
				<DxSimpleItem
					data-field="balance"
				/>
				<DxSimpleItem
					:editor-options="notesOptions"
					data-field="notes"
					editor-type="dxTextArea"
				/>
			</DxGroupItem>
		</DxForm>
	</div>
	<div v-else>
		<DxLoadIndicator
			id="large-indicator"
			:height="100"
			:width="100"
		/>
	</div>
</template>
 
<script>
	import { DxTextArea } from 'devextreme-vue/text-area';
	import { DxLoadIndicator} from 'devextreme-vue/load-indicator';
	import gql from 'graphql-tag'
	import DxForm,
	{
		DxSimpleItem,
		DxGroupItem
	} from 'devextreme-vue/form';
	

	export default 
	{	
		components:
		{
			DxForm,
			DxSimpleItem,
			DxGroupItem,
			DxTextArea,
			DxLoadIndicator,
		},

		apollo: {
            data: {
                query: gql`
                    query {
                        data (where: {name: {_eq: "John Smith"}}) {
                            id
                            name
                            description
                            balance
                            notes
                        }
                    }`,

                update (data) {
                    console.log(data.data[0])
                    return {
						employee: data.data[0],
                    }
                },
            },
        },

		data()
		{
			return {
				employee: [],
				notesOptions: { height: 90 }, // make the notes element bigger
				showIndicator: false,
				emp: null,
			};
		},

		props: ['mKey'],

		watch : {
			// wait for mKey to be updated
			mKey: function () {
				var data;
				var queryid = this.mKey;
				
				// manual query with variable queryid (mKey)
				this.$apollo.query({
					query: gql`
						query lookup($queryid: Int!) {
							data (where: {id: {_eq: $queryid}}) {
								id
								name
								description
								balance
								notes
							}
						}`,
					variables: {
						queryid: queryid,
					},
				}).then((response) =>
					this.data.employee = response.data.data[0] // update employee
				)
				
			}
		},
	};
</script>

<style>
.formGroup {
	background-color: rgba(191, 191, 191, 0.15);
	border: 2px solid #d2d3d5;
	padding: 15px;
	
}
</style>

<style scoped>
.dx-widget {
	display: inline-block;
	width: 100%;
	
}

.form-widget {
	margin-left: 35%;
	margin-right: 35%;
	min-width: 200px;
}

#large-indicator {
	vertical-align: middle;
	margin-right: 10px;
	padding: 30px;
}
</style>
