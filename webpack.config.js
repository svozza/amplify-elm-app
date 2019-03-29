const path = require('path');

module.exports = {
    entry: './src/entry',
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    module: {
        rules: [
            {
                test: /\.json$/,
                loader: 'json'
            }
        ]
    }
};