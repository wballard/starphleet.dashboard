class Dashing.Terminal extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super
    Batman.App.on 'logClicked', (url) =>
      $.get url, (data) =>
        @terminal.clear()
        for line in data.split('\n')
          content = line.trimRight()
          if content
            @terminal.echo content

  ready: ->
    @terminal = $(@node).find(".terminal").terminal (command, term) ->
      console.log 'did', command, term
    ,
      prompt: '>'
      greetings: @title
      enabled: false
    $(@node).find(".terminal")
      .width($(@node).width() - 2*10)
      .height($(@node).height() - 2*10)
    source = new EventSource(document.location.origin + @node.getAttribute('data-stream'))
    source.onopen = (e) ->
      console.log("logstream opened")
    source.onmessage = (e) =>
      data = JSON.parse(e.data)
      content = data.content.trimRight()
      if content
        @terminal.echo content
    source.onerror = (e) ->
      console.log("logsream error", arguments)
      if (e.readyState == EventSource.CLOSED)
        console.log("logstream closed")


