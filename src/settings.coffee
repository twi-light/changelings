export getSetting = (key, defaultValue) ->
  value = try JSON.parse localStorage.getItem "changelings-setting-#{key}"
  value ?= defaultValue

export setSetting = (key, value) ->
  localStorage.setItem "changelings-setting-#{key}", try JSON.stringify value
