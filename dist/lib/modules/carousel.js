'use strict';function _interopDefault(a){return a&&"object"==typeof a&&"default"in a?a["default"]:a}var Flickity=_interopDefault(require("flickity"));function makeCarousel(a,b){const c="string"==typeof a?document.querySelector(a):a;(function(){new Flickity(c,b)})()}function makeManyCarousel(a,b){const c=Array.from(document.querySelectorAll(a)),d=[];(function(){c.forEach(a=>{d.push(new Flickity(a,b))})})()}var makeCarousel$1={init:makeCarousel,initMany:makeManyCarousel};module.exports=makeCarousel$1;
