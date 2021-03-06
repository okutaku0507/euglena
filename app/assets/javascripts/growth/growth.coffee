$(document).on 'page:change ready page:load', (e) ->
  if $('#AddOrganismsArea').length
    $('#AddOrganismsArea').on 'click', '#ToggleAddOrganismsArea', (e) ->
      toggle_add_organisms_area(e)
    $('#AddOrganismsArea').on 'click', 'p.add_button', (e) ->
      add_organism(e)
    $('#AddOrganismsArea').on 'change', 'input#uploaded_image', (e) ->
      upload_organism(e)
    $('#AddOrganismsArea').on 'click', '.organism_box img', (e) ->
      add_organism_to_growth_space(e)
    $('#GrowthSpace').find('.organism').each () ->
      actuate_organism_move_and_multiplication($(this))
    $('#AddOrganismsArea').on 'click', ' #ResetGrowthSpace', (e) ->
      $('#GrowthSpace').find('.organism').fadeOut(1000)
    $('#GrowthSpace').on 'click', '.organism', (e) ->
      organism_multiplication($(e.target).removeClass('apoptosis'))
    $('html').dblclick (e) ->
      gather_organism(e)
      
      
toggle_add_organisms_area = (e) ->
  if (parseInt($('#AddOrganismsArea').css('top')) < 0)
    $('#AddOrganismsArea').css('top', 50)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-up')
  else
    $('#AddOrganismsArea').css('top', -210)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-down')
    
add_organism = (e) ->
  $('#AddOrganismsArea').find('input#uploaded_image').click()
  
add_organism_to_growth_space = (e) ->
  url = $(e.target).parent('div.organism_box').attr('data-image-url')
  micromotion_degree = parseInt($(e.target).attr('data-micromotion-degree'))
  step_length = parseInt($(e.target).attr('data-step-length'))
  multiplication_speed = parseInt($(e.target).attr('data-multiplication-speed'))
  if url && confirm('これを増殖させますか？')
    organism = "<img class='organism new_organism origin' style='' src='#{url}' alt=''
      data-micromotion-degree='#{micromotion_degree}' data-step-length='#{step_length}'
      data-multiplication-speed='#{multiplication_speed}'>"
    $('#GrowthSpace').find('.organism').addClass('apoptosis')
    actuate_organism_move_and_multiplication($(organism).appendTo($('#GrowthSpace')))
  
upload_organism = (e) ->
  params = {}
  formData = new FormData( $('form').get()[0] )
  if confirm('この画像を使用しますか？')
    $('p.add_button').hide()
    $('img.loader').show()
    $.ajax({
      type: "POST",
      url: "/organisms",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
      success: (data) ->
        if data.length && $.isArray(data)
          if data[0] != 'error'
            id = data[0]
            format = data[1]
            micromotion_degree = data[2]
            step_length = data[3]
            multiplication_speed = data[4]
            html = "<div class='box organism_box' data-image-url='/organisms/#{id}.#{format}'>
              <img alt='organism_image' src='/organisms/#{id}.#{format}' data-micromotion-degree='#{micromotion_degree}'
              data-step-length='#{step_length}' data-multiplication-speed='#{multiplication_speed}'></div>"
            organism = "<img class='organism new_organism origin' style='' src='/organisms/#{id}.#{format}' alt=''
              data-micromotion-degree='#{micromotion_degree}' data-step-length='#{step_length}'
              data-multiplication-speed='#{multiplication_speed}'>"
            $('#OrganismsArea').prepend(html)
            $('#GrowthSpace').find('.organism').addClass('apoptosis')
            actuate_organism_move_and_multiplication($(organism).appendTo($('#GrowthSpace')))
            $('p.add_button').show()
            $('img.loader').hide()
          else
            alert "アップロードに失敗しました。"
            $('p.add_button').show()
            $('img.loader').hide()
        else
          alert "アップロードに失敗しました。"
          $('p.add_button').show()
          $('img.loader').hide()
      error: (data) ->
        $('p.add_button').show()
        $('img.loader').hide()
    })
    
actuate_organism_move_and_multiplication = (obj) ->
  count = 0
  t = (800 + Math.floor( Math.random() * 1200 ))
  timer = setInterval ->
    organism_move_and_multiplication(obj, timer, count++)
  , (t)
  
organism_move_and_multiplication = (obj, timer, count) ->
  unless $(this)
    clearInterval(timer)
  growth_count = parseInt($('body').attr('data-growth-count'))
  micromotion_degree = parseInt(obj.attr('data-micromotion-degree'))
  step_length = parseInt(obj.attr('data-step-length'))
  multiplication_speed = parseInt(obj.attr('data-multiplication-speed'))
  innerHeight = (parseInt(window.innerHeight) - 50)
  innerWidth = (parseInt(window.innerWidth) - 50)
  top = parseInt(obj.css('top'))
  left = parseInt(obj.css('left'))
  vertical = [(top + step_length), (top - step_length)][Math.floor( Math.random() * 2 )]
  if vertical < 0
    vertical = 0
  if innerHeight < vertical
    vertical = innerHeight
  horizontal = [(left + step_length), (left - step_length)][Math.floor( Math.random() * 2 )]
  if horizontal < 0
    horizontal = 0
  if innerWidth < horizontal
    horizontal = innerWidth
  if count != 0 && (count % multiplication_speed) == 0
    if (($('#GrowthSpace').find('.organism').length < growth_count) && (!obj.hasClass('apoptosis') || Math.floor( Math.random() * 1 ) == 0)) || obj.hasClass('new_organism')
      organism_multiplication(obj)
      if obj.hasClass('new_organism')
        organism_multiplication(obj)
      if 10 < count && obj.hasClass('new_organism')
        obj.removeClass('new_organism')
    obj.css('transform', "rotate(#{Math.floor( Math.random() * micromotion_degree )}deg)";).
      css({"top":"#{vertical}px","left": "#{horizontal}px"})
    if ((3 < count && ($('#GrowthSpace').find('.apoptosis').length == 0 || ($('#GrowthSpace').find('.apoptosis').length && !obj.hasClass('apoptosis')))) || obj.hasClass('apoptosis')) || (obj.hasClass('apoptosis') && $('#GrowthSpace').find('.organism').not('.apoptosis').length < 10)
      if !obj.hasClass('new_organism')
        apoptosis(obj, timer)
  else
    obj.css('transform', "rotate(#{Math.floor( Math.random() * micromotion_degree )}deg)";).
      css({"top":"#{vertical}px","left": "#{horizontal}px"})
  if growth_count < $('#GrowthSpace').find('.organism').length
    organisms_cleaner()
    
organism_multiplication = (obj) ->
  growth_count = parseInt($('body').attr('data-growth-count'))
  if ($('#GrowthSpace').find('.organism').length <= growth_count) || obj.hasClass('new_organism')
    new_obj = obj.clone()
    $('#GrowthSpace').append(new_obj.removeClass('new_organism'))
    actuate_organism_move_and_multiplication(new_obj)
  
apoptosis = (obj, timer) ->
  if !obj.hasClass('origin')
    if obj.hasClass('apoptosis')
      if Math.floor( Math.random() * 2 ) == 0
        clearInterval(timer)
        obj.fadeOut(2000).remove()
    else
      if Math.floor( Math.random() * 4 ) == 0
        clearInterval(timer)
        obj.fadeOut(2000).remove()

organisms_cleaner = () ->
  growth_count = parseInt($('body').attr('data-growth-count'))
  num = ($('#GrowthSpace').find('.organism').length - growth_count)
  $('#GrowthSpace').find('.organism').each (idx) ->
    if idx < num
      $(this).fadeOut(2000).remove()

gather_organism = (e) ->
  top = e.pageY
  left = e.pageX
  $('#GrowthSpace').find('.organism').css({"top":"#{top}px","left": "#{left}px"})
  

  
 　
  