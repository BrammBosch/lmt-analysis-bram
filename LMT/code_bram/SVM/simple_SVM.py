import sys

import matplotlib.pyplot as plt
import numpy as np
from sklearn import svm, metrics
from sklearn.feature_selection import SelectKBest, chi2
import pandas as pd
from sklearn.model_selection import train_test_split




def visualise_2_features(X, y):
    X = np.array(X)

    h = .02  # step size in the mesh

    C = 1.0  # SVM regularization parameter
    svc = svm.SVC(kernel='linear', C=C).fit(X, y)
    rbf_svc = svm.SVC(kernel='rbf', gamma=0.7, C=C).fit(X, y)
    poly_svc = svm.SVC(kernel='poly', degree=3, C=C).fit(X, y)
    lin_svc = svm.LinearSVC(C=C).fit(X, y)



    # create a mesh to plot in
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))

    # title for the plots
    titles = ['SVC with linear kernel',
              'LinearSVC (linear kernel)',
              'SVC with RBF kernel',
              'SVC with polynomial (degree 3) kernel']

    for i, clf in enumerate((svc, lin_svc, rbf_svc, poly_svc)):
        # Plot the decision boundary. For that, we will assign a color to each
        # point in the mesh [x_min, x_max]x[y_min, y_max].
        plt.subplot(2, 2, i + 1)
        plt.subplots_adjust(wspace=0.4, hspace=0.4)

        Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])

        # Put the result into a color plot
        Z = Z.reshape(xx.shape)
        plt.contourf(xx, yy, Z, cmap=plt.cm.coolwarm, alpha=0.8)

        # Plot also the training points
        plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.coolwarm)
        #plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.coolwarm)

        plt.xlabel('Sepal length')
        plt.ylabel('Sepal width')
        plt.xlim(xx.min(), xx.max())
        plt.ylim(yy.min(), yy.max())
        plt.xticks(())
        plt.yticks(())
        plt.title(titles[i])

    plt.show()

    plt.show()


def run_SVM(data, data_class, r):
    print('Amount of features: ' + str(len(data[0])))
    #data = SelectKBest(chi2, k=20).fit_transform(data, data_class)



    score_lin, coef,feature_names = run_SVM_linear(data, data_class, r)
    score_poly = run_SVM_poly(data, data_class, r)
    score_RBF = run_SVM_RBF(data, data_class, r)

    return score_lin,score_poly,score_RBF, coef, feature_names


def run_SVM_linear(data, data_class, r):
    train, benchmark, train_class, benchmark_class = train_test_split(data, data_class, test_size=0.2, random_state=r)

    C = 1.0
    print('============================================')
    print("training now Linear")
    svc = svm.SVC(kernel='linear')

    svc.fit(train, train_class)

    predicted = svc.predict(benchmark)
    score = svc.score(benchmark, benchmark_class)
    print('============================================')
    print('\nScore ', score)
    print('\nResult Overview\n', metrics.classification_report(benchmark_class, predicted))
    print('\nConfusion matrix:\n', metrics.confusion_matrix(benchmark_class, predicted))



    # whatever your features are called
    features_names = []
    list_events = ['WallJump','Rear isolated','SAP','Move isolated', 'Stop isolated']
    for item in list_events:
        for event in list_events:
            features_names.append(item + ' ' + event)

    return score, abs(svc.coef_[0]), features_names



def run_SVM_RBF(data, data_class, r):
    train, benchmark, train_class, benchmark_class = train_test_split(data, data_class, test_size=0.3, random_state=r)

    C = 1.0
    print('============================================')

    print("training now rbf")
    svc = svm.SVC(kernel='rbf', gamma=0.7, C=C)

    svc.fit(train, train_class)

    predicted = svc.predict(benchmark)
    score = svc.score(benchmark, benchmark_class)
    print('============================================')
    print('\nScore ', score)
    print('\nResult Overview\n', metrics.classification_report(benchmark_class, predicted))
    print('\nConfusion matrix:\n', metrics.confusion_matrix(benchmark_class, predicted))
    return score

def run_SVM_poly(data, data_class, r):
    train, benchmark, train_class, benchmark_class = train_test_split(data, data_class, test_size=0.2, random_state=r)

    C = 1.0
    print('============================================')
    print("training now poly")
    svc = svm.SVC(kernel='poly', gamma=0.7, C=C)

    svc.fit(train, train_class)

    predicted = svc.predict(benchmark)
    score = svc.score(benchmark, benchmark_class)
    print('============================================')
    print('\nScore ', score)
    print('\nResult Overview\n', metrics.classification_report(benchmark_class, predicted))
    print('\nConfusion matrix:\n', metrics.confusion_matrix(benchmark_class, predicted))
    return score

if __name__ == '__main__':
    # data = np.array([[102, 102], [104, 104], [90, 90], [103, 103], [80, 80], [110, 110], [50, 50],
    #        [150, 150], [101, 101], [99, 99], [100, 100]])

    data = np.array(
        [[12, 12,13], [11, 11,4], [9, 9,5], [7, 7,4], [5, 5,6], [16, 16,2], [18, 18,1], [21, 21,7], [25, 25,8], [40, 40,6], [16, 16,8],
         [15, 20,67], [6, 15,67]])

    data_class = [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 2, 2]
    run_SVM(data, data_class, 42)
    #visualise_2_features(data, data_class)
