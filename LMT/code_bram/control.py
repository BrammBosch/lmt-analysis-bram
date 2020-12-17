import numpy as np
from sklearn import cluster, datasets

from code_bram.SVM.simple_SVM import run_SVM
from code_bram.SVM.duration_event_create_data_and_class import create_data_and_class

def main():
    control_svm()


def control_svm():
    avg_all_events, data_class = create_data_and_class()

    for line in avg_all_events:
        print(len(line))

    for i in range(5):
        run_SVM(np.array(avg_all_events), data_class, i)



if __name__ == '__main__':

    main()

