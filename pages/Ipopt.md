---
title:  Ipopt (Interior Point OPTimizer) for ROOT
layout: content
toc: true
---
# Ipopt
{:.no_toc}
<center>
<img class="img-responsive" src="{{ site.baseurl }}/img/Ipopt.png" style="width: 50%;height: auto;"/>
</center>

* Table of Contents 
{:toc}
<br>


## Description 
-----------
Implementation for Ipopt (Interior Point OPTimizer) is a software package for large-scale ​nonlinear optimization.
It is designed to find (local) solutions of mathematical optimization problems.

The following information is required by IPOPT:
- **Problem dimensions**  
&nbsp;&nbsp; - number of variables  
&nbsp;&nbsp; - number of constraints  
- **Problem bounds**  
&nbsp;&nbsp;  - variable bounds  
&nbsp;&nbsp;  - constraint bounds  
- **Initial starting point**  
&nbsp;&nbsp;  - Initial values for the primal $$ x$$ variables  
&nbsp;&nbsp;  - Initial values for the multipliers (only required for a warm start option)  
- **Problem Structure**  
&nbsp;&nbsp;  - number of nonzeros in the Jacobian of the constraints  
&nbsp;&nbsp;  - number of nonzeros in the Hessian of the Lagrangian function  
&nbsp;&nbsp;  - sparsity structure of the Jacobian of the constraints  
&nbsp;&nbsp;  - sparsity structure of the Hessian of the Lagrangian function  
- **Evaluation of Problem Functions**  
&nbsp;&nbsp;  - Information evaluated using a given point ( $$ x,\lambda, \sigma_f$$ coming from IPOPT)  
&nbsp;&nbsp;  - Objective function, $$ f(x)$$  
&nbsp;&nbsp;  - Gradient of the objective  $$ \nabla f(x)$$  
&nbsp;&nbsp;  - Constraint function values, $$ g(x)$$  
&nbsp;&nbsp;  - Jacobian of the constraints,  $$ \nabla g(x)^T$$  
&nbsp;&nbsp;  - Hessian of the Lagrangian function,  $$ \sigma_f \nabla^2 f(x) + \sum_{i=1}^m\lambda_i\nabla^2 g_i(x)$$  

(this is not required if a quasi-Newton options is chosen to approximate the second derivatives)
The problem dimensions and bounds are straightforward and come solely from the problem definition. The initial
starting point is used by the algorithm when it begins iterating to solve the problem. If IPOPT has difficulty
converging, or if it converges to a locally infeasible point, adjusting the starting point may help. Depending on the
starting point, IPOPT may also converge to different local solutions.

See <A HREF="https://projects.coin-or.org/Ipopt">Ipopt doc</A>
from more info on the Ipopt minimization algorithms.

## Installation 
-----------

To install ROOT please read first.

- [https://root.cern.ch/building-root](https://root.cern.ch/building-root)
- [https://root.cern.ch/build-prerequisites](https://root.cern.ch/build-prerequisites)

To install Ipopt you will need subversion version control system.
To download it just to run

``` sh
svn co https://projects.coin-or.org/svn/Ipopt/stable/3.12 CoinIpopt
cd CoinIpopt
cd ThirdParty/Blas 
./get.Blas 
cd ../Lapack 
./get.Lapack 
cd ../ASL 
./get.ASL
cd ../Mumps
./get.Mumps
cd ../Metis
./get.Metis
cd ../../
./configure --prefix=/usr/local
make 
make install
```
More information on   
[https://www.coin-or.org/Ipopt/documentation/node12.html](https://www.coin-or.org/Ipopt/documentation/node12.html)  
[https://www.coin-or.org/Ipopt/documentation/node13.html](https://www.coin-or.org/Ipopt/documentation/node13.html)  


to enable it in ROOT just add -Dipopt in the cmake command
``` sh
cmake -Dipopt=ON ..
```
## ROOT Ipopt documentation
-----------
* Doxygen classes:
 * [http://clusteri.itm.edu.co/rootdoc/html/classROOT_1_1Math_1_1IpoptMinimizer.html](http://clusteri.itm.edu.co/rootdoc/html/classROOT_1_1Math_1_1IpoptMinimizer.html)
 * [http://clusteri.itm.edu.co/rootdoc/html/classROOT_1_1Math_1_1IpoptMinimizer_1_1InternalTNLP.html](http://clusteri.itm.edu.co/rootdoc/html/classROOT_1_1Math_1_1IpoptMinimizer_1_1InternalTNLP.html)

* Coinor website:
 * [https://projects.coin-or.org/Ipopt](https://projects.coin-or.org/Ipopt)

## Ipopt Solvers
-----------
Ipopt have a set of solvers(plugins) that can be installed  
&nbsp;&nbsp; - Mumps(MUltifrontal Massively Parallel sparse direct Solver) [https://www.coin-or.org/Ipopt/documentation/node60.html](https://www.coin-or.org/Ipopt/documentation/node60.html) and [http://mumps.enseeiht.fr/](http://mumps.enseeiht.fr/)  
&nbsp;&nbsp; - [http://www.hsl.rl.ac.uk/ipopt/](HSL) the solvers are Ma27, Ma57, Ma77, Ma86 and Ma97  
&nbsp;&nbsp; - Pardiso [https://www.coin-or.org/Ipopt/documentation/node61.html](https://www.coin-or.org/Ipopt/documentation/node61.html) and [http://www.pardiso-project.org/](http://www.pardiso-project.org/)  
&nbsp;&nbsp; - Wsmp (Watson Sparse Matrix Package)  [https://www.coin-or.org/Ipopt/documentation/node62.html](https://www.coin-or.org/Ipopt/documentation/node62.html) and [https://researcher.watson.ibm.com/researcher/view_group.php?id=1426](https://researcher.watson.ibm.com/researcher/view_group.php?id=1426)  

## Example
-----------
This is an example of minimization of the Rosenbrok function
using mumps solver.
``` cpp
#include "Math/IpoptMinimizer.h"
#include "Math/Functor.h"
 
double RosenBrock(const double *xx )
{
  const Double_t x = xx[0];
  const Double_t y = xx[1];
  const Double_t tmp1 = y-x*x;
  const Double_t tmp2 = 1-x;
  return 100*tmp1*tmp1+tmp2*tmp2;
}

int ipopt()
{
   // Choose method upon creation between:
   ROOT::Math::Experimental::IpoptMinimizer minimizer("mumps");
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
   return 0;
}
```

**Output**
``` sh
Processing ipopt.C...

******************************************************************************
This program contains Ipopt, a library for large-scale nonlinear optimization.
 Ipopt is released as open source code under the Eclipse Public License (EPL).
         For more information visit http://projects.coin-or.org/Ipopt
******************************************************************************

This is Ipopt version 3.12, running with linear solver mumps.
NOTE: Other linear solvers might be more efficient (see Ipopt documentation).

Number of nonzeros in equality constraint Jacobian...:        0
Number of nonzeros in inequality constraint Jacobian.:        0
Number of nonzeros in Lagrangian Hessian.............:        0

Total number of variables............................:        2
                     variables with only lower bounds:        0
                variables with lower and upper bounds:        0
                     variables with only upper bounds:        0
Total number of equality constraints.................:        0
Total number of inequality constraints...............:        0
        inequality constraints with only lower bounds:        0
   inequality constraints with lower and upper bounds:        0
        inequality constraints with only upper bounds:        0

iter    objective    inf_pr   inf_du lg(mu)  ||d||  lg(rg) alpha_du alpha_pr  ls
   0  1.4242000e+02 0.00e+00 1.00e+02   0.0 0.00e+00    -  0.00e+00 0.00e+00   0
   1  2.9766930e+01 0.00e+00 4.56e+01 -11.0 1.00e+02    -  1.00e+00 1.56e-02f  7
   2  1.3330139e+00 0.00e+00 6.41e+00 -11.0 4.57e-01    -  1.00e+00 1.00e+00f  1
   3  7.4468595e-01 0.00e+00 1.14e+00 -11.0 5.87e-02    -  1.00e+00 1.00e+00f  1
   4  7.0746238e-01 0.00e+00 6.39e-01 -11.0 1.25e-02    -  1.00e+00 1.00e+00f  1
   5  6.8970598e-01 0.00e+00 5.31e-01 -11.0 1.27e-02    -  1.00e+00 1.00e+00f  1
   6  6.3038185e-01 0.00e+00 3.25e+00 -11.0 1.35e-01    -  1.00e+00 1.00e+00f  1
   7  5.4902051e-01 0.00e+00 1.02e+00 -11.0 3.77e-02    -  1.00e+00 1.00e+00f  1
   8  4.8401842e-01 0.00e+00 6.45e-01 -11.0 3.95e-02    -  1.00e+00 1.00e+00f  1
   9  3.7607797e-01 0.00e+00 1.57e+00 -11.0 2.15e-01    -  1.00e+00 5.00e-01f  2
iter    objective    inf_pr   inf_du lg(mu)  ||d||  lg(rg) alpha_du alpha_pr  ls
  10  3.0198077e-01 0.00e+00 1.97e+00 -11.0 8.67e-02    -  1.00e+00 1.00e+00f  1
  11  1.8559008e-01 0.00e+00 3.12e-01 -11.0 9.41e-02    -  1.00e+00 1.00e+00f  1
  12  1.4132279e-01 0.00e+00 1.10e+00 -11.0 1.64e-01    -  1.00e+00 5.00e-01f  2
  13  1.0968924e-01 0.00e+00 1.58e+00 -11.0 7.87e-02    -  1.00e+00 1.00e+00f  1
  14  5.5615731e-02 0.00e+00 1.52e-01 -11.0 9.92e-02    -  1.00e+00 1.00e+00f  1
  15  3.9783475e-02 0.00e+00 9.44e-01 -11.0 1.53e-01    -  1.00e+00 5.00e-01f  2
  16  2.4567231e-02 0.00e+00 1.15e+00 -11.0 8.70e-02    -  1.00e+00 1.00e+00f  1
  17  9.4233095e-03 0.00e+00 1.58e-01 -11.0 6.91e-02    -  1.00e+00 1.00e+00f  1
  18  5.7018750e-03 0.00e+00 1.07e+00 -11.0 1.11e-01    -  1.00e+00 1.00e+00f  1
  19  2.4713173e-03 0.00e+00 6.49e-02 -11.0 2.40e-02    -  1.00e+00 1.00e+00f  1
iter    objective    inf_pr   inf_du lg(mu)  ||d||  lg(rg) alpha_du alpha_pr  ls
  20  1.0791127e-03 0.00e+00 6.34e-02 -11.0 3.25e-02    -  1.00e+00 1.00e+00f  1
  21  1.7677923e-04 0.00e+00 2.06e-01 -11.0 5.43e-02    -  1.00e+00 1.00e+00f  1
  22  3.5476153e-05 0.00e+00 9.36e-02 -11.0 5.79e-03    -  1.00e+00 1.00e+00f  1
  23  2.8353165e-08 0.00e+00 1.27e-03 -11.0 3.88e-03    -  1.00e+00 1.00e+00f  1
  24  1.9942280e-10 0.00e+00 1.52e-04 -11.0 2.80e-04    -  1.00e+00 1.00e+00f  1
  25  1.3175696e-14 0.00e+00 1.50e-06 -11.0 2.16e-05    -  1.00e+00 1.00e+00f  1
  26  8.2392610e-16 0.00e+00 3.69e-07 -11.0 1.82e-07    -  1.00e+00 1.00e+00f  1
  27  2.4171191e-27 0.00e+00 8.13e-13 -11.0 3.71e-08    -  1.00e+00 1.00e+00f  1

Number of Iterations....: 27

                                   (scaled)                 (unscaled)
Objective...............:   1.0155962678167805e-27    2.4171191174037565e-27
Dual infeasibility......:   8.1323059158110567e-13    1.9354888079628865e-12
Constraint violation....:   0.0000000000000000e+00    0.0000000000000000e+00
Complementarity.........:   0.0000000000000000e+00    0.0000000000000000e+00
Overall NLP error.......:   8.1323059158110567e-13    1.9354888079628865e-12


Number of objective function evaluations             = 53
Number of objective gradient evaluations             = 28
Number of equality constraint evaluations            = 0
Number of inequality constraint evaluations          = 0
Number of equality constraint Jacobian evaluations   = 0
Number of inequality constraint Jacobian evaluations = 0
Number of Lagrangian Hessian evaluations             = 0
Total CPU secs in IPOPT (w/o function evaluations)   =      0.011
Total CPU secs in NLP function evaluations           =      0.000

EXIT: Optimal Solution Found.


Solution of the primal variables, x
x[0] = 1
x[1] = 1

Solution of the bound multipliers, z_L and z_U
z_L[0] = 0
z_L[1] = 0
z_U[0] = 0
z_U[1] = 0

Objective value
f(x*) = 2.41712e-27

Final value of the constraints:

*** The problem solved in 27 iterations!

*** The final value of the objective function is 2.41712e-27.
Minimum: f(1,1): 2.41712e-27

```

## Current Status and Supported Features
ROOT ipopt interface is under development and this is the current status.  
**Support for :**  
&nbsp;&nbsp; * minimization give a function to minimize with constraints  
&nbsp;&nbsp; * gradient of the function to minimize  
**What is not supported yet :**  
&nbsp;&nbsp; * Constraint function $$g(x): R^n - > R^m$$  
&nbsp;&nbsp; * Gradient of the constraint function  
&nbsp;&nbsp; * Hessian  
 


