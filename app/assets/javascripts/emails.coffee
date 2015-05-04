# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@alert_send_mail = (id,subject,groups,count) -> 
  $("#emailId").val(id)
  $("#mySmallModalLabel").text(subject)
  $("#mySmallModalBody").text("该邮件会发送到"+groups+"里，共"+count+"个邮箱中。")
  $('#myModal').modal('show')


@send_mail = () ->
  email_id = $("#emailId").val()
  $.ajax({
    url: "/emails/"+email_id+"/send",
    type: 'POST',
    success: ( data ) -> 
       window.location.href = window.location       
  })


$ ->
  $("input[name='article_volume']").click ->
    volume  = $(this).val()
    $.ajax({
      url: "/articles",
      data: {volume: volume,display: 'mini'},
      type: 'GET',
      success: ( data ) -> 
         alert("此功能正在开发中。")      
    })

    
  

