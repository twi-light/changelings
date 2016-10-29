gulp = require 'gulp'
path = require 'path'
{fork} = require 'child_process'

gulp.task 'server', ->
  serverProcess = fork path.join __dirname, 'multiplayer/server.coffee'
  gulp.watch 'multiplayer/**', ->
    serverProcess.exit()
    serverProcess = fork path.join __dirname, 'multiplayer/server.coffee'
