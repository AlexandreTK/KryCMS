# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Remember to remove this from being loaded to the rest of the application if used
# Maybe a better alternative is to use the admin.coffee file to input javascript 
# related to the admin part of the site


# Selecting type / sending data not to loose the 'object'
$ ->
  $('#page_type_id').on 'change', (event) ->
    pageType = $('#page_type_id :selected').val()
    pageTitle = $('#page_title').val()
    pageBody = CKEDITOR.instances['page_body'].getData();
    pageSlug = $('#page_slug').val()
    pageCategory = $('#page_category_id :selected').val()
    myPage = $('#page_form').data('page')
    $.ajax '/admin/pages/update_fields',
      type: 'POST'
      dataType: 'script'
      data: {
        type_id: pageType
        page: myPage
        title: pageTitle
        body: pageBody
        slug: pageSlug
        category_id: pageCategory
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic select OK!")





# Sometimes the ckeditor field is shown as textarea... This is an attempt to fix this probem
$ ->
  try
    if $('textarea').length > 0
      data = $('textarea')
      $.each data, (i) ->
        CKEDITOR.replace data[i].id
        return
  return

#$ ->
#  if $('textarea').length > 0
#    data = $('textarea')
#    $.each data, (i) ->
#      if CKEDITOR.instances[data[i].id]
#        CKEDITOR.remove CKEDITOR.instances[data[i].id]
#      else
#        CKEDITOR.replace data[i].id
#      return
#  return