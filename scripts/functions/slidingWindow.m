function result = slidingWindow(mat, windowLength, varargin)
%SLIDINGWINDOW uses the sliding window approach to generate a 3D array from
% a matrix.
%   Chops up the matrix into a an array of overlapping slices of the original
%   matrix, each slice having a fixed length of `windowLength`.
%   Basically, this is a spatial representation of the sliding window
%   approach.
%
% Optional arguments:
%   `dim`: the dimension over which to slice the original matrix. Defaults
%   to `1` (vertical).
%
% Notes:
%   If the input matrix has dimensions N x F, then the 3D array
%   returned will have dimensions W x F x M,
%   where W is `windowLength` and M is the number of unique overlapping
%   slices over the input matrix.
%   When dim=2, the mapping is instead F x N -> F x W x M.
%

dim = 1;
for k = 1:2:length(varargin)
    name = varargin{k};
    value = varargin{k+1};
    if strcmpi(name, "dim")
        dim = value;
    else
        error("slidingWindow:unkownArg", "Unknown named argument " + name);
    end
end

% Transpose the matrix if the user indicated that it
% should be sliced in a different dimesnion.
if dim == 2
    mat = mat';
elseif dim ~= 1
    error("slidingWindow:dim", "Argument `dim` must be either 1 or 2");
end

N = size(mat, 1);
F = size(mat, 2);
M = N - windowLength + 1;

if M <= 0
    error("slidingWindow:windowLength", "Window length of `"...
        + windowLength + "` is too long for input matrix, which only " ...
        + "has `" + N + "` observations.");
end

result = zeros(windowLength, F, M);
for m = 1:M
    for f = 1:F
        for s = 1:windowLength
            % Subtract '1' to prevent an off-by-one error.
            % Since matlab's indices start at 1 for some reason,
            % `m + s` ends up being 1 greater than we want.
            result(s, f, m) = mat(m + s - 1, f);
        end
    end
end

% If the matrix was previously transposed,
% transform it back.
% This is the principle of least surprise; we should try to put everything
% back into the form we received it in.
if dim == 2
    result = permute(result, [2 1 3]);
end

end

