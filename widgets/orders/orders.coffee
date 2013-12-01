class Dashing.Orders extends Dashing.Widget
  constructor: ->
    super
  logClicked: (code, event, context) ->
    Batman.App.fire 'logClicked', context.object.item.log
