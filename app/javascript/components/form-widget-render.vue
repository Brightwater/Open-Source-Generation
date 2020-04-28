<template>
	<div id="container" v-if="$apolloData.queries.data.loading == false" class="form-widget">
		<div class="inner-form-widget">
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
						/>
					<DxSimpleItem
						data-field="name"
						/>
					<DxSimpleItem
						data-field="description"
						/>
					<DxSimpleItem
						data-field="balance"
						/>
					<DxSimpleItem
						data-field="notes"
						/>
										
				</DxGroupItem>
	
			</DxForm>
		</div>
			<button id="updateButton" @click="buttonClicked">Update</button>
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
	import { DxSelectBox } from 'devextreme-vue'
	import { DxLoadIndicator} from 'devextreme-vue/load-indicator';
	import gql from 'graphql-tag'
	import DxForm,
	{
		DxSimpleItem,
		DxGroupItem,
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
			DxSelectBox,
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
				dxTextAreaOptions: { height: 90 }, // make the notes element bigger
				showIndicator: false,
				selectBoxDataSource: null,
				dxSelectBoxOptions: { dataSource: [null], acceptCustomValue: true},
			};
		},

		props: {
			mKey: {
				default: 0
			},
		},

		watch: {
			// wait for mKey to be updated
			mKey: function () {
				// don't update form unless the parent grid wants it to
				if (this.mKey != 0) {
					console.log(this.mKey)
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
			}
		},

		methods:
		{
			buttonClicked() {

				// this part will look a bit messy in the template because of graphql formatting
				this.$apollo.mutate({
					mutation: gql` 
						mutation update ($id: Int!, $name: String!, $description: String!, $balance: money!, $notes: String!, ) {
							update_data(where: {id: {_eq: $id}}, 
							_set: {name: $name, description: $description, balance: $balance, notes: $notes, }) {
								returning {
									id
name
description
balance
notes
   
								}
							}
						}`,
					variables: {
						id: this.data.employee.id,
						name: this.data.employee.name,
						description: this.data.employee.description,
						balance: this.data.employee.balance,
						notes: this.data.employee.notes,
								},
				})
			}
		},

																							
	};

	
	
</script>

<style>
html {
	font-family: 'Helvetica Neue','Segoe UI', 'Helvetica', 'Verdana', 'sans-serif';
	line-height: 1.35715;
}
</style>

<style scoped>
.dx-widget {
	display: inline-block;
	width: 100%;
}

#container {
	overflow: auto;
}

.customlabel {
	padding-top: 10px;
}

button {
	padding-left: 7px;
	padding-right: 7px;
	padding-top: 3px;
	padding-bottom: 3px;
	margin-top: 0.2em;	
	float: right;
	border-radius: 5px;
	background-color: rgba(191, 191, 191, 0.15);
	border: 2px solid #d2d3d5;
}

.inner-form-widget{
	background-color: rgba(191, 191, 191, 0.15);
	border: 2px solid #d2d3d5;
	padding: 15px;
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
