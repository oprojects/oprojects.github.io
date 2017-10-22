---
title: R TMVA
layout: content
toc: true
---
# R TMVA
{:.no_toc}
<img class="img-responsive" src="{{ site.baseurl }}/img/GSoC2015.png"/>

* Table of Contents 
{:toc}
<br>


## Description 
-----------
RMVA is a set of plugins for TMVA based on ROOTR that allows the use of R's classification and regression in TMVA.
<img class="img-responsive" src="{{ site.baseurl }}/img/RMVADataFlow.png"/>


## Installation 
-----------
Install needed R packages, open R and in the prompt type.
```sh
install.packages(c('Rcpp','RInside','C50','ROCR','caret','RSNNS','e1071','devtools'), dependencies=TRUE)
```
select a mirror and install. For xgboost.
```sh
devtools::install_github('dmlc/xgboost',subdir='R-package')
```
Download code from git repo.
```sh
git clone   https://github.com/root-mirror/root.git
```
To compile ROOTR lets to create a compilation directory and to activate it use cmake -Dr=ON ..
```sh
mkdir compile
cd compile
cmake -Dr=ON ..
make -j n
```
Where n is the number of parallel jobs to compile.


## Boosted Decision Trees and Rule-Based Models (Package C50)
-----------

### C50 Booking Options
Configuration options reference for MVA method: C50
<h2 class="showhide_heading" id="a80792f5c4f02162aca6505d537e1ef2d"><strong><a id="C50Booking">C50 Booking Options</a></strong></h2>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell"  colspan="4"><span style="color:#06F; background-color:">Configuration options reference for MVA method: C50</span></td></tr><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span></td></tr><tr><td class="wikicell" ><strong>nTrials</strong></td><td class="wikicell" > 1  </td><td class="wikicell" > - </td><td class="wikicell" >an integer specifying the number of boosting iterations. A           value of one indicates that a single model is used.   </td></tr><tr><td class="wikicell" ><strong>Rules</strong></td><td class="wikicell" >  kFALSE </td><td class="wikicell" > - </td><td class="wikicell" >A logical: should the tree be decomposed into a rule-based           model?</td></tr><tr><td class="wikicell"  colspan="4"><span style="color:#06F; background-color:">Configuration options for C5.0Control : C50</span></td></tr><tr><td class="wikicell" ><strong>ControlSubset</strong></td><td class="wikicell" > kTRUE </td><td class="wikicell" > - </td><td class="wikicell" >AA logical: should the model evaluate groups of discrete predictors for splits? Note: the C5.0 command line version defaults this parameter to ‘FALSE’, meaning no attempted gropings will be evaluated during the tree growing stage.  </td></tr><tr><td class="wikicell" ><strong>ControlBands</strong></td><td class="wikicell" >0 </td><td class="wikicell" >2-1000 </td><td class="wikicell" > An integer between 2 and 1000. If ‘TRUE’, the model orders the rules by their affect on the error rate and groups the rules into the specified number of bands. This modifies the output so that the effect on the error rate can be seen for  the groups of rules within a band. If this options is selected and ‘rules = kFALSE’, a warning is issued and ‘rules’ is changed to ‘kTRUE’.  </td></tr><tr><td class="wikicell" ><strong>ControlWinnow</strong> </td><td class="wikicell" > kFALSE </td><td class="wikicell" > - </td><td class="wikicell" > A logical: should predictor winnowing (i.e feature selection) be used?  </td></tr><tr><td class="wikicell" ><strong>ControlNoGlobalPruning</strong> </td><td class="wikicell" >kFALSE</td><td class="wikicell" > -  </td><td class="wikicell" > A logical to toggle whether the final, global pruning step to simplify the tree.</td></tr><tr><td class="wikicell" ><strong>ControlCF</strong></td><td class="wikicell" > 0.25 </td><td class="wikicell" > - </td><td class="wikicell" > A number in (0, 1) for the confidence factor.</td></tr><tr><td class="wikicell" ><strong>ControlMinCases </strong></td><td class="wikicell" > 2 </td><td class="wikicell" > - </td><td class="wikicell" > An integer for the smallest number of samples that must be put in at least two of the splits.</td></tr><tr><td class="wikicell" ><strong>ControlFuzzyThreshold</strong> </td><td class="wikicell" > kFALSE </td><td class="wikicell" > - </td><td class="wikicell" > A logical toggle to evaluate possible advanced splits of the data. See Quinlan (1993) for details and examples.</td></tr><tr><td class="wikicell" ><strong>ControlSample</strong></td><td class="wikicell" > 0 </td><td class="wikicell" > - </td><td class="wikicell" > A value between (0, .999) that specifies the random proportion of the data should be used to train the model. By default, all the samples are used for model training. Samples not used for training are used to evaluate the accuracy of the model in the printed output.</td></tr><tr><td class="wikicell" ><strong>ControlSeed</strong> </td><td class="wikicell" > ? </td><td class="wikicell" > -  </td><td class="wikicell" >  An integer for the random number seed within the C code.</td></tr><tr><td class="wikicell" ><strong>ControlEarlyStopping</strong> </td><td class="wikicell" > kTRUE </td><td class="wikicell" > -  </td><td class="wikicell" > A logical to toggle whether the internal method for stopping boosting should be used.</td></tr></table>

### Example Booking C50 to generate Rule Based Model
```c++
factory->BookMethod( loader, TMVA::Types::kC50, "C50",
   "!H:NTrials=10:Rules=kTRUE:ControlSubSet=kFALSE:ControlBands=10:ControlWinnow=kFALSE:ControlNoGlobalPruning=kTRUE:ControlCF=0.25:ControlMinCases=2:ControlFuzzyThreshold=kTRUE:ControlSample=0:ControlEarlyStopping=kTRUE:!V" );
```
**NOTE:** Options Rules=kTRUE and to Control the bands use ControlBands

### Example Booking C50 to generate Boosted Decision Trees Model
```c++
factory->BookMethod(loader, TMVA::Types::kC50, "C50",
   "!H:NTrials=10:Rules=kFALSE:ControlSubSet=kFALSE:ControlWinnow=kFALSE:ControlNoGlobalPruning=kTRUE:ControlCF=0.25:ControlMinCases=2:ControlFuzzyThreshold=kTRUE:ControlSample=0:ControlEarlyStopping=kTRUE:!V" );
```
**NOTE:** Options Rules=kFALSE or remove this option because by default is Boosted Decision Tree Model and remove ControlBands option that is only for Rule Based model.

### C50 Output
RMVA produces output in stdout, in the .root file indicate in TMVA::Factory and in a directory called C50. in the directory you can find at the moment a dir called plots with ROC curve, but It will have a .RData file with all R's objects used for ROOTR if you want to reproduce the procedures again or try other stuff.

### C50 Plot
<img class="img-responsive" src="{{ site.baseurl }}/img/C50ROC.png"/>

### C50 Example
```c++
#include "TFile.h"
#include "TTree.h"
#include "TString.h"

#include "TMVA/Factory.h"
#include "TMVA/Tools.h"
#include<TMVA/MethodC50.h>

void c50()
{
   // This loads the library
   TMVA::Tools::Instance();

   // Create a ROOT output file where TMVA will store ntuples, histograms, etc.
   TString outfileName( "TMVA.root" );
   TFile* outputFile = TFile::Open( outfileName, "RECREATE" );

   TMVA::Factory *factory = new TMVA::Factory( "RMVAClassification", outputFile,
                                               "!V:!Silent:Color:DrawProgressBar:Transformations=I;D;P;G,D:AnalysisType=Classification" );
   TMVA::DataLoader *loader=new TMVA::DataLoader("dataset");


    // Define the input variables that shall be used for the MVA training
   loader->AddVariable( "myvar1 := var1+var2", 'F' );
   loader->AddVariable( "myvar2 := var1-var2", "Expression 2", "", 'F' );
   loader->AddVariable( "var3",                "Variable 3", "units", 'F' );
   loader->AddVariable( "var4",                "Variable 4", "units", 'F' );

   // You can add so-called "Spectator variables", which are not used in the MVA training,
   // but will appear in the final "TestTree" produced by TMVA. This TestTree will contain the
   // input variables, the response values of all trained MVAs, and the spectator variables
   loader->AddSpectator( "spec1 := var1*2",  "Spectator 1", "units", 'F' );
   loader->AddSpectator( "spec2 := var1*3",  "Spectator 2", "units", 'F' );

     // Read training and test data
   TString fname = "./tmva_class_example.root";
   if (gSystem->AccessPathName( fname ))  // file does not exist in local directory
      gSystem->Exec("curl -O http://root.cern.ch/files/tmva_class_example.root");
 
   TFile *input = TFile::Open( fname );
   std::cout << "--- TMVAClassification       : Using input file: " << input->GetName() << std::endl;
 
   // --- Register the training and test trees
   TTree *tsignal     = (TTree*)input->Get("TreeS");
   TTree *tbackground = (TTree*)input->Get("TreeB");
 
   // global event weights per tree (see below for setting event-wise weights)
   Double_t signalWeight     = 1.0;
   Double_t backgroundWeight = 1.0;
 
   // You can add an arbitrary number of signal or background trees
   loader->AddSignalTree    ( tsignal,     signalWeight     );
   loader->AddBackgroundTree( tbackground, backgroundWeight );
 

    // Set individual event weights (the variables must exist in the original TTree)
   //    for signal    : factory->SetSignalWeightExpression    ("weight1*weight2");
   //    for background: factory->SetBackgroundWeightExpression("weight1*weight2");
   loader->SetBackgroundWeightExpression( "weight" );
 

      // Apply additional cuts on the signal and background samples (can be different)
   TCut mycuts = ""; // for example: TCut mycuts = "abs(var1)<0.5 && abs(var2-0.5)<1";
   TCut mycutb = ""; // for example: TCut mycutb = "abs(var1)<0.5";

      // Tell the factory how to use the training and testing events

   // If no numbers of events are given, half of the events in the tree are used 
   // for training, and the other half for testing:
   //    factory->PrepareTrainingAndTestTree( mycut, "SplitMode=random:!V" );
   // To also specify the number of testing events, use:
   //    factory->PrepareTrainingAndTestTree( mycut,
   //                                         "NSigTrain=3000:NBkgTrain=3000:NSigTest=3000:NBkgTest=3000:SplitMode=Random:!V" );
   loader->PrepareTrainingAndTestTree( mycuts, mycutb,
                                        "nTrain_Signal=0:nTrain_Background=0:SplitMode=Random:NormMode=NumEvents:!V" );

   // Boosted Decision Trees
   // Gradient Boost
   factory->BookMethod(loader, TMVA::Types::kBDT, "BDTG",
                           "!H:!V:NTrees=1000:MinNodeSize=2.5%:BoostType=Grad:Shrinkage=0.10:UseBaggedBoost:BaggedSampleFraction=0.5:nCuts=20:MaxDepth=2" );

   // Adaptive Boost
   factory->BookMethod(loader, TMVA::Types::kBDT, "BDT",
                           "!H:!V:NTrees=850:MinNodeSize=2.5%:MaxDepth=3:BoostType=AdaBoost:AdaBoostBeta=0.5:UseBaggedBoost:BaggedSampleFraction=0.5:SeparationType=GiniIndex:nCuts=20" );

   // Bagging
   factory->BookMethod(loader, TMVA::Types::kBDT, "BDTB",
                           "!H:!V:NTrees=400:BoostType=Bagging:SeparationType=GiniIndex:nCuts=20" );

   // Decorrelation + Adaptive Boost
   factory->BookMethod(loader, TMVA::Types::kBDT, "BDTD",
                           "!H:!V:NTrees=400:MinNodeSize=5%:MaxDepth=3:BoostType=AdaBoost:SeparationType=GiniIndex:nCuts=20:VarTransform=Decorrelate" );

   // Allow Using Fisher discriminant in node splitting for (strong) linearly correlated variables
   factory->BookMethod(loader, TMVA::Types::kBDT, "BDTMitFisher",
                           "!H:!V:NTrees=50:MinNodeSize=2.5%:UseFisherCuts:MaxDepth=3:BoostType=AdaBoost:AdaBoostBeta=0.5:SeparationType=GiniIndex:nCuts=20" );

   factory->BookMethod(loader, TMVA::Types::kC50, "C50",
      "!H:NTrials=10:Rules=kFALSE:ControlSubSet=kFALSE:ControlNoGlobalPruning=kFALSE:ControlCF=0.25:ControlMinCases=2:ControlFuzzyThreshold=kTRUE:ControlSample=0:ControlEarlyStopping=kTRUE:!V" );

   // Train MVAs using the set of training events
   factory->TrainAllMethods();

   // ---- Evaluate all MVAs using the set of test events
   factory->TestAllMethods();

   // ----- Evaluate and compare performance of all configured MVAs
   factory->EvaluateAllMethods();

   // --------------------------------------------------------------

   // Save the output
   outputFile->Close();

   std::cout << "==> Wrote root file: " << outputFile->GetName() << std::endl;
   std::cout << "==> TMVAClassification is done!" << std::endl;

   delete factory;
  delete loader;
}
```
<br>
## Neural Networks in R using the Stuttgart Neural Network Simulator (Package RSNNS)
-----------
The Stuttgart Neural Network Simulator (SNNS) is a library containing many standard implementations of neural networks. This package wraps the SNNS functionality to make it available from within R. Using the RSNNS low-level interface, all of the algorithmic functionality and flexibility of SNNS can be accessed. Furthermore, the package contains a convenient high-level interface, so that the most common neural network topologies and learning algorithms integrate seamlessly into R.

### RSNNS/MLP Create and train a multi-layer perceptron
MLPs are fully connected feedforward networks, and probably the most common network architecture in use. Training is usually performed by error backpropagation or a related procedure.

### RSNNS/MLP Booking Options

<table class="wikitable table table-striped table-hover"><tr><td class="wikicell"  colspan="4"><span style="color:#06F; background-color:">Configuration options reference for MVA method: RSNNS/MLP</span></td></tr><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span></td></tr><tr><td class="wikicell" ><strong>Size</strong></td><td class="wikicell" > c(5)  </td><td class="wikicell" > - </td><td class="wikicell" >(R's vector type given in string) with the number of units in the hidden layer(s)   </td></tr><tr><td class="wikicell" ><strong>Maxit</strong></td><td class="wikicell" >  100 </td><td class="wikicell" > - </td><td class="wikicell" >maximum of iterations to learn </td></tr><tr><td class="wikicell" ><strong>InitFunc</strong></td><td class="wikicell" >Randomize_Weights</td><td class="wikicell" >Randomize_Weights<br> ART1_Weights<br>ART2_Weights<br> ARTMAP_Weights<br> CC_Weights<br> ClippHebb<br> CPN_Weights_v3.2<br> CPN_Weights_v3.3<br> CPN_Rand_Pat<br> DLVQ_Weights<br> Hebb<br> Hebb_Fixed_Act<br> JE_Weights<br>  Kohonen_Rand_Pat<br> Kohonen_Weights_v3.2<br> Kohonen_Const<br> PseudoInv<br> Random_Weights_Perc<br> RBF_Weights<br> RBF_Weights_Kohonen<br> RBF_Weights_Redo<br> RM_Random_Weights<br> ENZO_noinit</td><td class="wikicell" > the initialization function to use</td></tr><tr><td class="wikicell" ><strong>InitFuncParams</strong></td><td class="wikicell" >c(-0.3, 0.3)</td><td class="wikicell" > -</td><td class="wikicell" >(R's vector type given in string) the parameters for the initialization function</td></tr><tr><td class="wikicell" ><strong>LearnFunc</strong> </td><td class="wikicell" > Std_Backpropagation </td><td class="wikicell" >Std_Backpropagation <br>BackpropBatch<br> BackpropChunk<br> BackpropClassJogChunk<br>  BackpropMomentum<br> BackpropWeightDecay<br> TimeDelayBackprop<br> Quickprop<br> Rprop<br> RpropMAP<br> BPTT<br> CC<br> TACOMA<br>     BBPTT<br> QPTT<br> JE_BP<br> JE_BP_Momentum<br> JE_Quickprop<br> JE_Rprop<br> Monte-Carlo<br> SCG<br> Sim_Ann_SS<br> Sim_Ann_WTA<br> Sim_Ann_WWTA</td><td class="wikicell" >  the learning function to use</td></tr><tr><td class="wikicell" ><strong>LearnFuncParams</strong></td><td class="wikicell" >c(0.2, 0)</td><td class="wikicell" >-</td><td class="wikicell" >(R's vector type given in string) the parameters for the learning function  e.g. ‘Std_Backpropagation’, ‘BackpropBatch’ have two parameters, the learning rate and the maximum output difference. The learning rate is usually a value between 0.1 and 1. It specifies the gradient descent step width. The maximum difference defines, how much difference between output and target value is treated as zero error, and not backpropagated. This parameter is used to prevent overtraining. For a complete list of the parameters of all the learning functions, see the SNNS User Manual, pp. 67.</td></tr><tr><td class="wikicell" ><strong>UpdateFunc</strong> </td><td class="wikicell" > Topological_Order </td><td class="wikicell" > Topological_Order<br> ART1_Stable<br> ART1_Synchronous<br> ART2_Stable<br> ART2_Synchronous<br> ARTMAP_Stable<br> ARTMAP_Synchronous<br> Auto_Synchronous<br> BAM_Order<br> BPTT_Order<br> CC_Order<br>   CounterPropagation<br> Dynamic_LVQ<br> Hopfield_Fixed_Act<br> Hopfield_Synchronous<br> JE_Order<br> JE_Special<br> Kohonen_Order<br> Random_Order<br> Random_Permutation<br> Serial_Order<br> Synchonous_Order<br> TimeDelay_Order<br>ENZO_prop</td><td class="wikicell" >   the update function to use</td></tr><tr><td class="wikicell" ><strong>UpdateFuncParams</strong></td><td class="wikicell" >c(0)</td><td class="wikicell" >-</td><td class="wikicell" >the parameters for the update function</td></tr><tr><td class="wikicell" ><strong>HiddenActFunc</strong></td><td class="wikicell" >Act_Logistic</td><td class="wikicell" >Act_Logistic<br> Act_Elliott<br> Act_BSB<br> Act_TanH<br> Act_TanHPlusBias<br> Act_TanH_Xdiv2<br> Act_Perceptron<br> Act_Signum<br> Act_Signum0<br> Act_Softmax<br> Act_StepFunc<br> Act_HystStep<br> Act_BAM<br> Logistic_notInhibit<br> Act_MinOutPlusWeight<br> Act_Identity<br> Act_IdentityPlusBias<br> Act_LogisticTbl<br> Act_RBF_Gaussian<br> Act_RBF_MultiQuadratic<br> Act_RBF_ThinPlateSpline<br> Act_less_than_0<br> Act_at_most_0<br> Act_at_least_1<br> Act_at_least_2<br> Act_exactly_1<br> Act_Product<br> Act_ART1_NC<br> Act_ART2_Identity<br> Act_ART2_NormP<br> Act_ART2_NormV<br> Act_ART2_NormW<br> Act_ART2_NormIP<br> Act_ART2_Rec<br> Act_ART2_Rst<br> Act_ARTMAP_NCa<br> Act_ARTMAP_NCb<br> Act_ARTMAP_DRho<br> Act_LogSym<br> Act_TD_Logistic<br> Act_TD_Elliott<br> Act_Euclid<br> Act_Component<br> Act_RM<br> Act_TACOMA<br> Act_CC_Thresh<br> Act_Sinus<br> Act_Exponential </td><td class="wikicell" >  the activation function of all hidden units</td></tr><tr><td class="wikicell" ><strong>ShufflePatterns</strong></td><td class="wikicell" >kTRUE</td><td class="wikicell" >-</td><td class="wikicell" >should the patterns be shuffled?</td></tr><tr><td class="wikicell" ><strong>LinOut</strong></td><td class="wikicell" >kFALSE</td><td class="wikicell" >-</td><td class="wikicell" >sets the activation function of the output units to linear or logistic</td></tr><tr><td class="wikicell" ><strong>PruneFunc</strong></td><td class="wikicell" >NULL</td><td class="wikicell" >MagPruning<br>OptimalBrainDamage<br>OptimalBrainSurgeon<br>Skeletonization<br>Noncontributing_Units<br>None<br>Binary<br>Inverse<br>Clip<br>LinearScale<br>Norm<br>Threshold</td><td class="wikicell" >the pruning function to use</td></tr><tr><td class="wikicell" ><strong>PruneFuncParams</strong></td><td class="wikicell" >NULL</td><td class="wikicell" >-</td><td class="wikicell" >the parameters for the pruning function. </td></tr></table>


### Example Booking RSNNS/MLP Model
```c++
factory->BookMethod(loader, TMVA::Types::kRSNNS, "RMLP","!H:VarTransform=N:Size=c(5):Maxit=800:InitFunc=Randomize_Weights:LearnFunc=Std_Backpropagation:LearnFuncParams=c(0.2,0):!V" );
```

### RSNNS/MLP Plot
<img class="img-responsive" src="{{ site.baseurl }}/img/RSNNSMLPROC.png"/>

<br>

## Support Vector Machine (R package e1071)
Misc Functions of the Department of Statistics (e1071), TU Wien Functions for latent class analysis, short time Fourier transform, fuzzy clustering, support vector machines, shortest path computation, bagged clustering, naive Bayes classifier, ...

### RSVM (R Support Vector Machines)
svm is used to train a support vector machine. It can be used to carry out general regression and classification (of nu and epsilon-type), as well as density-estimation.

### e1071/RSVM Booking Options
<h3 class="showhide_heading" id="af48f11ba7188c4389cb995359b4c4b4b"><strong><a id="E1071RSVMBooking">e1071/RSVM Booking Options</a></strong></h3>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span></td></tr><tr><td class="wikicell" ><strong>Scale</strong></td><td class="wikicell" > kTRUE</td><td class="wikicell" >-</td><td class="wikicell" >A logical vector indicating the variables to be scaled. If ‘scale’ is of length 1, the value is recycled as many times as needed.  Per default, data are scaled internally (both ‘x’ and ‘y’ variables) to zero mean and unit variance. The center and scale values are returned and used for later predictions.</td></tr><tr><td class="wikicell" ><strong>Type</strong></td><td class="wikicell" >C-classification</td><td class="wikicell" >C-classification <br> nu-classification <br> one-classification <br> eps-regression <br> nu-regression</td><td class="wikicell" >‘svm’ can be used as a classification machine, as a regression machine, or for novelty detection.  Depending of whether ‘y’ is a factor or not, the default setting for ‘type’ is ‘C-classification’ or ‘eps-regression’, respectively, but may be overwritten by setting an explicit value.</td></tr><tr><td class="wikicell" ><strong>Kernel</strong></td><td class="wikicell" >radial</td><td class="wikicell" >radial <br> linear<br> polynomial <br> sigmoid</td><td class="wikicell" >the kernel used in training and predicting. You might consider changing some of the following parameters, depending on the kernel type.</td></tr><tr><td class="wikicell" ><strong>Degree</strong></td><td class="wikicell" >3</td><td class="wikicell" >-</td><td class="wikicell" >parameter needed for kernel of type ‘polynomial’</td></tr><tr><td class="wikicell" ><strong>Gamma</strong></td><td class="wikicell" >default: 1/(data dimension)</td><td class="wikicell" >-</td><td class="wikicell" > parameter needed for all kernels except ‘linear’</td></tr><tr><td class="wikicell" ><strong>Coef0</strong></td><td class="wikicell" >0</td><td class="wikicell" >-</td><td class="wikicell" >parameter needed for kernels of type ‘polynomial’ and ‘sigmoid’</td></tr><tr><td class="wikicell" ><strong>Cost</strong></td><td class="wikicell" >1</td><td class="wikicell" >-</td><td class="wikicell" >cost of constraints violation (default: 1)-it is the ‘C’-constant of the regularization term in the Lagrange formulation.</td></tr><tr><td class="wikicell" ><strong>Nu</strong></td><td class="wikicell" >0.5</td><td class="wikicell" >-</td><td class="wikicell" >parameter needed for ‘nu-classification’, ‘nu-regression’, and ‘one-classification’</td></tr><tr><td class="wikicell" ><strong>CacheSize</strong></td><td class="wikicell" >40</td><td class="wikicell" >-</td><td class="wikicell" >cache memory in MB (default 40)</td></tr><tr><td class="wikicell" ><strong>Tolerance</strong></td><td class="wikicell" >0.001</td><td class="wikicell" >-</td><td class="wikicell" >tolerance of termination criterion (default: 0.001)</td></tr><tr><td class="wikicell" ><strong>Epsilon</strong></td><td class="wikicell" >0.1</td><td class="wikicell" >-</td><td class="wikicell" >epsilon in the insensitive-loss function (default: 0.1)</td></tr><tr><td class="wikicell" ><strong>Shrinking</strong></td><td class="wikicell" >kTRUE</td><td class="wikicell" >-</td><td class="wikicell" >option whether to use the shrinking-heuristics</td></tr><tr><td class="wikicell" ><strong>Cross</strong></td><td class="wikicell" >0</td><td class="wikicell" >-</td><td class="wikicell" >if a integer value k&gt;0 is specified, a k-fold cross validation on the training data is performed to assess the quality of the model: the accuracy rate for classification and the Mean Squared Error for regression</td></tr><tr><td class="wikicell" ><strong>Fitted</strong></td><td class="wikicell" >kTRUE</td><td class="wikicell" >-</td><td class="wikicell" >logical indicating whether the fitted values should be computed and included in the model or not (default: ‘TRUE’)</td></tr><tr><td class="wikicell" ><strong>Probability</strong></td><td class="wikicell" >kFALSE</td><td class="wikicell" >-</td><td class="wikicell" >logical indicating whether the model should allow for probability predictions.</td></tr></table>
<br>
### Example Booking RSVM Model
```c++
factory->BookMethod(loader, TMVA::Types::kRSVM, "RSVM","!H:Kernel=linear:Type=C-classification:VarTransform=Norm:Probability=kTRUE:Tolerance=0.001:!V" );
```
<br>
### e1071/RSVM Plot
<img class="img-responsive" src="{{ site.baseurl }}/img/E1071RSVMROC.png"/>


### eXtreme Gradient Boost (R package xgboost)
-----------
An optimized general purpose gradient boosting library. The library is parallelized, and also provides an optimized distributed version.

It implements machine learning algorithms under the Gradient Boosting framework, including Generalized Linear Model (GLM) and Gradient Boosted Decision Trees (GBDT). XGBoost can also be distributed and scale to Terascale data

XGBoost is part of Distributed Machine Learning Common projects.

<h2 class="showhide_heading" id="a27eae821ea38ae7dad4f81306242bd87"><strong><a id="RXGBBooking">RXGB Booking Options</a></strong></h2>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell"  colspan="4"><span style="color:#06F; background-color:">Configuration options reference for MVA method: RXGB</span></td></tr><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span></td></tr><tr><td class="wikicell" ><strong>NRounds</strong></td><td class="wikicell" > 10  </td><td class="wikicell" > - </td><td class="wikicell" >an integer specifying the number of boosting iterations.</td></tr><tr><td class="wikicell" ><strong>Eta</strong></td><td class="wikicell" > 0.3  </td><td class="wikicell" > - </td><td class="wikicell" >Step size shrinkage used in update to prevents overfitting.<br /> After each boosting step, we can directly get the weights of new features. and eta actually shrinks the feature weights to make the boosting process more conservative.</td></tr><tr><td class="wikicell" ><strong>MaxDepth</strong></td><td class="wikicell" >6</td><td class="wikicell" >-</td><td class="wikicell" >Maximum depth of the tree</td></tr></table>


### Booking Options Example
```c++
factory->BookMethod(TMVA::Types::kRXGB,"RXGB","!V:NRounds=80:MaxDepth=2:Eta=1");
```
### RXGB Output
```
Evaluation results ranked by best signal efficiency and purity (area)
--------------------------------------------------------------------------------
MVA              Signal efficiency at bkg eff.(error):       | Sepa-    Signifi- 
Method:          @B=0.01    @B=0.10    @B=0.30    ROC-integ. | ration:  cance:   
--------------------------------------------------------------------------------
RXGB           : 0.264(08)  0.660(08)  0.866(06)    0.876    | 0.433    1.169
C50            : 0.087(05)  0.440(09)  0.861(06)    0.844    | 0.391    1.097
--------------------------------------------------------------------------------
```
<br>

-----------


