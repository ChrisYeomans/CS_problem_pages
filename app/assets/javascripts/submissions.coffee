# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms