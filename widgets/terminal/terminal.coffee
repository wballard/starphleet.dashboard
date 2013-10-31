class Dashing.Terminal extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super

  ready: ->
    terminal = $(@node).find(".terminal").terminal (command, term) ->
      console.log 'did', command, term
    ,
      prompt: '>'
      greetings: @title
      enabled: false
    pad = $(@node).find('.terminal').css('padding')
    $(@node).find(".terminal")
      .width($(@node).width() - 2*10)
      .height($(@node).height() - 2*10)

    source = null
    reconnect = ->
      source = new EventSource(document.location.origin + @node.getAttribute('data-stream'))
      source.onopen = (e) ->
        console.log("logstream opened")

      source.onmessage = (e) ->
        data = JSON.parse(e.data)
        content = data.content.trimRight()
        if content
          terminal.echo content

      source.onerror = (e) ->
        console.log("logsream error")
        if (e.readyState == EventSource.CLOSED)
          console.log("logstream closed")
        else
          setTimeout reconnect, 3000
    reconnect()


