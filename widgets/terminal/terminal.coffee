class Dashing.Terminal extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".meter").val(value).trigger('change')

  ready: ->
    terminal = $(@node).find(".terminal").terminal (command, term) ->
      console.log 'did', command, term
    ,
      prompt: '>'
      greetings: @title
