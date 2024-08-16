(window as any).global = window;
(global as any).process = {
    env: { DEBUG: undefined },
    version: []
};
(global as any).Buffer = require('buffer').Buffer;
(global as any).crypto = require('crypto');
(global as any).http = require('stream-http');
(global as any).https = require('https-browserify');
(global as any).net = require('net-browserify');
(global as any).os = require('os-browserify/browser');
(global as any).process = require('process/browser');
(global as any).punycode = require('punycode/');
(global as any).querystring = require('querystring-es3/');
(global as any).url = require('url/');
(global as any).vm = require('vm-browserify');
