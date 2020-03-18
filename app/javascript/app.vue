

<script>
    import 'devextreme/dist/css/dx.common.css'
    import 'devextreme/dist/css/dx.light.css'  
</script>

<template>
    <div id="app">
        <p>{{ message }}</p>
    </div>
</template>

<script>
    export default 
	{
        data: function () {
            return {
                message: "Hello Vue!"
            }
        }
    }
</script>

<template>
    <DxForm
		id="form"
        :form-data="apollo"
		label-location="top"
		:width="450"
		>

		<template #avatar-template>
			<div class="form-picture"/>
		</template>


		<DxGroupItem
			css-class="formGroup"
		>
			<DxSimpleItem template="avatar-template"/>
			<DxSimpleItem
				data-field="ID"
				:is-required="true"
			/>
			<DxSimpleItem
				data-field="name"
				:is-required="true"
			/>
			<DxSimpleItem
				data-field="desc"
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
</template>
 
<script>
	import 'devextreme/dist/css/dx.common.css';
	import 'devextreme/dist/css/dx.light.css';
	import { DxTextArea } from 'devextreme-vue/text-area';

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
			DxTextArea
		},
		data()
		{
			return {
				employee:
				{
					ID: "123456",
					name: "John Smith",
					desc: "A description",
					balance: "435.95",
					notes: "John has been in the Audio/Video industry since 1990."//
				},
				//notesOptions: { height: 140 }
			};
		},
	};
</script>

<style>

.formGroup {
	background-color: rgba(191, 191, 191, 0.15);
	border: 2px solid #d2d3d5;
	padding: 15px;
}

.form-picture {
	height: 128px;
	width: 128px;
	margin-right: 10px;
	border: 1px solid;
	background-image: url('https://aahid.org/wp-content/uploads/2015/01/sample-person.jpg');
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center;
	display: block;
    margin: 0 auto;
}
</style>
