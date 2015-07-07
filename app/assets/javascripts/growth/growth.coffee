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
      
toggle_add_organisms_area = (e) ->
  if (parseInt($('#AddOrganismsArea').css('top')) < 0)
    $('#AddOrganismsArea').css('top', 50)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-up')
  else
    $('#AddOrganismsArea').css('top', -110)
    $('#ToggleAddOrganismsArea').children('i').attr('class', 'fa fa-angle-down')
    
add_organism = (e) ->
  $('#AddOrganismsArea').find('input#uploaded_image').click()
  
add_organism_to_growth_space = (e) ->
  url = $(e.target).parent('div.organism_box').attr('data-image-url')
  if url && confirm('これを増殖させますか？')
    organism = "<img class='organism' style='' src='#{url}' alt=''>"
    $('#GrowthSpace').append(organism)
  
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
            html = "<div class='box organism_box'><img alt='organism_image' src='/organisms/#{id}.#{format}'></div>"
            organism = "<img class='organism' style='' src='/organisms/#{id}.#{format}' alt=''>"
            $('#OrganismsArea').prepend(html)
            $('#GrowthSpace').append(organism)
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
 　
  