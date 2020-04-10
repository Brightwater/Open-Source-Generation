var HtmlWebpackPlug = require("html-webpack-plugin");

module.exports = {
    entry: "./app/templates/index.js",
    output: {
        path:  __dirname + '../../../app/javascript';
        filename: "bundle.[hash].js";
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: './app/templates/index.html',
            filename: 'test.html',
        })
    ]
}