---
title: Python TMVA
layout: content
toc: true
---
# Python TMVA
{:.no_toc}
![Python  TMVA]({{ site.baseurl }}/img/PYMVA.png)

* Table of Contents 
{:toc}
<br>


## Description 
-----------
PyMVA is a set of plugins for TMVA package based on Python(SciKit learn) that consist in a set of classes that engage TMVA and allows new methods of classification and regression using by example SciKit's modules.
![PyMVA Design]({{ site.baseurl }}/img/PyMVADesign.png)
![PyMVA DataFlow]({{ site.baseurl }}/img/PyMVA Data Flow.png)


## Installation 
-----------
You can download the code from

```sh
git clone https://github.com/root-mirror/root.git
```
Install python libraries with headers and install the next package like a super user.
You need to be sure that ROOT was compiled with python support in the same version odf that packages.

```sh
pip install scikit-learn
pip install numpy
```

## PyRandomForest
-----------
This TMVA method was implemented using RandomForest Classifier 
[Scikit Learn Random Forest](http://scikit-learn.org/stable/modules/ensemble.html#forests-of-randomized-trees)
<h3 class="showhide_heading" id="a9bbd454067dfefac48cc8bf5b15b00e2"><strong><a id="PyRFBooking">PyRandomForest Booking Options</a></strong></h3>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span>

### PyRandomForest Booking Example
```c++
factory->BookMethod(dataloader,TMVA::Types::kPyRandomForest, "PyRandomForest","!V:NEstimators=200:Criterion=gini:MaxFeatures=auto:MaxDepth=6:MinSamplesLeaf=3:MinWeightFractionLeaf=0:Bootstrap=kTRUE" );
```

## PyGTB (Gradient Trees Boosted)
-----------
This TMVA method was implemented using Gradient Trees Boosted Classifier 
[Scikit Learn Gradient Trees Boosted](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.GradientBoostingClassifier.html)

<h1 class="showhide_heading" id="ad473fe0b588fc733c009047d07083820"><strong><a id="PyGTB">PyGTB (Gradient Trees Boosted)</a></strong></h1>
<p>This TMVA method was implemented using Gradient Trees Boosted Classifier
<br /><a class="wiki external" target="_blank" href="http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.GradientBoostingClassifier.html" rel="external nofollow">Scikit Learn Gradient Trees Boosted </a><span class="icon icon-link-external fa fa-external-link fa-fw "   ></span>
</p>

<h3 class="showhide_heading" id="a265f93662a516305760d52b29c9d00e9"><strong><a id="PyGTBBooking">PyGTB Booking Options</a></strong></h3>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span>


### PyGTB Booking Example
```c++
factory->BookMethod(dataloader,TMVA::Types::kPyGTB, "PyGTB","!V:NEstimators=150:Loss=deviance:LearningRate=0.1:Subsample=1:MaxDepth=3:MaxFeatures='auto'" );
```
### PyAdaBoost
-----------
This TMVA method was implemented using AdaBoost Classifier 
[Scikit Learn Adaptative Boost](http://scikit-learn.org/stable/modules/ensemble.html#adaboost)

<h3 class="showhide_heading" id="a991baa91b2526bbe41ad8a85910a57b5"><strong><a id="PyAdaBoostBooking">PyAdaBoost Booking Options</a></strong></h3>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell" ><span style="color:#06F; background-color:">Option</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Default Value</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Predefined values</span></td><td class="wikicell" ><span style="color:#06F; background-color:">Description</span>


## PyMVA Example
```c++
#include "TMVA/Factory.h"
#include "TMVA/Tools.h"
#include "TMVA/DataLoader.h"
#include "TMVA/MethodPyRandomForest.h"
#include "TMVA/MethodPyGTB.h"
#include "TMVA/MethodPyAdaBoost.h"

void Classification()
{
    TMVA::Tools::Instance();
    
    TString outfileName( "TMVA.root" );
    TFile* outputFile = TFile::Open( outfileName, "RECREATE" );
    
    TMVA::Factory *factory = new TMVA::Factory( "TMVAClassification", outputFile,
                                                "!V:!Silent:Color:DrawProgressBar:Transformations=I;D;P;G,D:AnalysisType=Classification" );
    
    TMVA::DataLoader dataloader("dl");
    dataloader.AddVariable( "myvar1 := var1+var2", 'F' );
    dataloader.AddVariable( "myvar2 := var1-var2", "Expression 2", "", 'F' );
    dataloader.AddVariable( "var3",                "Variable 3", "units", 'F' );
    dataloader.AddVariable( "var4",                "Variable 4", "units", 'F' );
    
    
    dataloader.AddSpectator( "spec1 := var1*2",  "Spectator 1", "units", 'F' );
    dataloader.AddSpectator( "spec2 := var1*3",  "Spectator 2", "units", 'F' );
    
    
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
    dataloader.AddSignalTree    ( tsignal,     signalWeight     );
    dataloader.AddBackgroundTree( tbackground, backgroundWeight );
    
    
    // Set individual event weights (the variables must exist in the original TTree)
    dataloader.SetBackgroundWeightExpression( "weight" );
    
    
    // Apply additional cuts on the signal and background samples (can be different)
    TCut mycuts = ""; // for example: TCut mycuts = "abs(var1)<0.5 && abs(var2-0.5)<1";
    TCut mycutb = ""; // for example: TCut mycutb = "abs(var1)<0.5";
    
    // Tell the factory how to use the training and testing events
    dataloader.PrepareTrainingAndTestTree( mycuts, mycutb,
                                         "nTrain_Signal=0:nTrain_Background=0:nTest_Signal=0:nTest_Background=0:SplitMode=Random:NormMode=NumEvents:!V" );
    
    
    ///////////////////
    //Booking         //
    ///////////////////
    //     PyMVA methods
    factory->BookMethod(&dataloader, TMVA::Types::kPyRandomForest, "PyRandomForest",
                        "!V:NEstimators=100:Criterion=gini:MaxFeatures=auto:MaxDepth=6:MinSamplesLeaf=1:MinWeightFractionLeaf=0:Bootstrap=kTRUE" );
    
    factory->BookMethod(&dataloader, TMVA::Types::kPyAdaBoost, "PyAdaBoost","!V:NEstimators=1000" );
    
    factory->BookMethod(&dataloader, TMVA::Types::kPyGTB, "PyGTB","!V:NEstimators=150" );
    
    
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
    
}
```

### PyMVA Output
```sh
Evaluation results ranked by best signal efficiency and purity (area)
 --------------------------------------------------------------------------------
 MVA              Signal efficiency at bkg eff.(error):       | Sepa-    Signifi- 
 Method:          @B=0.01    @B=0.10    @B=0.30    ROC-integ. | ration:  cance:   
 --------------------------------------------------------------------------------
 PyGTB              : 0.343(08)  0.751(07)  0.924(04)    0.914    | 0.539    1.514
 PyAdaBoost        : 0.275(08)  0.730(08)  0.914(05)    0.908    | 0.507    1.357
 PyRandomForest : 0.233(07)  0.698(08)  0.903(05)    0.898    | 0.497    1.381
 --------------------------------------------------------------------------------
```