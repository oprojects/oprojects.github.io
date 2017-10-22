---
title: CERN Studentship 2016
layout: content
toc: false
---

![CERN Studentship 2016]({{ site.baseurl }}/img/CERNLogo.gif)
![CERN Studentship 2016]({{ site.baseurl }}/img/ROOT.png)

# Summer Student Report
[https://cds.cern.ch/record/2211157](https://cds.cern.ch/record/2211157)

<table class="wikitable table table-striped table-hover"><tr><td class="wikicell"  colspan="2"><span style="color:#06F; background-color:"> TMVA Development Report </span>
<p>
</p>
<h2 class="showhide_heading" id="Classes_serialized_to_support_DataLoader_Serialization"> Classes  serialized to support DataLoader&nbsp;Serialization</h2>
<table class="wikitable table table-striped table-hover"><tr><td class="wikicell"  colspan="2"><span style="color:#06F; background-color:"> DataLoader Serialiation </span>

## Example code to use TMVA Factory without Global file and without model persistence.
```c++
//classification
int tmva( )
{
   TMVA::Tools::Instance();

   TFile *input = TFile::Open( "http://root.cern.ch/files/tmva_class_example.root" );
   
   std::cout << "--- TMVAClassification       : Using input file: " << input->GetName() << std::endl;
   
   TTree *signal     = (TTree*)input->Get("TreeS");
   TTree *background = (TTree*)input->Get("TreeB");
   
   TMVA::Factory *factory = new TMVA::Factory( "TMVAClassification",
   "!V:!ModelPersistence:!Silent:Color:DrawProgressBar:AnalysisType=Classification" );

   TMVA::DataLoader *dataloader=new TMVA::DataLoader("dataset");

   dataloader->AddVariable( "myvar1 := var1+var2", 'F' );
   dataloader->AddVariable( "myvar2 := var1-var2", "Expression 2", "", 'F' );
   dataloader->AddVariable( "var3",                "Variable 3", "units", 'F' );
   dataloader->AddVariable( "var4",                "Variable 4", "units", 'F' );

   dataloader->AddSpectator( "spec1 := var1*2",  "Spectator 1", "units", 'F' );
   dataloader->AddSpectator( "spec2 := var1*3",  "Spectator 2", "units", 'F' );

   Double_t signalWeight     = 1.0;
   Double_t backgroundWeight = 1.0;
   
   dataloader->AddSignalTree    ( signal,     signalWeight     );
   dataloader->AddBackgroundTree( background, backgroundWeight );
   
   dataloader->SetBackgroundWeightExpression( "weight" );

   TCut mycuts = ""; // for example: TCut mycuts = "abs(var1)<0.5 && abs(var2-0.5)<1";
   TCut mycutb = ""; // for example: TCut mycutb = "abs(var1)<0.5";

   dataloader->PrepareTrainingAndTestTree( mycuts, mycutb,            "nTrain_Signal=1000:nTrain_Background=1000:SplitMode=Random:NormMode=NumEvents:!V" );

   factory->BookMethod( dataloader, TMVA::Types::kBDT, "BDT",                           "!H:!V:NTrees=850:MinNodeSize=2.5%:MaxDepth=3:BoostType=AdaBoost:AdaBoostBeta=0.5:UseBaggedBoost:BaggedSampleFraction=0.5:SeparationType=GiniIndex:nCuts=20" );

   // Train MVAs using the set of training events
   factory->TrainAllMethods();

   // ---- Evaluate all MVAs using the set of test events
   factory->TestAllMethods();

   // ----- Evaluate and compare performance of all configured MVAs
   factory->EvaluateAllMethods();

   // --------------------------------------------------------------
   delete factory;
   delete dataloader;

   return 0;
}
```