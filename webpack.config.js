const path = require('path');

module.exports = {
  resolve: {
    fallback: {
      "net": require.resolve("net"),
      
    "stream": require.resolve("stream-browserify"),
      "tls": require.resolve("tls"),
      "https": require.resolve("https-browserify"),
      "crypto": require.resolve("crypto-browserify"),
      "util": require.resolve("util/"),
      path: require.resolve('path-browserify'),
      crypto: require.resolve('crypto-browserify'),
      url: require.resolve('url/'),
      querystring: require.resolve('querystring-es3'),
    "https": require.resolve("https"),
    "http": require.resolve("stream-http"),
    "buffer": require.resolve("buffer")
    }
  },
  // Autres options de configuration pour webpack
};
