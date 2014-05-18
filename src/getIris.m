function [iris, shuffledIris, irisTrain, irisTest, irisTrainIn, ...
    irisTrainOut, irisTestIn, irisTestOut] = getIris(trainingSize)

    % Φόρτωμα του iris dataset
    load iris.dat;

    % Επειδή τα δεδομένα στο iris.dat είναι ταξινομημένα βάσει την κλάση,
    % ανακατεύουμε τον πίνακα και τον αποθηκεύουμε σε μια νέα μεταβλητή,
    % ώστε να πάρουμε δείγμα από όλες (?) τις κλάσεις
    shuffledIris = iris(randperm(size(iris, 1)), :);

    % Αντιγράφουμε σε μια μεταβλητή τις πρώτες 75 γραμμές του ανακατεμένου
    % πίνακα, οι οποίες θα χρησιμοποιηθούν για την εκπαίδευση
    irisTrain = shuffledIris(1:trainingSize, :);

    % Αντιγράφουμε σε μια άλλη μεταβλητή τις υπόλοιπες γραμμές του
    % ανακατεμένου πίνακα, οι οποίες θα χρησιμοποιηθούν για τον έλεγχο
    irisTest = shuffledIris((trainingSize + 1):150, :);

    % Χωρισμός δεδομένων
    irisTrainIn = irisTrain(:, 1:4);
    irisTrainOut = irisTrain(:, 5);
    irisTestIn = irisTest(:, 1:4);
    irisTestOut = irisTest(:, 5);
end