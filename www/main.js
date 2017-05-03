// Generated by psc-bundle 0.11.1
var PS = {};
(function(exports) {
    "use strict";

  exports.unit = {};
})(PS["Data.Unit"] = PS["Data.Unit"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Data.Unit"];
  var Data_Show = PS["Data.Show"];
  exports["unit"] = $foreign.unit;
})(PS["Data.Unit"] = PS["Data.Unit"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Data.Functor"];
  var Control_Semigroupoid = PS["Control.Semigroupoid"];
  var Data_Function = PS["Data.Function"];
  var Data_Unit = PS["Data.Unit"];        
  var Functor = function (map) {
      this.map = map;
  };
  var map = function (dict) {
      return dict.map;
  };
  exports["Functor"] = Functor;
  exports["map"] = map;
})(PS["Data.Functor"] = PS["Data.Functor"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Control.Apply"];
  var Control_Category = PS["Control.Category"];
  var Data_Function = PS["Data.Function"];
  var Data_Functor = PS["Data.Functor"];        
  var Apply = function (Functor0, apply) {
      this.Functor0 = Functor0;
      this.apply = apply;
  };                      
  var apply = function (dict) {
      return dict.apply;
  };
  exports["Apply"] = Apply;
  exports["apply"] = apply;
})(PS["Control.Apply"] = PS["Control.Apply"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var Control_Apply = PS["Control.Apply"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Unit = PS["Data.Unit"];        
  var Applicative = function (Apply0, pure) {
      this.Apply0 = Apply0;
      this.pure = pure;
  };
  var pure = function (dict) {
      return dict.pure;
  };
  var liftA1 = function (dictApplicative) {
      return function (f) {
          return function (a) {
              return Control_Apply.apply(dictApplicative.Apply0())(pure(dictApplicative)(f))(a);
          };
      };
  };
  exports["Applicative"] = Applicative;
  exports["liftA1"] = liftA1;
  exports["pure"] = pure;
})(PS["Control.Applicative"] = PS["Control.Applicative"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Control.Bind"];
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Apply = PS["Control.Apply"];
  var Control_Category = PS["Control.Category"];
  var Data_Function = PS["Data.Function"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Unit = PS["Data.Unit"];        
  var Bind = function (Apply0, bind) {
      this.Apply0 = Apply0;
      this.bind = bind;
  };                     
  var bind = function (dict) {
      return dict.bind;
  };
  exports["Bind"] = Bind;
  exports["bind"] = bind;
})(PS["Control.Bind"] = PS["Control.Bind"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Apply = PS["Control.Apply"];
  var Control_Bind = PS["Control.Bind"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Unit = PS["Data.Unit"];        
  var Monad = function (Applicative0, Bind1) {
      this.Applicative0 = Applicative0;
      this.Bind1 = Bind1;
  };
  var ap = function (dictMonad) {
      return function (f) {
          return function (a) {
              return Control_Bind.bind(dictMonad.Bind1())(f)(function (v) {
                  return Control_Bind.bind(dictMonad.Bind1())(a)(function (v1) {
                      return Control_Applicative.pure(dictMonad.Applicative0())(v(v1));
                  });
              });
          };
      };
  };
  exports["Monad"] = Monad;
  exports["ap"] = ap;
})(PS["Control.Monad"] = PS["Control.Monad"] || {});
(function(exports) {
    "use strict";

  exports.pureE = function (a) {
    return function () {
      return a;
    };
  };

  exports.bindE = function (a) {
    return function (f) {
      return function () {
        return f(a())();
      };
    };
  };
})(PS["Control.Monad.Eff"] = PS["Control.Monad.Eff"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff"];
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Apply = PS["Control.Apply"];
  var Control_Bind = PS["Control.Bind"];
  var Control_Monad = PS["Control.Monad"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Unit = PS["Data.Unit"];        
  var monadEff = new Control_Monad.Monad(function () {
      return applicativeEff;
  }, function () {
      return bindEff;
  });
  var bindEff = new Control_Bind.Bind(function () {
      return applyEff;
  }, $foreign.bindE);
  var applyEff = new Control_Apply.Apply(function () {
      return functorEff;
  }, Control_Monad.ap(monadEff));
  var applicativeEff = new Control_Applicative.Applicative(function () {
      return applyEff;
  }, $foreign.pureE);
  var functorEff = new Data_Functor.Functor(Control_Applicative.liftA1(applicativeEff));
  exports["functorEff"] = functorEff;
  exports["applyEff"] = applyEff;
  exports["applicativeEff"] = applicativeEff;
  exports["bindEff"] = bindEff;
  exports["monadEff"] = monadEff;
})(PS["Control.Monad.Eff"] = PS["Control.Monad.Eff"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var Control_Alt = PS["Control.Alt"];
  var Control_Alternative = PS["Control.Alternative"];
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Apply = PS["Control.Apply"];
  var Control_Bind = PS["Control.Bind"];
  var Control_Category = PS["Control.Category"];
  var Control_Extend = PS["Control.Extend"];
  var Control_Monad = PS["Control.Monad"];
  var Control_MonadZero = PS["Control.MonadZero"];
  var Control_Plus = PS["Control.Plus"];
  var Data_Bounded = PS["Data.Bounded"];
  var Data_Eq = PS["Data.Eq"];
  var Data_Function = PS["Data.Function"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Functor_Invariant = PS["Data.Functor.Invariant"];
  var Data_Monoid = PS["Data.Monoid"];
  var Data_Ord = PS["Data.Ord"];
  var Data_Ordering = PS["Data.Ordering"];
  var Data_Semigroup = PS["Data.Semigroup"];
  var Data_Show = PS["Data.Show"];
  var Data_Unit = PS["Data.Unit"];
  var Prelude = PS["Prelude"];        
  var Nothing = (function () {
      function Nothing() {

      };
      Nothing.value = new Nothing();
      return Nothing;
  })();
  var Just = (function () {
      function Just(value0) {
          this.value0 = value0;
      };
      Just.create = function (value0) {
          return new Just(value0);
      };
      return Just;
  })();
  exports["Nothing"] = Nothing;
  exports["Just"] = Just;
})(PS["Data.Maybe"] = PS["Data.Maybe"] || {});
(function(exports) {
  /* global exports */
  "use strict";

  exports.getCanvasElementByIdImpl = function(id, Just, Nothing) {
      return function() {
          var el = document.getElementById(id);
          if (el && el instanceof HTMLCanvasElement) {
              return Just(el);
          } else {
              return Nothing;
          }
      };
  };

  exports.getContext2D = function(c) {
      return function() {
          return c.getContext('2d');
      };
  };

  exports.setFillStyle = function(style) {
      return function(ctx) {
          return function() {
              ctx.fillStyle = style;
              return ctx;
          };
      };
  };

  exports.fillRect = function(ctx) {
      return function(r) {
          return function() {
              ctx.fillRect(r.x, r.y, r.w, r.h);
              return ctx;
          };
      };
  };
})(PS["Graphics.Canvas"] = PS["Graphics.Canvas"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Graphics.Canvas"];
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Bind = PS["Control.Bind"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_Exception_Unsafe = PS["Control.Monad.Eff.Exception.Unsafe"];
  var Control_Semigroupoid = PS["Control.Semigroupoid"];
  var Data_ArrayBuffer_Types = PS["Data.ArrayBuffer.Types"];
  var Data_Function = PS["Data.Function"];
  var Data_Function_Uncurried = PS["Data.Function.Uncurried"];
  var Data_Functor = PS["Data.Functor"];
  var Data_Maybe = PS["Data.Maybe"];
  var Data_Semigroup = PS["Data.Semigroup"];
  var Data_Show = PS["Data.Show"];
  var Prelude = PS["Prelude"];
  var getCanvasElementById = function (elId) {
      return $foreign.getCanvasElementByIdImpl(elId, Data_Maybe.Just.create, Data_Maybe.Nothing.value);
  };
  exports["getCanvasElementById"] = getCanvasElementById;
  exports["fillRect"] = $foreign.fillRect;
  exports["getContext2D"] = $foreign.getContext2D;
  exports["setFillStyle"] = $foreign.setFillStyle;
})(PS["Graphics.Canvas"] = PS["Graphics.Canvas"] || {});
(function(exports) {
    "use strict";

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
})(PS["Main"] = PS["Main"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var update = function (v) {
      return function (f) {
          return function (b) {
              return v.update(f)(b);
          };
      };
  };
  var create = function (get1) {
      return function (update1) {
          return {
              get: get1, 
              update: update1
          };
      };
  };
  exports["create"] = create;
  exports["update"] = update;
})(PS["Util.Focus"] = PS["Util.Focus"] || {});
(function(exports) {
    "use strict";

  exports.sin = function(num) {
      return Math.sin(num);
  }
})(PS["Util.Math"] = PS["Util.Math"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Util.Math"];
  exports["sin"] = $foreign.sin;
})(PS["Util.Math"] = PS["Util.Math"] || {});
(function(exports) {
  // Generated by purs version 0.11.1
  "use strict";
  var $foreign = PS["Main"];
  var Control_Applicative = PS["Control.Applicative"];
  var Control_Bind = PS["Control.Bind"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  var Data_Function = PS["Data.Function"];
  var Data_Maybe = PS["Data.Maybe"];
  var Data_Semiring = PS["Data.Semiring"];
  var Data_Unit = PS["Data.Unit"];
  var Graphics_Canvas = PS["Graphics.Canvas"];
  var Partial_Unsafe = PS["Partial.Unsafe"];
  var Prelude = PS["Prelude"];
  var Util_Focus = PS["Util.Focus"];
  var Util_Math = PS["Util.Math"];        
  var view = function (gs) {
      return function (ctx) {
          return function __do() {
              var v = Graphics_Canvas.setFillStyle("white")(ctx)();
              var v1 = Graphics_Canvas.fillRect(ctx)({
                  x: 0.0, 
                  y: 0.0, 
                  w: 800.0, 
                  h: 600.0
              })();
              var v2 = Graphics_Canvas.setFillStyle("black")(ctx)();
              var v3 = Graphics_Canvas.fillRect(ctx)({
                  x: Util_Math.sin(gs.num) * 100.0 + 100.0, 
                  y: 0.0, 
                  w: 100.0, 
                  h: 100.0
              })();
              return Data_Unit.unit;
          };
      };
  };
  var num = Util_Focus.create(function (r) {
      return r.num;
  })(function (f) {
      return function (r) {
          var $13 = {};
          for (var $14 in r) {
              if ({}.hasOwnProperty.call(r, $14)) {
                  $13[$14] = r[$14];
              };
          };
          $13.num = f(r.num);
          return $13;
      };
  });
  var update = function (time) {
      return function (gs) {
          var ngs = Util_Focus.update(num)(function (n) {
              return n + time;
          })(gs);
          return Control_Applicative.pure(Control_Monad_Eff.applicativeEff)(ngs);
      };
  };
  var initial = Control_Applicative.pure(Control_Monad_Eff.applicativeEff)({
      num: 0.0
  });
  var main = function __do() {
      var v = Graphics_Canvas.getCanvasElementById("maincanvas")();
      var __unused = function (dictPartial1) {
          return function ($dollar10) {
              return $dollar10;
          };
      };
      return __unused()((function () {
          if (v instanceof Data_Maybe.Just) {
              return function __do() {
                  var v1 = Graphics_Canvas.getContext2D(v.value0)();
                  var v2 = initial();
                  var loop = function (gameState) {
                      return function (time) {
                          return function __do() {
                              var v3 = update(time)(gameState)();
                              view(v3)(v1)();
                              return $foreign.requestAnimationFrame(loop(v3))();
                          };
                      };
                  };
                  $foreign.requestAnimationFrame(loop(v2))();
                  return Data_Unit.unit;
              };
          };
          throw new Error("Failed pattern match at Main line 42, column 5 - line 43, column 5: " + [ v.constructor.name ]);
      })())();
  };
  exports["initial"] = initial;
  exports["main"] = main;
  exports["num"] = num;
  exports["update"] = update;
  exports["view"] = view;
  exports["requestAnimationFrame"] = $foreign.requestAnimationFrame;
})(PS["Main"] = PS["Main"] || {});
