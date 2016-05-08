// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require chosen-jquery
//= require jquery-ui
//= require underscore
//= require gmaps/google
//= require_tree .
//
// AppKey is from Bing Market Place account
// var AppKey = ""
// var encodedAppKey = Base64.encode(':' + AppKey);
//
// $.ajax({
//   //url: "https://api.datamarket.azure.com/Bing/Search/v1/Web?Query='sushi'&$format=JSON",
//   url: "https://api.datamarket.azure.com/Bing/Search/v1/News?Query='Vancouver Tech'&$format=JSON",
//   method: "GET",
//   headers: {
//     "Authorization": "Basic " + encodedAppKey
//   },
//   error: function() {
//     alert("Failed bing search");
//   },
//   success: function(data){
//     console.log(data)
//   }
// });
