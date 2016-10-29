import './world.viewer.styl'
import React from 'react'
import ReactDOM from 'react-dom'
import {Viewer, ViewerHelper} from 'react-svg-pan-zoom'
import {getSetting, setSetting} from './settings.coffee'
import World from './world.coffee'
world = new World

export default class WorldViewer extends React.Component
  constructor: ->
    super arguments...
    @state = {
      value: getSetting 'viewer', ViewerHelper.getDefaultValue()
    }
  onChange: (event) =>
    setSetting 'viewer', event.value
    @setState value: event.value
  render: ->
    <Viewer detectPinch detectAutoPan tool="pan" background="" SVGBackground=""
      width={window.innerWidth} height={window.innerHeight}
      value={@state.value} onChange={@onChange}
    >
      <svg width="100" height="100">
        <path stroke="blue" fill="transparent" d="M-1000 0 H 1000" />
        <path stroke="red" fill="transparent" d="M0 -1000 V 1000" />
      </svg>
    </Viewer>
