function [fRR_QI] = fRRseriesBadIndex(RRfs,qrsFs,qrsMs,fidLog)
% --------------------------------------------------------------------------------------------
% - Compute a QualityIndex for fetal RR series
%     based on fetal RR variability and fetal-mother QRS position coincidences
%----
%   Input parameters:
%      RRfs      fetal RR series
%      qrsFs     fetal QRS time positions
%      qrsMs     maternal QRS time positions
%      fidLog    handle for logfile

%   Ouput parameters:
%      fRR_QI    fetal RR series quality index

% --------------------------------------------------------------------------------------------

-------
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

if(nargin<4), fidLog=0; end

meRR = median(RRfs);
if(meRR<0.35), cfact=0.3*(0.35-meRR);
elseif(meRR>0.5), cfact=0.05*(meRR-0.5);
else, cfact=0;
end
dRRfs=diff(RRfs); ddRRfs=diff(dRRfs);
madRR = meansc(abs(dRRfs),0,2);
maddRR = meansc(abs(ddRRfs),0,2);
%rmssd = std(diff(RRfs));
%dRRfsz=dRRfs-mean(dRRfs); rmssd = sqrt(meansc(dRRfsz.*dRRfsz,0,8));
cmpRes=QRSdet_ann_cmp_fm(qrsFs,qrsMs, 0.1, 0);
%FMsim=cmpRes.nTP/(cmpRes.nFP+cmpRes.nFN);
cFMsim=0.05*cmpRes.nTP/(0.05*cmpRes.nTP+cmpRes.nFP+cmpRes.nFN);

fRR_QI=madRR+maddRR+cfact+cFMsim;

if(fidLog)
    fprintf(fidLog,'meRR=%7.4f,  madRR=%7.4f,  maddRR=%7.4f, cfact=%7.4f, cFMsim=%7.4f\n', ...
         meRR, madRR,maddRR,cfact,cFMsim);
    fprintf(fidLog,'fRR_QI=%7.4f\n', fRR_QI); 
end

end

