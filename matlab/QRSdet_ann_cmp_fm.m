function cmpRes=QRSdet_ann_cmp_fm(qrsD,qrsA, maxaDiff, debug)
% -------------------------------------------------------------------------------------------------
%   Routine to compare QRS detection annotations
%
% --- Input parameters:
%   qrsD      estimated time position for QRS complex
%   qrsA      reference time position for QRS complex
%   maxaDiff  max absolute difference between qrsD and qrsA position
%   debug     debug flag
% --- Output parameters:
%   cmpRes.nTP            number of True Positives (TP) (matching annotations)
%   cmpRes.nFP            number of False Positives (FP)
%   cmpRes.nFN            number of False Negatives (FN)
%   cmpRes.meanAbsDiff    mean of absolute differences between TP annotations
% -------------------------------------------------------------------------------------------------
% (c) Maurizio Varanini, Lucia Billeci, Clinical Physiology Institute, CNR, Pisa, Italy
% For any comment or bug report, please send e-mail to: maurizio.varanini@ifc.cnr.it, lucia.billeci@ifc.cnr.it 
% -------------------------------------------------------------------------------------------------
% This program is free software; you can redistribute it and/or modify it under the terms
% of the GNU General Public License as published by the Free Software Foundation; either
% version 2 of the License, or (at your option) any later version.
%
% This program is distributed "as is" and "as available" in the hope that it will be useful,
% but WITHOUT ANY WARRANTY of any kind; without even the implied warranty of MERCHANTABILITY
% or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% --------------------------------------------------------------------------------------------

if(nargin<3), maxaDiff=0.075; end          % qrsD and qrsA are supposed to be in seconds
if(nargin<4), debug=0; end

nqrsA=length(qrsA);
nqrsD=length(qrsD);
qrsA_TP=zeros(1,nqrsA);
qrsA_diffTP=zeros(1,nqrsA);
nTP = 0;    % number of True Positive
for i = 1:nqrsA
    qrsAi=qrsA(i);
    iQ = find(abs(qrsD-qrsAi)<maxaDiff, 1, 'last');
    if(~isempty(iQ))
        nTP=nTP+1;
        qrsA_diffTP(nTP) = abs(qrsD(iQ)-qrsAi);
    end
end

nFP = nqrsD-nTP;  % number of False Positives
nFN = nqrsA-nTP;  % number of False Negatives
    
if(nTP)
    meanAbsDiff=sum(qrsA_diffTP)/nTP;
else
    meanAbsDiff=0;   % patch
end

if(debug)
    fprintf('Number of mother QRSs= %d\n', nqrsA);
    fprintf('Number of fetal  QRSs= %d\n', nqrsD);
    
    fprintf('Number of true positives= %d\n', nTP);
    fprintf('Number of false positives= %d\n', nFP);
    fprintf('Number of false negatives= %d\n', nFN);
    
    fprintf('Sum abs diff = %5.3g\n', meanAbsDiff);
end

cmpRes.nTP=nTP;
cmpRes.nFP=nFP;
cmpRes.nFN=nFN;
cmpRes.meanaDiff=meanAbsDiff;

end     %== function ================================================================
%
