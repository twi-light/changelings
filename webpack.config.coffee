###
npm install --global gulpjs/gulp#4.0 webpack@2.1.0-beta.22 webpack-dev-server@2.1.0-beta.4
npm install --save-dev yargs gulpjs/gulp#4.0 webpack@2.1.0-beta.22 webpack-dev-server@2.1.0-beta.4 babel-loader babel-core babel-preset-es2017 coffee-loader coffee-script style-loader css-loader stylus-loader stylus
###
path = require 'path'

webpack = require 'webpack'

{ argv } = require 'yargs'

Package = require './package.json'
module.exports = {
  context: path.join __dirname, "src"
  entry:
    "#{Package.name}": "./#{Package.name}.coffee"
  output:
    path: path.join __dirname
    filename: '[name].min.js'
  debug: argv.debug?
  devtool: if argv.debug? then 'eval-source-map' else 'source-map'
  devServer:
    port: 80
    contentBase: __dirname
  module:
    loaders: [
      {
        test: /\.coffee$/
        loaders: ['babel?presets[]=es2017', 'coffee']
      }
      {
        test: /\.styl$/
        loaders: ['style', 'css', 'stylus']
      }
    ]
  plugins: [
    new webpack.DefinePlugin {
      'DEBUG': argv.debug?
    }
  ].concat if argv.debug? then [
    new webpack.LoaderOptionsPlugin {
      debug: true
      minimize: false
    }
  ] else [
    new webpack.LoaderOptionsPlugin {
      debug: false
      minimize: true
    }
    new webpack.optimize.UglifyJsPlugin {
      compress:
        warnings: false
    }
  ]
}
