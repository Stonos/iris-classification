% Καθάρισμα μεταβλητών
clear;

% Ορισμός seed ώστε να βγαίνουν τα ίδια αποτελέσματα σε κάθε εκτέλεση
s = RandStream('mcg16807', 'Seed', 3);
RandStream.setGlobalStream(s);

RADIUS = 0.8;

% Φόρτωμα του iris dataset
load iris.dat;

% Επειδή τα δεδομένα στο iris.dat είναι ταξινομημένα βάσει την κλάση,
% ανακατεύουμε τον πίνακα και τον αποθηκεύουμε σε μια νέα μεταβλητή,
% ώστε να πάρουμε δείγμα από όλες (?) τις κλάσεις
shuffledIris = iris(randperm(size(iris, 1)), :);

% Αντιγράφουμε σε μια μεταβλητή τις πρώτες 75 γραμμές του ανακατεμένου
% πίνακα, οι οποίες θα χρησιμοποιηθούν για την εκπαίδευση
irisTrain = shuffledIris(1:75, :);

% Αντιγράφουμε σε μια άλλη μεταβλητή τις υπόλοιπες γραμμές του ανακατεμένου
% πίνακα, οι οποίες θα χρησιμοποιηθούν για τον έλεγχο
irisTest = shuffledIris(76:150, :);

% Χωρισμός δεδομένων
irisTrainIn = irisTrain(:, 1:4);
irisTrainOut = irisTrain(:, 5);
irisTestIn = irisTest(:, 1:4);
irisTestOut = irisTest(:, 5);

% Δημιουργία FIS με subtractive clustering
fis = genfis2(irisTrainIn, irisTrainOut, RADIUS, [min(iris); max(iris)]);

% Εκπαίδευση του FIS με 8000 εποχές
[trainFis, trainError, stepSize, checkFis, checkError] = ...
    anfis(irisTrain, fis, 8000, [], irisTest);

% Αξιολόγηση FIS εκπαίδευσης με δεδομένα ελέγχου, και εύρεση σφάλματος
trainFisOut = round(evalfis(irisTestIn, trainFis));
trainRMSE = norm(trainFisOut - irisTestOut) / sqrt(length(trainFisOut));
badTrainFis = size(find((trainFisOut == irisTestOut) == 0), 1);

% Αξιολόγηση FIS ελέγχου με δεδομένα ελέγχου, και εύρεση σφάλματος
checkFisOut = round(evalfis(irisTestIn, checkFis));
checkRMSE = norm(checkFisOut - irisTestOut) / sqrt(length(checkFisOut));
badCheckFis = size(find((checkFisOut == irisTestOut) == 0), 1);

% Εμφάνιση σφάλματος
fprintf('Λάθος ταξινομήσεις με FIS εκπαίδευσης: %d (%.2f%%)\n', ...
    badTrainFis, badTrainFis / size(irisTest, 1) * 100);
fprintf('Λάθος ταξινομήσεις με FIS ελέγχου: %d (%.2f%%)\n', ...
    badCheckFis, badCheckFis / size(irisTest, 1) * 100);