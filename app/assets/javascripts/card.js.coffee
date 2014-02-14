# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

revealed = false

reveal = ->
	$('#reveal').hide()
	$('.answer').removeClass 'hidden'
	revealed = true

right = ->
	$('#btn-right').addClass('highlight').click()

wrong = ->
	$('#btn-wrong').addClass('highlight').click()

$ ->
	$('#reveal').off('click').on 'click', reveal
		

	$(document).keydown (e) ->
		console.log e.keyCode
		reveal() if e.keyCode == 32
		right() if e.keyCode == 89 and revealed
		wrong() if e.keyCode == 78 and revealed

	