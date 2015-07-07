$(document).on 'page:change ready page:load', (e) ->
  if $('#AddOrganismsArea').length
    $('#AddOrganismsArea').on 'click', '#ToggleAddOrganismsArea', (e) ->
      toggle_add_organisms_area(e)
      
toggle_add_organisms_area = (e) ->
  if (parseInt($('#AddOrganismsArea').css('top')) < 0)
    $('#AddOrganismsArea').css('top', 50)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-up')
  else
    $('#AddOrganismsArea').css('top', -110)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-down')