# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$ ->
  map = L.map('map').setView([0, -0], 1)

  L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png',
                maxZoom: 18
                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' + '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' + 'Imagery © <a href="http://mapbox.com">Mapbox</a>'
                id: 'examples.map-i875mjb7').addTo map

  $.getJSON 'items.json', (data) ->
    items = []
    $.each data, (key, val) ->
      console.log(val)
      L.marker([
        val.latitude
        val.longitude
      ]).addTo(map).bindPopup val.name
      return