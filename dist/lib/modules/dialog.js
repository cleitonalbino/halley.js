'use strict';function makeDialog(a,b){function c(){document.body.style.overflow="",f.classList.add("data-out"),f.classList.remove("data-active"),g.onClose&&g.onClose()}function d(){c()}function e(){h&&h.addEventListener("click",d)}const f="string"==typeof a?document.querySelector(a):a,g=b||{},h=f.querySelector("[data-dialog-close]");return function(){e()}(),{open:function(){document.body.style.overflow="hidden",f.classList.remove("data-out"),f.classList.add("data-active"),g.onOpen&&g.onOpen()},close:c}}var makeDialog$1={init:makeDialog};module.exports=makeDialog$1;
