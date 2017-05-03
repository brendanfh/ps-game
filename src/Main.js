"use strict"

//module Main

exports.requestAnimationFrame = function(func) {
    return function() {
        var past = Date.now();
        window.requestAnimationFrame(function(time) {
            var now = Date.now();
            var time = (now - past) / 1000.0;
            func(time)();
        });
    }
};