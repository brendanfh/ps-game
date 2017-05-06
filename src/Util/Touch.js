"use strict";

//module Util.Touch

function getTouchIndex(touches, findID) {
    for (var i=0; i < touches.length; i++) {
        var id = touches[i].identifier;
        if(id == findID) {
             return i;
        }
    }
    return -1;
}

exports.setupTouch = function (touchRef) {
    return function() {
        document.addEventListener("touchstart", function(evt) {
            var touches = evt.changedTouches;
            for (var i=0; i < touches.length; i++) {
                touchRef.value.touches.push({ x : touches[i].pageX
                                            , y : touches[i].pageY
                                            , identifier : touches[i].identifier});
            }
            
            return false;
        });
        document.addEventListener("touchmove", function(evt) {
            var touches = evt.changedTouches;
            for (var i=0; i< touches.length; i++) {
                var idx = getTouchIndex(touchRef.value.touches, touches[i].identifier);
                touchRef.value.touches.splice(idx, 1, { x : touches[i].pageX
                                                      , y : touches[i].pageY
                                                      , identifier : touches[i].identifier});
            }
            
            return false;
        });
        document.addEventListener("touchend", function(evt) {
            var touches = evt.changedTouches;
            for (var i=0; i < touches.length; i++) {
                var idx = getTouchIndex(touchRef.value.touches, touches[i].identifier);
                touchRef.value.touches.splice(idx, 1);
            }
            
            return false;
        });
        document.addEventListener("touchcancel", function(evt) {
            var touches = evt.changedTouches;
            for (var i=0; i < touches.length; i++) {
                var idx = getTouchIndex(touchRef.value.touches, touches[i].identifier);
                touchRef.value.touches.splice(idx, 1);
            }
            
            return false;
        });
        return {};
    }
};