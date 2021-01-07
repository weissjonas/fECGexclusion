'''
This Programm is based on the Matlab implementation by:
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
'''

import numpy as np

def fRRseriesBadIndex(RRfs,qrsFs,qrsMs,fidLog, f=1000):
    pass
    #return [fRR_QI]



def meansc(x,lower_percentil=0.05,upper_percentil=0.95):
    '''
    Computes the mean value of a vector excluding the distribution tails.
    x= meansc(v,perci,percf)
            "perci" = % of min values;  "percf" = % of max values to be excluded
 
    Version 1.00, Date: 08/04/2000
    '''
    if (lower_percentil == upper_percentil and lower_percentil == 0.5) or len(x)== 1:
        return np.median(x)
    lower_border = np.quantile(x, lower_percentil, interpolation='lower')
    upper_border = np.quantile(x, upper_percentil, interpolation='higher')
    in_borders = lambda i: i> lower_border and i< upper_border

    return np.mean([i for i in x if in_borders(i)])

    
def QRSdet_ann_cmp_fm(qrs_det,qrs_ref, maxaDiff=0.075, debug=False,f=1000):
    '''
     -------------------------------------------------------------------------------------------------
       Routine to compare QRS detection annotations
    
     --- Input parameters:
       qrs_det      estimated time position for QRS complex
       qrs_ref      reference time position for QRS complex
       maxaDiff  max absolute difference between qrs_det and qrs_ref position
       debug     debug flag
     --- Output parameters:
       cmpRes.nTP            number of True Positives (TP) (matching annotations)
       cmpRes.nFP            number of False Positives (FP)
       cmpRes.nFN            number of False Negatives (FN)
       cmpRes.meanAbsDiff    mean of absolute differences between TP annotations
    '''
    max_dist = maxaDiff*f
    qrs_det = qrs_det
    # nTP ... number of TP
    # meanAbsDiff ... sum(qrs_diffs of TP) / nTP
    nTP = 0
    dist_TP = []

    def find_nearest(array, value):
        n = [abs(i-value) for i in array]
        idx = n.index(min(n))
        return array[idx]

    for beat in qrs_ref:
        nearest = find_nearest(qrs_det, beat)
        distance = abs(nearest-beat)
        if distance < max_dist:
            nTP += 1
            dist_TP.append(distance)
    
    nFP = len(qrs_det)-nTP   # number of False Positives
    nFN = len(qrs_ref)-nTP   # number of False Negatives

    r = {'nTP':nTP, 
         'nFP':nFP, 
         'nFN':nFN, 
         'meanAbsDiff':np.mean(dist_TP)}
    return r


#qrs_detet_ann_cmp_fm([0,500,1000,1500], [i+ 50 for i in [0,500,1000,1500]])


{'nTP': 0, 'nFP': 4, 'nFN': 4, 'meanAbsDiff': nan}




