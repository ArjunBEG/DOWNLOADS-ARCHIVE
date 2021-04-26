/home/johnny/projects/contacts/node_modules/mynosql/util.js:143
    throw new Error(
          ^
Error: createDiskIndex: depth of path:"first" was 0. expected a path of depth 2 [[path,...], ...]
    at Object.exports.assertDepth (/home/johnny/projects/contacts/node_modules/mynosql/util.js:143:11)
    at module.exports (/home/johnny/projects/contacts/node_modules/mynosql/indexes/disk.js:12:8)
    at /home/johnny/projects/contacts/node_modules/mynosql/index.js:173:25
    at loop (/home/johnny/projects/contacts/node_modules/mynosql/node_modules/pull-stream/sinks.js:15:33)
    at drain (/home/johnny/projects/contacts/node_modules/mynosql/node_modules/pull-level/node_modules/stream-to-pull-stream/index.js:102:18)
    at ReadStream.<anonymous> (/home/johnny/projects/contacts/node_modules/mynosql/node_modules/pull-level/node_modules/stream-to-pull-stream/index.js:111:5)
    at ReadStream.emit (events.js:95:17)
    at ReadStream.<anonymous> (/home/johnny/projects/contacts/node_modules/level-sublevel/node_modules/levelup/node_modules/readable-stream/lib/_stream_readable.js:786:14)
    at ReadStream.emit (events.js:92:17)
    at emitReadable_ (/home/johnny/projects/contacts/node_modules/level-sublevel/node_modules/levelup/node_modules/readable-stream/lib/_stream_readable.js:448:10)
