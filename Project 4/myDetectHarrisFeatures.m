function points = myDetectHarrisFeatures(I)
%MYDETECTHARRISFEATURES Does the same thing as detectHarrisFeatures
%   TODO: Nikhil

    % We can't use any built-in functions, so make sure to replace this.
    % Use our custom gaussian filter stuff from previous labs
    % Look at the source code of detectHarrisFeatures() for help:
    % run command 'open vision.internal.detector.harrisMinEigen'
    points = detectHarrisFeatures(I);
    
end

