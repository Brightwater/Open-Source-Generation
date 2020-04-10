var HtmlWebpackPlugin = require("html-webpack-plugin");

console.log("webpack.config file");
//import input from './app/templates/input.js';
const input = require('./../../app/templates/input.js');

var queryElements = input.columns.join('\n\t\t\t\t\t\t\t\t');

var regex = /[']/g;
queryElements = queryElements.replace(regex, '');

module.exports = {
    devServer: {
        writeToDisk: true
    },
    output: {
        path:  __dirname + '/../../public/packs',
        filename: "application-[hash].js",
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: './app/templates/grid-widget-template.html.erb',
            inject: false,
            
            tableName: input.tableName,
            data: input.columns,
            queryElements: queryElements,
            
            filename: __dirname + '/../../app/javascript/components/_webpack_head.vue',
        })

    ]
}