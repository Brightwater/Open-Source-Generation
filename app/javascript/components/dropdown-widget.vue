<template>
	<DxSelectBox 
		:items="employee"
		:show-clear-button="true"     		
	/>
</template>

<script>
	import {DxSelectBox} from 'devextreme-vue';
	import gql from 'graphql-tag';	

	export default {
		components: {
			DxSelectBox,
		},
		data()
		{
			return {
				employee: ["Boss", "Manager", "Driver", "CSR"],
			};
		},
	}
</script>

