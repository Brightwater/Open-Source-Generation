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
    import formwidget from './form-widget.vue'
    import gridwidget from './grid-widget.vue'

    export default
    {
        components: {
            'form-widget': formwidget,
	        'grid-widget': gridwidget,
        },
    }
</script>

<style>
</style>
