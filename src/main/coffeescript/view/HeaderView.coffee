class HeaderView extends Backbone.View
  events: {
    'click #show-pet-store-icon'    : 'showPetStore'
    'click #show-wordnik-dev-icon'  : 'showWordnikDev'
    'click #explore'                : 'showCustom'
    'keyup #input_baseUrl'          : 'showCustomOnKeyup'
    'keyup #input_apiKey'           : 'showCustomOnKeyup'
  }

  initialize: ->


  showPetStore: (e) ->
    @trigger(
      'update-swagger-ui'
      {discoveryUrl:"http://petstore.swagger.wordnik.com/api/resources.json", apiKey:"special-key"}
    )

  showWordnikDev: (e) ->
    @trigger(
      'update-swagger-ui'
      {discoveryUrl:"http://api.wordnik.com/v4/resources.json", apiKey:""}
    )

  showCustomOnKeyup: (e) ->
    @showCustom() if e.keyCode is 13

  showCustom: (e) ->
    e?.preventDefault()

    date = new Date()
    date.setTime(date.getTime() + (30 * 365 * 30 * 60 * 1000))
    expires = "; expires="+date.toGMTString()
    document.cookie = "discoveryUrl="+$('#input_baseUrl').val()+expires+"; path=/";
    document.cookie = "apiKey="+$('#input_apiKey').val()+expires+"; path=/";
    @trigger(
      'update-swagger-ui'
      {discoveryUrl: $('#input_baseUrl').val(), apiKey: $('#input_apiKey').val()}
    )

  update: (url, apiKey, trigger = false) ->
    $('#input_baseUrl').val url
    $('#input_apiKey').val apiKey
    @trigger 'update-swagger-ui', {discoveryUrl:url, apiKey:apiKey} if trigger
