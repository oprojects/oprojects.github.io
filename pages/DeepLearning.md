---
title: Data Science at LHC 2015
layout: content
toc: false
---

# Deep Leaning implementation.
## Short description:

The DNN neural network is a feedforward 
multilayer perceptron impementation. The DNN has a user-defined hidden layer architecture, where the number of input (output) 
nodes is determined by the input variables (output classes, i.e.,signal and one background, regression or multiclass).

# Performance optimisation:
## Short description:

The DNN neural network is a feedforward multilayer perceptron impementation. The DNN has a user-defined hidden layer architecture, where the number of input (output) nodes is determined by the input variables (output classes, i.e.,signal and one background, regression or multiclass).
Performance optimisation:


The DNN supports various options to improve performance in terms of training speed and 
reduction of overfitting: 

- different training settings can be stacked. Such that the initial training 
is done with a large learning rate and a large drop out fraction whilst 
in a later stage learning rate and drop out can be reduced. 

- drop out 
[recommended: 
initial training stage: 0.0 for the first layer, 0.5 for later layers. 
later training stage: 0.1 or 0.0 for all layers 
final training stage: 0.0] 
Drop out is a technique where a at each training cycle a fraction of arbitrary 
nodes is disabled. This reduces co-adaptation of weights and thus reduces overfitting. 

- L1 and L2 regularization are available 

- Minibatches 
[recommended 10 - 150] 
Arbitrary mini-batch sizes can be chosen. 

- Multithreading 
[recommended: True] 
Multithreading can be turned on. The minibatches are distributed to the available 
cores. The algorithm is lock-free (\"Hogwild!\"-style) for each cycle. 

### Options:

**example:** 
```c++ 
\"Layout\":   \"TANH|(N+30)*2,TANH|(N+30),LINEAR\" 
```
**meaning:** 
. two hidden layers (separated by \",\") 
. the activation function is TANH (other options: RELU, SOFTSIGN, LINEAR) 
. the activation function for the output layer is LINEAR 
. the first hidden layer has (N+30)*2 nodes where N is the number of input neurons 
. the second hidden layer has N+30 nodes, where N is the number of input neurons 
. the number of nodes in the output layer is determined by the number of output nodes 
and can therefore not be chosen freely. 

\"ErrorStrategy\": 
- SUMOFSQUARES 
The error of the neural net is determined by a sum-of-squares error function 
For regression, this is the only possible choice. 
- CROSSENTROPY 
The error of the neural net is determined by a cross entropy function. The 
output values are automatically (internally) transformed into probabilities 
using a sigmoid function. 
For signal/background classification this is the default choice. 
For multiclass using cross entropy more than one or no output classes 
can be equally true or false (e.g. Event 0: A and B are true, Event 1: 
A and C is true, Event 2: C is true, ...) 
- MUTUALEXCLUSIVE 
In multiclass settings, exactly one of the output classes can be true (e.g. either A or B or C) 

\"WeightInitialization\" 
- XAVIER 
[recommended] 
\"Xavier Glorot & Yoshua Bengio\"-style of initializing the weights. The weights are chosen randomly 
such that the variance of the values of the nodes is preserved for each layer. 
- XAVIERUNIFORM 
The same as XAVIER, but with uniformly distributed weights instead of gaussian weights 
- LAYERSIZE 
Random values scaled by the layer size 

**example:**
```c++
\"TrainingStrategy\" \"LearningRate=1e-1,Momentum=0.3,Repetitions=3,ConvergenceSteps=50,BatchSize=30,TestRepetitions=7,WeightDecay=0.0,Renormalize=L2,DropConfig=0.0,DropRepetitions=5|LearningRate=1e-4,Momentum=0.3,Repetitions=3,ConvergenceSteps=50,BatchSize=20,TestRepetitions=7,WeightDecay=0.001,Renormalize=L2,DropFraction=0.0,DropRepetitions=5\" 
```
- explanation: two stacked training settings separated by \"|\" 
. first training setting: 
```c++
\"LearningRate=1e-1,Momentum=0.3,Repetitions=3,ConvergenceSteps=50,BatchSize=30,TestRepetitions=7,WeightDecay=0.0,Renormalize=L2,DropConfig=0.0,DropRepetitions=5\" 
```
. second training setting :
```c++
\"LearningRate=1e-4,Momentum=0.3,Repetitions=3,ConvergenceSteps=50,BatchSize=20,TestRepetitions=7,WeightDecay=0.001,Renormalize=L2,DropFractions=0.0,DropRepetitions=5\" 
```

. LearningRate : 
- recommended for classification: 0.1 initially, 1e-4 later 
- recommended for regression: 1e-4 and less 

. Momentum : 
preserve a fraction of the momentum for the next training batch [fraction = 0.0 - 1.0] 

. Repetitions : 
train \"Repetitions\" repetitions with the same minibatch before switching to the next one 
-
. ConvergenceSteps : 
Assume that convergence is reached after \"ConvergenceSteps\" cycles where no improvement 
of the error on the test samples has been found. (Mind that only at each \"TestRepetitions\" 
cycle the test sampes are evaluated and thus the convergence is checked) 

. BatchSize 
Size of the mini-batches. 

. TestRepetitions 
Perform testing the neural net on the test samples each \"TestRepetitions\" cycle 

. WeightDecay 
If \"Renormalize\" is set to L1 or L2, \"WeightDecay\" provides the renormalization factor 

. Renormalize 
NONE, L1 (|w|) or L2 (w^2) 

. DropConfig 
Drop a fraction of arbitrary nodes of each of the layers according to the values given 
in the DropConfig. 
[example: DropConfig=0.0+0.5+0.3 
meaning: drop no nodes in layer 0 (input layer), half of the nodes in layer 1 and 30% of the nodes 
in layer 2 
recommended: leave all the nodes turned on for the input layer (layer 0) 
turn off half of the nodes in later layers for the initial training; leave all nodes 
turned on (0.0) in later training stages] 

. DropRepetitions 
Each \"DropRepetitions\" cycle the configuration of which nodes are dropped is changed 
[recommended : 1] 

. Multithreading 
turn on multithreading [recommended: True] 


### Download the git repository from
```sh￼
git clone https://github.com/root-mirror/root
```
### Download de higgs dataset from
￼
```sh
http://files.oproject.org/root/tmva/datasets/higgs/higgs-dataset.root
```

For information about the dataset see http://files.oproject.org/root/tmva/datasets/higgs/README

### Example Booking DNN with multiple training strategies

```c++
factory->BookMethod( loader, TMVA::Types::kDNN, "DNN",
   "!H:!V" );
```
after compile ROOT run the macro
**NOTE:** Be careful with this example beause require a huge amount of RAM, use less events if you just want to tests the algorithm.

```c++
#include "TMVA/Factory.h"
#include "TMVA/Tools.h"
#include "TMVA/DataLoader.h"
#include "TMVA/TMVAGui.h"

void deepnn( )
{
    TMVA::Tools::Instance();

    TString fname="higgs-dataset.root";
    if (gSystem->AccessPathName( fname ))  // file does not exist in local directory
        gSystem->Exec("curl -O http://files.oproject.org/root/tmva/datasets/higgs/higgs-dataset.root");

    TFile *input = TFile::Open( fname );
    TMVA::DataLoader *loader=new TMVA::DataLoader("higgs-dataset");
    std::cout << "--- TMVAClassification       : Using input file: " << input->GetName() << std::endl;

    // --- Register the training and test trees

    TTree *signal     = (TTree*)input->Get("TreeS");
    TTree *background = (TTree*)input->Get("TreeB");

    // Create a ROOT output file where TMVA will store ntuples, histograms, etc.
    TString outfileName( "TMVA.root" );
    TFile* outputFile = TFile::Open( outfileName, "RECREATE" );

//     TMVA::Factory *factory = new TMVA::Factory( "TMVAClassification", outputFile,
//             "!V:!Silent:Color:DrawProgressBar:Transformations=I;D;P;G,D:AnalysisType=Classification" );
    TMVA::Factory *factory = new TMVA::Factory( "TMVAClassification", outputFile,
            "!V:!Silent:Color:DrawProgressBar:AnalysisType=Classification" );

    loader->AddVariable("lepton_pT",'F');
    loader->AddVariable("lepton_eta",'F');
    loader->AddVariable("lepton_phi",'F');
    loader->AddVariable("missing_energy_magnitude",'F');
    loader->AddVariable("missing_energy_phi",'F');
    loader->AddVariable("jet_1_pt",'F');
    loader->AddVariable("jet_1_eta",'F');
    loader->AddVariable("jet_1_phi",'F');
    loader->AddVariable("jet_1_b_tag",'F');
    loader->AddVariable("jet_2_pt",'F');
    loader->AddVariable("jet_2_eta",'F');
    loader->AddVariable("jet_2_phi",'F');
    loader->AddVariable("jet_2_b_tag",'F');
    loader->AddVariable("jet_3_pt",'F');
    loader->AddVariable("jet_3_eta",'F');
    loader->AddVariable("jet_3_phi",'F');
    loader->AddVariable("jet_3_b_tag",'F');
    loader->AddVariable("jet_4_pt",'F');
    loader->AddVariable("jet_4_eta",'F');
    loader->AddVariable("jet_4_phi",'F');
    loader->AddVariable("jet_4_b_tag",'F');
    loader->AddVariable("m_jj",'F');
    loader->AddVariable("m_jjj",'F');
    loader->AddVariable("m_lv",'F');
    loader->AddVariable("m_jlv",'F');
    loader->AddVariable("m_bb",'F');
    loader->AddVariable("m_wbb",'F');
    loader->AddVariable("m_wwbb",'F');



    // global event weights per tree (see below for setting event-wise weights)
    Double_t signalWeight     = 1.0;
    Double_t backgroundWeight = 1.0;

    // You can add an arbitrary number of signal or background trees
    loader->AddSignalTree    ( signal,     signalWeight     );
    loader->AddBackgroundTree( background, backgroundWeight );

//     loader->SetBackgroundWeightExpression( "weight" );

    // Apply additional cuts on the signal and background samples (can be different)
    TCut mycuts = ""; // for example: TCut mycuts = "abs(var1)<0.5 && abs(var2-0.5)<1";
    TCut mycutb = ""; // for example: TCut mycutb = "abs(var1)<0.5";
    //NOTE: Change it!
    //-train events
    //  signal = 4829123
    //  bgk    = 4170877
    //- test events
    //  signal = 1000000
    //  bgk    = 1000000

    loader->PrepareTrainingAndTestTree( mycuts, mycutb,
                                         "nTrain_Signal=1829123:nTrain_Background=1170877:nTest_Signal=4000000:nTest_Background=4000000:SplitMode=Random:NormMode=NumEvents:!V" );


    // improved neural network implementation
//       TString layoutString ("Layout=TANH|(N+100)*2,LINEAR");
//       TString layoutString ("Layout=SOFTSIGN|100,SOFTSIGN|50,SOFTSIGN|20,LINEAR");
//       TString layoutString ("Layout=RELU|300,RELU|100,RELU|30,RELU|10,LINEAR");
//       TString layoutString ("Layout=SOFTSIGN|50,SOFTSIGN|30,SOFTSIGN|20,SOFTSIGN|10,LINEAR");
//       TString layoutString ("Layout=TANH|50,TANH|30,TANH|20,TANH|10,LINEAR");
//       TString layoutString ("Layout=SOFTSIGN|50,SOFTSIGN|20,LINEAR");
    TString layoutString ("Layout=TANH|100,TANH|50,TANH|10,LINEAR");

    TString training0 ("LearningRate=1e-1,Momentum=0.0,Repetitions=1,ConvergenceSteps=300,BatchSize=20,TestRepetitions=15,WeightDecay=0.001,Regularization=NONE,DropConfig=0.0+0.5+0.5+0.5,DropRepetitions=1,Multithreading=True");
    TString training1 ("LearningRate=1e-2,Momentum=0.5,Repetitions=1,ConvergenceSteps=300,BatchSize=30,TestRepetitions=7,WeightDecay=0.001,Regularization=L2,Multithreading=True,DropConfig=0.0+0.1+0.1+0.1,DropRepetitions=1");
    TString training2 ("LearningRate=1e-2,Momentum=0.3,Repetitions=1,ConvergenceSteps=300,BatchSize=40,TestRepetitions=7,WeightDecay=0.0001,Regularization=L2,Multithreading=True");
    TString training3 ("LearningRate=1e-3,Momentum=0.1,Repetitions=1,ConvergenceSteps=200,BatchSize=70,TestRepetitions=7,WeightDecay=0.0001,Regularization=NONE,Multithreading=True");

    TString trainingStrategyString ("TrainingStrategy=");
    trainingStrategyString += training0 + "|" + training1 + "|" + training2 + "|" + training3;


//       TString nnOptions ("!H:V:VarTransform=Normalize:ErrorStrategy=CROSSENTROPY");
    TString nnOptions ("!H:V:ErrorStrategy=CROSSENTROPY:VarTransform=G:WeightInitialization=XAVIERUNIFORM");
//       TString nnOptions ("!H:V:VarTransform=Normalize:ErrorStrategy=CHECKGRADIENTS");
    nnOptions.Append (":");
    nnOptions.Append (layoutString);
    nnOptions.Append (":");
    nnOptions.Append (trainingStrategyString);

    factory->BookMethod(loader, TMVA::Types::kDNN, "DNN", nnOptions ); // NN


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
    // Launch the GUI for the root macros
    if (!gROOT->IsBatch()) TMVA::TMVAGui( outfileName );
}
```
