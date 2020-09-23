from sklearn.datasets import load_digits
from sklearn.model_selection  import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import roc_curve
import matplotlib.pylab as plt
from sklearn.metrics import roc_auc_score

digits = load_digits()
y = digits.target == 8
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, y, random_state=0)
plt.figure()

for gamma in [1, 0.1, 0.01]:
    svc = SVC(gamma=gamma).fit(X_train, y_train)
    accuracy = svc.score(X_test, y_test)
    auc = roc_auc_score(y_test, svc.decision_function(X_test))
    fpr, tpr, _ = roc_curve(y_test , svc.decision_function(X_test))
    print("gamma = {:.2f}  accuracy = {:.2f}  AUC = {:.2f}".format(
        gamma, accuracy, auc))
    plt.plot(fpr, tpr, label="gamma={:.2f}".format(gamma))
    
plt.xlabel("FPR")
plt.ylabel("TPR")
plt.xlim(-0.01, 1)
plt.ylim(0, 1.02)
plt.legend(loc="best")
plt.show()
