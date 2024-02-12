losc = require "losc"
plugin = require "losc.plugins.udp-socket"
bundle = require "losc.bundle"
require "moon.all"

typeMap = {
  table: "b"
  number: "f"
  string: "s"
}

GenerateTypesString = (msg) ->
  types = ""
  for x in *msg do
    if typeMap[type(x)] then
      types = types .. typeMap[type(x)]
    else
      types = types .. "b"
  return types

class Server
  new: (ip = "127.0.0.1", port = 57110, defaultGroup = { nodeID: 1 } ) =>
    @osc = losc.new({
      plugin: plugin.new({
        sendPort: port
        sendAddr: ip
      })})
    @synth = ( -- placeholder
    @bus = "synth" -- placeholder
    @buffer = "synth" -- placeholder
    @group = "synth" -- placeholder

  send: (addr, value) =>
    msg = {}
    if type(value) == "string" or type(value) == "number" then
      msg = { value }
    elseif type(value) == "table" then
      for key, val in pairs value do
        -- table.insert msg, key
        table.insert msg, val

    msg.types = GenerateTypesString msg
    msg.address = addr
    b = @osc.new_message msg

    @osc\send b

  freeAll: =>
    @send("/g_freeAll", 0)
    @send("/clearSched")
    @send("/g_new", 1, 0, 0)

  sendMsg: (...) =>
    @send(...)

  notify: (arg) =>
    @send("/notify", arg)

  status: =>
    @send("/status")

class Synth
  -- new: (type = "synth", server = s, nodeID = nextNodeID(), name = name, args = parseArgsX(args)) =>
  new: (type, nodeID, name, args) =>
    @type, @nodeID, @name, @args = type, nodeID, name, args



