(async (__global, __import) => {
void (({_:{grad:__global.grad},_:{linspace:__global.linspace},_:{plot:__global.plot}} = {_:await __import("propel")}))

f = x => x.tanh();
x = linspace(-4, 4, 200);
return (plot(x, f(x),
     x, grad(f)(x),
     x, grad(grad(f))(x),
     x, grad(grad(grad(f)))(x),
     x, grad(grad(grad(grad(f))))(x)))
})
//# sourceURL=__cell1__.js