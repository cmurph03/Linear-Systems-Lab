%--------------------------------------------------------------------------
% Created: 8/29/13 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
%     12/19/18    There was a sleeping error in this function that has been
%                 fixed.  Occassionally, the last index in II was set to one
%                 integer greater than length(x).  This is now fixed.
% 
% Purpose: This function returns the definite integral of the input vector
%   over the time interval specified by the user.  
% 
% Variables: 
%   t - input time vector
%   x - input samples vector
%   a - (sec) left side of the time interval
%   b - (sec) left side of the time interval
%
%   y - output samples vector (pairs with the input t vector)
% 
% function y = intdef(t,x,a,b)
%--------------------------------------------------------------------------
function y = intdef(t,x,a,b)

% Check for illegal conditions on the input arguments
y = [];
if length(t) <= 1;  return;  end
if length(t) ~= length(x)
  disp('*** ERROR in intdef. Input variables t and x are not the same dimension.')
  return
end

% If the interval is not present, default to the full signal. 
if nargin < 4; b = t(end); end
if nargin < 3; a = t(1);   end

% Force the time interval left-side to be less than the right-side.
% If not, then swap a and b. 
if (a > b); c = a; a = b; b = c; end

% Convert the time vector into an index vector
T = abs(t(2)-t(1));
n = round(t/T);

% Determine the index range to integrate (sum)
na = round(a/T);
nb = round(b/T);

% Check for out of bound conditions
if na < n(1)
  disp(['*** WARNING in intdef, the left-side is out of bounds, setting to ' num2str(t(1))])
  na = n(1);
end
if nb > n(end)
  disp(['*** WARNING in intdef, the right-side is out of bounds, setting to ' num2str(t(end))])
  nb = n(end);
end

% Carry out the integration using the summation operation
II = find((n >= na) & (n <= nb));
%out = sprintf('*** inside intdef, II range %d to %d, length x is %d',min(II),max(II),length(x)); disp(out)
y = T*sum(x(II));

end