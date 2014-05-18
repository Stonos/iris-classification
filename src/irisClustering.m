function [trainRMSE, checkRMSE, badTrainFis, badCheckFis] = ...
    irisClustering(seed, radius, squashFactor, acceptRatio, ...
    rejectRatio, epochs)

    % Ορισμός seed ώστε να βγαίνουν τα ίδια αποτελέσματα σε κάθε εκτέλεση
    setSeed(seed);

    % Φόρτωμα του iris dataset
    [iris, shuffledIris, irisTrain, irisTest, irisTrainIn, ...
        irisTrainOut, irisTestIn, irisTestOut] = getIris(75);

    % Δημιουργία FIS με subtractive clustering
    fis = genfis2(irisTrainIn, irisTrainOut, radius, ...
        [min(iris); max(iris)], [squashFactor acceptRatio rejectRatio 0]);

    % Εκπαίδευση του FIS
    [trainFis, trainError, stepSize, checkFis, checkError] = ...
        anfis(irisTrain, fis, epochs, [], irisTest);

    % Αξιολόγηση FIS εκπαίδευσης με δεδομένα ελέγχου, και εύρεση σφάλματος
    trainFisOut = round(evalfis(irisTestIn, trainFis));
    trainRMSE = norm(trainFisOut - irisTestOut)/sqrt(length(trainFisOut));
    badTrainFis = size(find((trainFisOut == irisTestOut) == 0), 1);

    % Αξιολόγηση FIS ελέγχου με δεδομένα ελέγχου, και εύρεση σφάλματος
    checkFisOut = round(evalfis(irisTestIn, checkFis));
    checkRMSE = norm(checkFisOut - irisTestOut)/sqrt(length(checkFisOut));
    badCheckFis = size(find((checkFisOut == irisTestOut) == 0), 1);

    % Εμφάνιση σφάλματος
    fprintf('Λάθος ταξινομήσεις με FIS εκπαίδευσης: %d (%.2f%%)\n', ...
        badTrainFis, badTrainFis / size(irisTest, 1) * 100);
    fprintf('Λάθος ταξινομήσεις με FIS ελέγχου: %d (%.2f%%)\n', ...
        badCheckFis, badCheckFis / size(irisTest, 1) * 100);
end