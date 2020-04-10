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
						:editor-type: 
					/>
					<DxSimpleItem
						data-field="name"
					/>
					<DxSimpleItem
						data-field="payrate"
					/>
					<DxSimpleItem
						data-field="dateHired"
					/>
					
					<dropdownbox-widget></dropdownbox-widget> 

				</DxGroupItem>

				
				
			</DxForm>
			<br/>
			<br/>
			<div>Employee type:(hardcoded right now)</div>
			<dropdownbox-widget></dropdownbox-widget>
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
	import { DxLoadIndicator} from 'devextreme-vue/load-indicator';
	import gql from 'graphql-tag'
	import DxForm,
	{
		DxSimpleItem,
		DxGroupItem
	} from 'devextreme-vue/form';
	
	import dropdownbox from './dropdown-widget.vue';

	export default 
	{	
		components:
		{
			DxForm,
			DxSimpleItem,
			DxGroupItem,
			DxTextArea,
			DxLoadIndicator,
			'dropdownbox-widget': dropdownbox,
		},

		apollo: {
            data: {
                query: gql`
                    query {
                        employee {
                            id
								name
								payrate
								dateHired
								
                        }
                    }`,

                update (data) {
                    console.log(data.employee[0])
                    return {
						employee: data.employee[0],
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
			};
		},

		props: ['mKey'],

		watch: {
			// wait for mKey to be updated
			mKey: function () {
				var data;
				var queryid = this.mKey;
				
				// manual query with variable queryid (mKey)
				this.$apollo.query({
					query: gql`
						query lookup($queryid: Int!) {
							employee (where: {id: {_eq: $queryid}}) {
								id
								name
								payrate
								dateHired
								
							}
						}`,
					variables: {
						queryid: queryid,
					},
				}).then((response) =>
					this.data.employee = response.data.employee[0] // update employee
				)	
			}
		},

		methods:
		{
			buttonClicked() {
				console.log("clicked \n" + this.data.employee.id);
				var id = this.data.employee.id;
				var name = this.data.employee.name;
				var payrate = this.data.employee.payrate;
				var dateHired = this.data.employee.dateHired;
		
																																																																																																																																											
									
				// this part will look a bit messy in the template because of graphql formatting
				this.$apollo.mutate({
					mutation: gql` 
						mutation update ($id: Int!, $name: String!, $payrate: money!, $dateHired: date!, ) {
							update_employee(where: {id: {_eq: $id}}, _set: {name: $name, payrate: $payrate, dateHired: $dateHired, }) {
								returning {
									id
								name
								payrate
								dateHired
								   
								}
							}
						}`,
					variables: {
						id: id,
						name: name,
						payrate: payrate,
						dateHired: dateHired,
								},
				})
			}
		}
	};
</script>

<style>

html {
	font-family: calibri;
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
