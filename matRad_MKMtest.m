
matRad_rc; %If this throws an error, run it from the parent directory first to set the paths

%% Patient Data Import
% load('Your_patientimg.mat');
% We attatched water phantom (3x3x3 cm3) for the test calculation
load('WP333.mat');

%% Change cst file for MKM
cst{1, 5}.alphaX  = 0.764
cst{2, 5}.alphaX  = 0.764
cst{1, 5}.betaX  = 0.0615
cst{2, 5}.betaX  = 0.0615

%% pln generation
pln.radiationMode = 'carbon';
pln.machine       = 'DG';
pln.propOpt.bioOptimization = 'MKM_RBExD';
pln.propOpt.alpha0_MKM    = 0.172;  % Inaniwa 2015
pln.propOpt.beta_MKM      = 0.0615; % Inaniwa 2010, 2015

% prescription dose
cst{2,6}{1,1}.parameters{1,1} = 57.6; % Gy
pln.numOfFractions        = 16; % fx
pln.propStf.gantryAngles  = 270;
pln.propStf.couchAngles   = 0;
pln.propStf.bixelWidth    = 3;
pln.propStf.numOfBeams    = numel(pln.propStf.gantryAngles);
pln.propStf.isoCenter     = ones(pln.propStf.numOfBeams,1) * matRad_getIsoCenter(cst,ct,0);
pln.propOpt.runDAO        = 0;
pln.propOpt.runSequencing = 0;

% dose calculation settingslea
pln.propDoseCalc.doseGrid.resolution.x = 3; % [mm]
pln.propDoseCalc.doseGrid.resolution.y = 3; % [mm]
pln.propDoseCalc.doseGrid.resolution.z = 3; % [mm]

%% Generate Beam Geometry STF
stf = matRad_generateStf(ct,cst,pln);

%% Dose calculation
dij = matRad_calcParticleDose(ct,stf,pln,cst);

% Inverse Optimization  for IMPT based on RBE-weighted dose
% The goal of the fluence optimization is to find a set of bixel/spot 
% weights which yield the best possible dose distribution according to the
% clinical objectives and constraints underlying the radiation treatment.

%% Fluence optimization
resultGUI = matRad_fluenceOptimization(dij,cst,pln);

%% Check s
matRadGUI
