//= require jquery
//= require easiest_ever_ajax_uploads
//= require application

// fired when upload starts, use for spinners, ui changes, etc.
EasiestAjaxUploader.uploadStarted = function(input, form, uploadsInProgressCount) {

}

// fired on upload success. use this to update the page UI.
EasiestAjaxUploader.uploadSuccess = function(input, form, filename, preview_url, uploadsInProgressCount) {
  $('#hidden_upload_input').val(filename);
  $('#preview_image_tag').attr('src', preview_url);
}

// fired on upload failure
EasiestAjaxUploader.uploadError = function(input, form, message, xhttp_request_object) {
  alert("file upload problem: " + message);
}

// fired on completion regardless of success or failure, use for spinners, ui changes, etc.
EasiestAjaxUploader.uploadDone = function(input, form, uploadsInProgressCount) {

}
