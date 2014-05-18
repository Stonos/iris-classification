function setSeed(seed)
    % Στις καινούργιες εκδόσεις του MATLAB είναι προτιμότερο
    % να χρησιμοποιείται η RandStream
    if (exist('RandStream') ~= 0)
        s = RandStream('mcg16807', 'Seed', seed);
        RandStream.setGlobalStream(s);
    else
        rand('seed', seed);
        randn('seed', seed);
    end
end