#' @title GreCAPTCHAv3Ui
#'
#' @description UI part of the package to invoke reCAPTCHAv3 Javascript
#'
#' @param siteKey The Site key generated in Google reCAPTCHA admin console for your domain
#'
#' @param action Type of action to be used by reCAPTCHA validation service. Available options are 'homepage', 'login', 'social' and 'e-commerce'. For more details, refer https://developers.google.com/recaptcha/docs/v3
#'
#' @param fieldID The field ID to which the response token needs to be sent back to Shiny Server
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
			 Shiny.onInputChange('",fieldID,"',token);
			 });
			});"))
))
}

#' @title GreCAPTCHAv3Server
#'
#' @description Server part of the package to receive response token from invoked UI script
#'
#' @param secretKey The Secret key generated in Google reCAPTCHA admin console for your domain
#'
#' @param reCaptchaResponse The response received from GreCAPTCHAv3Ui 'Field'
#'
#' @return NULL
#'
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
