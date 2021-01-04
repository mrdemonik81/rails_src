const {environment} = require('@rails/webpacker');
const webpack = require('webpack');
const typescript = require('./loaders/typescript');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}));

environment.loaders.append('exposejQuery', {
  test: require.resolve('jquery'),
  use: [{
    loader: 'expose-loader',
    options: '$'
  }, {
    loader: 'expose-loader',
    options: 'jQuery',
  }]
})

environment.loaders.prepend('typescript', typescript)
module.exports = environment;

