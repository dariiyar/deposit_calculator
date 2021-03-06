$(document).on 'turbolinks:load', ->
    DropdownInit.init()
    DatepickerInit.init({
        autoclose: true
        todayHighlight: false
        format: 'd M yyyy'
        orientation: 'bottom'
      })
    $('#submit_deposit').on 'click', (ev) ->
        ev.preventDefault()
        form = $('.deposit-form').eq(0)
        $.ajax
            url: form.attr('action')
            data: form.serialize()
            type: 'GET'
            dataType: 'script'

