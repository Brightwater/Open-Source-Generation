<template>
    <div id="app">
        <!--<p>{{ message }}</p>-->
        <grid-widget></grid-widget>
    </div>
</template>

<script>
    import 'devextreme/dist/css/dx.common.css'
    import 'devextreme/dist/css/dx.light.css'
	//import othercomponents from './othercomponents.vue'
    //import gridwidget from './grid-widget.vue'

    import gridwidget from './grid-widget-render.vue'
    import formwidget from './form-widget-render.vue';
    import dropdownbox from './dropdown-widget.vue';


    export default
    {
        components: {
            'form-widget': formwidget,
            'grid-widget': gridwidget,
            'dropdownbox-widget': dropdownbox,
        },
    }
</script>

<style>
</style>
