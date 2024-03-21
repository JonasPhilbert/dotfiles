try {
    console.log('NETFLEX WORKER: Starting...');

    console.log('NETFLEX WORKER: Loading "geo.js".');
    importScripts('geo.js');

    console.log('NETFLEX WORKER: Loading "onInstalled.js".')
    importScripts('onInstalled.js');

    console.log('NETFLEX WORKER: Loading "distribution.js".')
    importScripts('distribution.js');

    console.log('NETFLEX WORKER: Loading "worker.js".')
    importScripts('worker.js');

    console.log('NETFLEX WORKER: Started!');
} catch (e) {
    console.error(e);
}