import FastSimplexNoise from 'fast-simplex-noise'
simplex = new FastSimplexNoise {
  frequency: 0.0005
  max: window.innerHeight
  min: 0
  octaves: 8
}

export default class World
  constructor: ({
    @seed=2147483647
    @oceanMinWidth=100
    @oceanMaxWidth=10000
    @continentMinWidth=250
    @continentMaxWidth=100000
    @oceanMaxDepth=10
  }={}) ->
  surface: (now, period, left, right) ->
    <path fill="skyblue" d={"M0 0L#{("#{index} #{simplex.in2D index, now}" for index in [left..right]).join 'L'}L#{right} 0"} />
