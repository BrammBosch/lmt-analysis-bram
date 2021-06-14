import pandas as pd
import matplotlib.pyplot as plt


def compare_pre_post_merge(sheets,event_name_list,stat,loc):
    results_wt = []
    results_het = []
    for event_name in event_name_list:
        for sheet in sheets:
            df = pd.read_excel (loc, sheet_name=sheet)
            values = df.values.tolist()
            #print(values)
            if values[0][3] == 'WT':
                results_wt.append(values[event_name][stat])

            else:
                results_het.append(values[event_name][stat])

            if values[0][9] == 'WT':
                results_wt.append(values[event_name][stat + 6])
            else:
                results_het.append(values[event_name][stat + 6])

            if values[0][15] == 'WT':
                results_wt.append(values[event_name][stat + 12])
            else:
                results_het.append(values[event_name][stat + 12])

            if values[0][21] == 'WT':
                results_wt.append(values[event_name][stat + 18])
            else:
                results_het.append(values[event_name][stat + 18])

    print(results_wt)
    print(results_het)

    norm = (sum(results_wt)/len(results_wt))

    print(norm)
    i=0
    while i < len(results_wt):
        norm = (results_wt[i]+results_wt[i+1]) / 2
        results_wt[i] = results_wt[i] / norm
        results_wt[i+1] = results_wt[i+1] / norm
        results_het[i] = results_het[i] / norm
        results_het[i+1] = results_het[i+1] / norm
        i+=2


    #results_wt = [elem / norm for elem in results_wt]

    #results_het = [elem / norm for elem in results_het]

    #print(results_wt[0]/(sum(results_wt)/len(results_wt)))

    return results_wt,results_het

def plotting(all_results_wt,all_results_het):
    #print(all_results_wt)
    #print(all_results_het)
    fig1, ax1 = plt.subplots()
    #ax1.set_title(values[event_name][0])

    ax1.boxplot([all_results_wt[0], all_results_wt[1],all_results_het[0],all_results_het[1]])

    plt.xticks([1, 2, 3, 4], ['WT premerge', 'WT postmerge', 'HET premerge', 'HET postmerge'])
    ax1.axes.set_ylim([0.7, 1.3])

    plt.show()

if __name__ == '__main__':
    sheets = ['28042020', '11052020', '12052020', '13052020', '24082020', '25082020', '26082020', '12102020',
              '14102020', '26102020', '27102020', '16112020', '11012021', '16022021']
    event_name_list = [21]
    stat = 1
    loc_list = [r'D:\LMT_data_post\event_information_post.xlsx',r'C:\Users\Bram\Documents\radboud\LMT_data_merged\event_information_merged.xlsx']
    all_results_wt = []
    all_results_het = []
    for loc in loc_list:


        results_wt, results_het = compare_pre_post_merge(sheets,event_name_list,stat,loc)
        all_results_wt.append(results_wt)
        all_results_het.append(results_het)
    plotting(all_results_wt,all_results_het)