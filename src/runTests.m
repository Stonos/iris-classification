runs = [];

for radius = 0.6:0.1:1.5
    for squashFactor = 0.5:0.5:4
        for acceptRatio = 0.1:0.5:2
            for rejectRatio = 0.1:0.5:2
                try
                    fprintf('%.2f %.2f %.2f %.2f', radius, ...
                        squashFactor, acceptRatio, rejectRatio);
                    
                    [trainRMSE, checkRMSE, badTrainFis, badCheckFis] = ...
                        irisClustering(0, radius, squashFactor, ...
                        acceptRatio, rejectRatio, 2000);
                    runs = [runs; radius squashFactor acceptRatio ...
                        rejectRatio trainRMSE checkRMSE badTrainFis ...
                        badCheckFis];
                catch err
                    runs = [runs; radius squashFactor acceptRatio ...
                        rejectRatio NaN NaN NaN NaN];
                end
            end
        end
    end
end