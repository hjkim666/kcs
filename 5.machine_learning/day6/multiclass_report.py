from sklearn.metrics import accuracy_score
from sklearn.datasets import load_digits
from sklearn.model_selection  import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix

digits = load_digits()
y = digits.target == 8
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, random_state=0)

lr = LogisticRegression().fit(X_train, y_train)
pred = lr.predict(X_test)
print("Accuracy: {:.3f}".format(accuracy_score(y_test, pred)))
print("confusion matrix:\n{}".format(confusion_matrix(y_test, pred)))

######
import matplotlib.pylab as plt
import mglearn
scores_image = mglearn.tools.heatmap(
    confusion_matrix(y_test, pred), xlabel='prediction',
    ylabel='class', xticklabels=digits.target_names,
    yticklabels=digits.target_names, cmap=plt.cm.gray_r, fmt="%d")    
plt.title("confusion matrix")
plt.gca().invert_yaxis()
plt.show()

######
from sklearn.metrics import classification_report
print(classification_report(y_test, pred))

from sklearn.metrics import f1_score
print("micro mean_f1_score: {:.3f}".format(f1_score(y_test, pred, average="micro")))
print("macro mean_f1_score: {:.3f}".format(f1_score(y_test, pred, average="macro")))

