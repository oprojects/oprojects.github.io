---
title: Python TMVA
layout: content
toc: true
---
# Python TMVA
{:.no_toc}
![Python  TMVA]({{ site.baseurl }}/img/PYMVA.png){:class="img-responsive"}

* Table of Contents 
{:toc}
<br>


## Description 
-----------
PyMVA is a set of plugins for TMVA package based on Python(SciKit learn) that consist in a set of classes that engage TMVA and allows new methods of classification and regression using by example SciKit's modules.
![PyMVA Design]({{ site.baseurl }}/img/PyMVADesign.png){:class="img-responsive"}
![PyMVA DataFlow]({{ site.baseurl }}/img/PyMVA Data Flow.png){:class="img-responsive"}


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
</td></tr><tr><td class="wikicell" ><strong>NEstimators</strong></td><td class="wikicell" > 10</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=10) .   The number of trees in the forest.
</td></tr><tr><td class="wikicell" ><strong>Criterion</strong></td><td class="wikicell" > 'gini'</td><td class="wikicell" >-</td><td class="wikicell" >string, optional (default="gini").  The function to measure the quality of a split. Supported criteria are "gini" for the Gini impurity and "entropy" for the information gain.
</td></tr><tr><td class="wikicell" ><strong>MaxDepth</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >integer or None, optional (default=None).The maximum depth of the tree. If None, then nodes are expanded until all leaves are pure or until all leaves contain less than min_samples_split samples. Ignored if ``max_leaf_nodes`` is not None.
</td></tr><tr><td class="wikicell" ><strong>MinSamplesSplit</strong></td><td class="wikicell" >2</td><td class="wikicell" >-</td><td class="wikicell" >The minimum number of samples required to split an internal node.  
</td></tr><tr><td class="wikicell" ><strong>MinSamplesLeaf</strong></td><td class="wikicell" >1</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=1). The minimum number of samples in newly created leaves.  A split is discarded if after the split, one of the leaves would contain less then ``min_samples_leaf`` samples.
</td></tr><tr><td class="wikicell" ><strong>MinWeightFractionLeaf</strong></td><td class="wikicell" >0</td><td class="wikicell" >-</td><td class="wikicell" > float, optional (default=0.). The minimum weighted fraction of the input samples required to be at a leaf node.
</td></tr><tr><td class="wikicell" ><strong>MaxFeatures</strong></td><td class="wikicell" >'auto'</td><td class="wikicell" >-</td><td class="wikicell" >int, float, string or None, optional (default="auto"). <br />The number of features to consider when looking for the best split:   <br /> - If int, then consider `max_features` features at each split.  <br /> - If float, then `max_features` is a percentage and `int(max_features * n_features)` features are considered at each split. <br /> - If "auto", then `max_features=sqrt(n_features)`. <br /> - If "sqrt", then `max_features=sqrt(n_features)`.  <br /> - If "log2", then `max_features=log2(n_features)`. <br /> - If None, then `max_features=n_features`. <br />  <strong>Note</strong>: the search for a split does not stop until at least one valid partition of the node samples is found, even if it requires to effectively inspect more than ``max_features`` features.
</td></tr><tr><td class="wikicell" ><strong>MaxLeafNodes</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" > int or None, optional (default=None)<br />Grow trees with ``max_leaf_nodes`` in best-first fashion. <br /> Best nodes are defined as relative reduction in impurity.<br /> If None then unlimited number of leaf nodes.<br />If not None then ``max_depth`` will be ignored.
</td></tr><tr><td class="wikicell" ><strong>Bootstrap</strong></td><td class="wikicell" >kTRUE</td><td class="wikicell" >-</td><td class="wikicell" >boolean, optional (default=True). Whether bootstrap samples are used when building trees.
</td></tr><tr><td class="wikicell" ><strong>OoBScore</strong></td><td class="wikicell" >kFALSE</td><td class="wikicell" >-</td><td class="wikicell" >bool. Whether to use out-of-bag samples to estimate the generalization error.
</td></tr><tr><td class="wikicell" ><strong>NJobs</strong></td><td class="wikicell" >1</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=1). The number of jobs to run in parallel for both `fit` and `predict`. If -1, then the number of jobs is set to the number of cores.
</td></tr><tr><td class="wikicell" ><strong>RandomState</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >int, RandomState instance or None, optional (default=None).<br />If int, random_state is the seed used by the random number generator;<br />If RandomState instance, random_state is the random number generator;If None, the random number generator is the RandomState instance usedby `np.random`.
</td></tr><tr><td class="wikicell" ><strong>Verbose</strong></td><td class="wikicell" >0</td><td class="wikicell" >-</td><td class="wikicell" >int, optional (default=0). Controls the verbosity of the tree building process.
</td></tr><tr><td class="wikicell" ><strong>WarmStart</strong></td><td class="wikicell" >kFALSE</td><td class="wikicell" >-</td><td class="wikicell" >bool, optional (default=False). When set to ``True``, reuse the solution of the previous call to fit and add more estimators to the ensemble, otherwise, just fit a whole new forest.
</td></tr><tr><td class="wikicell" ><strong>ClassWeight</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >dict, list of dicts, "auto", "subsample" or None, optional.<br />Weights associated with classes in the form ``{class_label: weight}``.<br />If not given, all classes are supposed to have weight one. For multi-output problems, a list of dicts can be provided in the same order as the columns of y.<br /> The "auto" mode uses the values of y to automatically adjust weights inversely proportional to class frequencies in the input data.<br /> The "subsample" mode is the same as "auto" except that weights are computed based on the bootstrap sample for every tree grown. <br />     For multi-output, the weights of each column of y will be multiplied.<br />    Note that these weights wdict, list of dicts, "auto", "subsample" or None, optional<br />    Weights associated with classes in the form ``{class_label: weight}``.<br />    If not given, all classes are supposed to have weight one. For multi-output problems, a list of dicts can be provided in the same order as the columns of y.<br />    The "auto" mode uses the values of y to automatically adjust  weights inversely proportional to class frequencies in the input data.<br />    The "subsample" mode is the same as "auto" except that weights are  computed based on the bootstrap sample for every tree grown.<br />    For multi-output, the weights of each column of y will be multiplied.<br />    Note that these weights will be multiplied with sample_weight (passed  through the fit method) if sample_weight is specified.<br /> ill be multiplied with sample_weight (passed through the fit method) if sample_weight is specified.
</td></tr></table>

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
</td></tr><tr><td class="wikicell" ><strong>Loss</strong></td><td class="wikicell" >'deviance'</td><td class="wikicell" >-</td><td class="wikicell" >{'deviance', 'exponential'}, optional (default='deviance').    loss function to be optimized. 'deviance' refers to   deviance (= logistic regression) for classification    with probabilistic outputs.<br /> For loss 'exponential' gradient  boosting recovers the AdaBoost algorithm.
</td></tr><tr><td class="wikicell" ><strong>LearningRate</strong></td><td class="wikicell" >0.1</td><td class="wikicell" >-</td><td class="wikicell" >float, optional (default=0.1)<br />    learning rate shrinks the contribution of each tree by `learning_rate`.<br />    There is a trade-off between learning_rate and n_estimators.
</td></tr><tr><td class="wikicell" ><strong>NEstimators</strong></td><td class="wikicell" > 10</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=10) .   The number of trees in the forest.
</td></tr><tr><td class="wikicell" ><strong>Subsample</strong></td><td class="wikicell" >1.0</td><td class="wikicell" >-</td><td class="wikicell" >float, optional (default=1.0).<br />    The fraction of samples to be used for fitting the individual base    learners. <br />If smaller than 1.0 this results in Stochastic Gradient  Boosting. `subsample` interacts with the parameter `n_estimators`.    Choosing `subsample &lt; 1.0` leads to a reduction of variance   and an increase in bias.
</td></tr><tr><td class="wikicell" ><strong>MinSamplesSplit</strong></td><td class="wikicell" >2</td><td class="wikicell" >-</td><td class="wikicell" >The minimum number of samples required to split an internal node.  
</td></tr><tr><td class="wikicell" ><strong>MinSamplesLeaf</strong></td><td class="wikicell" >1</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=1). The minimum number of samples in newly created leaves.  A split is discarded if after the split, one of the leaves would contain less then ``min_samples_leaf`` samples.
</td></tr><tr><td class="wikicell" ><strong>MinWeightFractionLeaf</strong></td><td class="wikicell" >0</td><td class="wikicell" >-</td><td class="wikicell" > float, optional (default=0.). The minimum weighted fraction of the input samples required to be at a leaf node.
</td></tr><tr><td class="wikicell" ><strong>MaxDepth</strong></td><td class="wikicell" >1</td><td class="wikicell" >-</td><td class="wikicell" >integer , optional (default=3). maximum depth of the individual regression estimators. <br /> The maximum   depth limits the number of nodes in the tree.<br /> Tune this parameter    for best performance; the best value depends on the interaction    of the input variables.<br />    Ignored if ``max_leaf_nodes`` is not None.
</td></tr><tr><td class="wikicell" ><strong>Init</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >BaseEstimator, None, optional (default=None)<br />    An estimator object that is used to compute the initial    predictions. ``init`` has to provide ``fit`` and ``predict``.<br />    If None it uses ``loss.init_estimator``.
</td></tr><tr><td class="wikicell" ><strong>RandomState</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >int, RandomState instance or None, optional (default=None).<br />If int, random_state is the seed used by the random number generator;<br />If RandomState instance, random_state is the random number generator;If None, the random number generator is the RandomState instance usedby `np.random`.
</td></tr><tr><td class="wikicell" ><strong>MaxFeatures</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >int, float, string or None, optional (default=None).<br />    The number of features to consider when looking for the best split:<br />      - If int, then consider `max_features` features at each split.<br />      - If float, then `max_features` is a percentage and        `int(max_features * n_features)` features are considered at each split.<br />      - If "auto", then `max_features=sqrt(n_features)`.<br />      - If "sqrt", then `max_features=sqrt(n_features)`.<br />      - If "log2", then `max_features=log2(n_features)`.<br />      - If None, then `max_features=n_features`.<br /> Choosing `max_features &lt; n_features` leads to a reduction of variance    and an increase in bias.<br /> <strong>Note</strong>: the search for a split does not stop until at least one    valid partition of the node samples is found, even if it requires to    effectively inspect more than ``max_features`` features.  
</td></tr><tr><td class="wikicell" ><strong>MaxLeafNodes</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >int or None, optional (default=None).<br />    Grow trees with ``max_leaf_nodes`` in best-first fashion.<br />    Best nodes are defined as relative reduction in impurity.<br />    If None then unlimited number of leaf nodes.<br />    If not None then ``max_depth`` will be ignored.
</td></tr><tr><td class="wikicell" ><strong>WarmStart</strong></td><td class="wikicell" >kFALSE</td><td class="wikicell" >-</td><td class="wikicell" >bool, default: False.     When set to ``True``, reuse the solution of the previous call to fit    and add more estimators to the ensemble, otherwise, just erase the    previous solution.
</td></tr></table>


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
</td></tr><tr><td class="wikicell" ><strong>BaseEstimator</strong></td><td class="wikicell" >None </td><td class="wikicell" >-</td><td class="wikicell" >object, optional (default=DecisionTreeClassifier).<br />    The base estimator from which the boosted ensemble is built.<br />    Support for sample weighting is required, as well as proper `classes_`  and `n_classes_` attributes.
</td></tr><tr><td class="wikicell" ><strong>NEstimators</strong></td><td class="wikicell" > 50</td><td class="wikicell" >-</td><td class="wikicell" >integer, optional (default=50)..<br />    The maximum number of estimators at which boosting is terminated..<br />    In case of perfect fit, the learning procedure is stopped early.
</td></tr><tr><td class="wikicell" ><strong>LearningRate</strong></td><td class="wikicell" >1.0</td><td class="wikicell" >-</td><td class="wikicell" >loat, optional (default=1.).<br />    Learning rate shrinks the contribution of each classifier by    ``learning_rate``. There is a trade-off between ``learning_rate`` and    ``n_estimators``.
</td></tr><tr><td class="wikicell" ><strong>Algorithm</strong></td><td class="wikicell" >'SAMME.R'</td><td class="wikicell" >-</td><td class="wikicell" >{'SAMME', 'SAMME.R'}, optional (default='SAMME.R').<br />    If 'SAMME.R' then use the SAMME.R real boosting algorithm.<br />    ``base_estimator`` must support calculation of class probabilities.<br />    If 'SAMME' then use the SAMME discrete boosting algorithm.<br />    The SAMME.R algorithm typically converges faster than SAMME,    achieving a lower test error with fewer boosting iterations.
</td></tr><tr><td class="wikicell" ><strong>RandomState</strong></td><td class="wikicell" >None</td><td class="wikicell" >-</td><td class="wikicell" >int, RandomState instance or None, optional (default=None).<br />    If int, random_state is the seed used by the random number generator;<br />    If RandomState instance, random_state is the random number generator;<br />    If None, the random number generator is the RandomState instance used    by `np.random`.
</td></tr></table>


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
