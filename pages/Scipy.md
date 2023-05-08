---
title:  Scipy Optimizer for ROOT
layout: content
toc: true
---
# Scipy
{:.no_toc}
<center>
<img class="img-responsive" src="{{ site.baseurl }}/img/Scipy.png" style="width: 50%;height: auto;"/>
</center>

* Table of Contents 
{:toc}
<br>


## Description 
-----------
Implementation for Scipy minimizer in ROOT math libraries.
This is an interface written in C++ using Python C-API and the plugin system implemented in the meth libraries
in ROOT.
This is under active development and hopefully It will be integrated to ROOT in the future.

See <A HREF="https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html">Scipy doc</A>
from more info on the Scipy minimization algorithms.

## Installation 
-----------

To install ROOT please read first.

- [https://root.cern.ch/building-root](https://root.cern.ch/building-root)
- [https://root.cern.ch/build-prerequisites](https://root.cern.ch/build-prerequisites)

To install scipy

``` sh
pip3 install numpy scipy
```

Download code from github in the branch scipy
``` 
https://github.com/omazapa/root/tree/scipy
```

to enable it in ROOT just add -Dscipy in the cmake command
``` sh
cmake -Dscipy=ON ..
```
## ROOT and Scipy documentation
-----------
See <A HREF="https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html">Scipy doc</A>
for more info on the Scipy minimization algorithms.

See <A HREF="https://root.cern.ch/root/htmldoc/guides/minuit2/Minuit2.html">Minuit2 Guide</A><br>
See <A HREF="https://seal.web.cern.ch/documents/minuit/mntutorial.pdf">Minuit2 Tutorial</A><br>
See <A HREF="https://root.cern.ch/doc/master/classROOT_1_1Math_1_1Minimizer.html">Minimizer class</A><br>
for more info on the ROOT minimization algorithms.

You can find some code benchmarking minimizers <A HREF="https://github.com/omazapa/root_minimizers_tests/">here</A>

## Example
-----------
This is an example of minimization of the Rosenbrok function
using multiple algoritms.
``` cpp
#include "Math/ScipyMinimizer.h"
#include "Math/Functor.h"
#include <string>

double RosenBrock(const double *xx )
{
  const Double_t x = xx[0];
  const Double_t y = xx[1];
  const Double_t tmp1 = y-x*x;
  const Double_t tmp2 = 1-x;
  return 100*tmp1*tmp1+tmp2*tmp2;
}

////"Newton-CG", "dogleg", "trust-ncg","trust-exact","trust-krylov"
using namespace std;
int scipy()
{ 
   
   std::string methods[]={"Nelder-Mead","L-BFGS-B","Powell","CG","BFGS","TNC","COBYLA","SLSQP","trust-constr"};
   // Choose method upon creation between:

   for(const std::string &text : methods)
   {
   ROOT::Math::Experimental::ScipyMinimizer minimizer(text.c_str());
   minimizer.SetMaxFunctionCalls(1000000);
   minimizer.SetMaxIterations(100000);
   minimizer.SetTolerance(0.001);
    
   ROOT::Math::Functor f(&RosenBrock,2); 
   double step[2] = {0.01,0.01};
   double variable[2] = { 0.1,1.2};
 
   minimizer.SetFunction(f);
 
   // Set the free variables to be minimized!
   minimizer.SetVariable(0,"x",variable[0], step[0]);
   minimizer.SetVariable(1,"y",variable[1], step[1]);
 
   minimizer.Minimize(); 
 
   const double *xs = minimizer.X();
   cout << "Minimum: f(" << xs[0] << "," << xs[1] << "): " 
        << RosenBrock(xs) << endl;
   cout << endl << "===============" << endl;
   }
   return 0;
}
```

**Output**
``` sh
ozapatam@tuxito:~/tmp/root_scipy_tests$ root -l -q scipy.C 

Processing scipy.C...
=== Scipy Minimization
=== Method: Nelder-Mead
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully.
=== Function calls: 164
Minimum: f(0.999984,0.999969): 2.91866e-10

===============
=== Scipy Minimization
=== Method: L-BFGS-B
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: CONVERGENCE: REL_REDUCTION_OF_F_<=_FACTR*EPSMCH
=== Function calls: 81
Minimum: f(0.999997,0.999994): 1.17739e-11

===============
=== Scipy Minimization
=== Method: Powell
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully.
=== Function calls: 213
Minimum: f(1,1): 2.32911e-28

===============
=== Scipy Minimization
=== Method: CG
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully.
=== Function calls: 120
Minimum: f(1,1): 2.47448e-13

===============
=== Scipy Minimization
=== Method: BFGS
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully.
=== Function calls: 96
Minimum: f(0.999996,0.999991): 2.00488e-11

===============
=== Scipy Minimization
=== Method: TNC
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Converged (|f_n-f_(n-1)| ~= 0)
=== Function calls: 192
Minimum: f(0.999991,0.999983): 7.99587e-11

===============
=== Scipy Minimization
=== Method: COBYLA
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully.
=== Function calls: 387
Minimum: f(1.08352,1.17468): 0.00701966

===============
=== Scipy Minimization
=== Method: SLSQP
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: Optimization terminated successfully
=== Function calls: 70
Minimum: f(1.00002,1.00004): 2.20434e-09

===============
=== Scipy Minimization
=== Method: trust-constr
=== Initial value: (0.1,1.2)
=== Status: 0
=== Message: `gtol` termination condition is satisfied.
=== Function calls: 105
Minimum: f(0.999996,0.999991): 2.00614e-11

===============
(int) 0
```

## Current Status and Supported Features
* Integrated to the plugin system in ROOT
* Support to pass jacobian and Hessian
* It does not support constraints (Under development)

Many features that can be implemented coming soon! 



