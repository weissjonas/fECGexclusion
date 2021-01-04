function x = meansc(v,perci,percf)
% --------------------------------------------------------------------------------------------
% meansc.m: Compute the mean value of a vector excluding the distribution tails.
%   x= meansc(v,perci,percf)
%           "perci" = % of min values;  "percf" = % of max values to be excluded
%
%   Version 1.00, Date: 08/04/2000
% % --------------------------------------------------------------------------------------------

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

if(nargin<2), perci=5; end
if(nargin<3), percf=perci; end
if(perci==50  && percf==50), x=median(v); return; end
if(perci+percf>=100), x=[]; return; end
if(length(v)==1), x=v; return; end
vo=sort(v);
ii = 1+floor(length(v)*perci/100);
fi = length(v)-ceil(length(v)*percf/100);
x=mean(vo(ii:fi));
