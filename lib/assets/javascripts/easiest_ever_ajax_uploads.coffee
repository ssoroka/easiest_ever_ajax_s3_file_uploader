jQuery.event.props.push "dataTransfer"

$(document).ready =>
  $(document).on "change", '.easyAutoUpload', EasiestAjaxUploader.uploadFile
  # $(document).on('drop', file_input, dropped);

class EasiestAjaxUploader
  @uploadStack: 0
  @uploadStarted: (input, form, uploadsInProgress) ->
  @uploadSuccess: (input, form, filename, preview_url, uploadsInProgressCount) ->
  @uploadError: (input, form, message, xhttp_request_object) ->
  @uploadDone: (input, form, uploadsInProgress) ->
  @uploadFile: (e) ->
    console.log "fileupload"
    input = $(e.target)
    form = $(e.target.form)
    if input.val() isnt `undefined` and input.val() isnt ""
      EasiestAjaxUploader.uploadStack += 1
      form.find(".shoutform-submit").attr "disabled", "disabled"
      
      # get a url for the file upload
      file = input[0].files[0]
      fileReader = new FileReader()
      fileReader.onload = (e) ->
        preview_url = @result
        input.data "preview_url", preview_url

      fileReader.readAsDataURL file
      
      # do actual uploading
      form.addClass "uploading"
      EasiestAjaxUploader.uploadStarted input, form, EasiestAjaxUploader.uploadStack
      fd = new FormData(e.target.form)
      console.log "File type: " + file.type
      $.ajax
        url: form.attr("action")
        type: "POST"
        data: fd
        processData: false
        contentType: file.type
        crossDomain: true
        success: (data, textStatus, jqXHR) ->
          EasiestAjaxUploader.uploadSuccess input, form, jqXHR.getResponseHeader("Location"), input.data("preview_url"), EasiestAjaxUploader.uploadStack

        error: (xhro, msg) ->
          console.log "File upload error: " + msg
          console.log xhro
          EasiestAjaxUploader.uploadError input, form, msg, xhro
        always: ->
          form.removeClass "uploading"
          EasiestAjaxUploader.uploadDone input, form, EasiestAjaxUploader.uploadStack
          EasiestAjaxUploader.uploadStack -= 1
          form.find(".shoutform-submit").attr "disabled", null if EasiestAjaxUploader.uploadStack is 0

window.EasiestAjaxUploader = EasiestAjaxUploader # export!
