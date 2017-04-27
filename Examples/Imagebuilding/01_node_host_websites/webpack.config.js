let path = require('path');

module.exports = {
    entry: "./src/main.ts",
    devtool: "source-map",
    output: {
        filename: 'atp_bundle.js',
        path: path.resolve(`${__dirname}/wwwroot/app`)
    },
    resolve: {
        // Add '.ts' and '.tsx' as a resolvable extension.
        extensions: [".ts", ".tsx", ".js", ".webpack.js", ".web.js"]
    },
    module: {
        loaders: [
            // all files with a '.ts' or '.tsx' extension will be handled by 'ts-loader'
            { 
                test: /\.tsx?$/,
                loader: "ts-loader" 
            }, {
                loader: "source-map-loader",
                test: /\.js$/,
            }
        ]
    }
}