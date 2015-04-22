# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".panels.show").ready ->

  MAX_OUTPUT = 100
  $progress = $('.progress-bar.progress-bar-success')
  current = $progress.html()
  $progress.css('width',"#{current}")

  source = new EventSource("/outputs/notify")
  source.addEventListener("update_output" , (event)->
    output = jQuery.parseJSON(event.data)
    panel = "#outputPanel-"+output.panel
    console.log(panel)
    if($(panel).length)
       current = output.watt
       $('#outputs').highcharts().series[0].points[0].update(parseInt(current))
       $(panel).html(current)

 )

