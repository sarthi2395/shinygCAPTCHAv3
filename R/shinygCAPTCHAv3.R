#' @title shinygCAPTCHAv3
#'
#' @description Package To Use Google reCAPTCHAv3 in Shiny Web Applications
#'
#' @param siteKey
#'
#' @param action
#'
#' @param fieldID
#'
#' @param secretKey
#'
#' @param reCaptchaResponse
#'
#' @return NULL
#'
#' @export GreCAPTCHAv3Ui

GreCAPTCHAv3Ui <- function(siteKey, action, fieldID) {
tagList(tags$head(
  tags$script(src = paste0("https://www.google.com/recaptcha/api.js?render=",siteKey)),
  tags$script(

    paste0(" grecaptcha.ready(function () {
		     grecaptcha.execute('",siteKey,"', { action: '",action,"' }).then(function (token) {
			 Shiny.onInputChange('responseReceived',token);
			 });
			});"))
))
}
#' @export GreCAPTCHAv3Server

GreCAPTCHAv3Server <- function(secretKey, reCaptchaResponse) {

  gResponse <- POST("https://www.google.com/recaptcha/api/siteverify", body = list(
    secret = secretKey,
    response = reCaptchaResponse
  ))

  if(gResponse$status_code==200){
    return(fromJSON(content(gResponse, "text")))
  }
}
