$('#page_form').empty().append("<%= escape_javascript( render(:partial => 'form.html.haml')) %>")
