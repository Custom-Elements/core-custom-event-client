#core-custom-event-client
This connects to [https://github.com/wballard/custom-event-server](), learn
all about it there.

    AwesomeWebSocket = require 'awesome-websocket/src/reconnecting-websocket.litcoffee'
    Polymer 'core-custom-event-client',

##Events
This element fires a dynamic set of events based on what the server fires.

###hello
Fired on a connection or reconnection.

###pong
Fired when the server responds to your `ping`.

##Attributes and Change Handlers
###servers
This is one or more space separated server urls. This allows the hunting client
side failover behavior when there is more than one server, but automatic
reconnection is always supported.

      serversChanged: ->
        @socket = new AwesomeWebSocket @servers.split(' ')
        @socket.onmessage = (evt) =>
          try
            message = JSON.parse(evt.data)
            @fire message.type, message.detail
            if @attributes["on#{message.type}"]
              Function(@attributes["on#{message.type}"].value).call(@, message.type, message.detail)
          catch error
            console.log error
        @server =
          fire: (type, detail) =>
            @socket.send JSON.stringify
              type: type
              detail: detail

##Methods

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
