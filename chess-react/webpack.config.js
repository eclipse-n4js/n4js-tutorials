const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const webpack = require('webpack');

module.exports = {
  mode: 'production',

  entry: {
  	// Webpack starts calculating dependency graph from this file
    app: './src-gen/main.js'
  },
  output: {
  	// The output concatenated file
    filename: 'chess-app.js',
    publicPath: 'dist/',
    path: path.resolve(__dirname, './dist')
  },
  
  externals: {
    'react': 'React',
    'react-dom': 'ReactDOM'
  },

  devtool: 'inline-source-map', 

  /** Configure Webpack Dev server */
  devServer: {
  	// Serve files from the `.` folder at localhost:8080 
  	contentBase: path.join(__dirname, '.'),
  	port: 8080,
  	hot: true,
  	inline: true
  },

  plugins: [
  	new CleanWebpackPlugin(),
    new webpack.HotModuleReplacementPlugin()
  ],  

  resolve: {
      alias: {
  	 	'n4js-tutorial-chess': __dirname
  	}
  }
};