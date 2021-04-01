import pandas as pd
import matplotlib.pyplot as plt


def compare_pre_post_merge(sheets,event_name,stat,loc,pre_or_post):
    results_wt = []
    results_het = []

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

    results_wt = [elem / norm for elem in results_wt]

    results_het = [elem / norm for elem in results_het]

    #print(results_wt[0]/(sum(results_wt)/len(results_wt)))


    fig1, ax1 = plt.subplots()
    ax1.set_title(values[event_name][0] + ' ' + pre_or_post)

    ax1.boxplot([results_wt,results_het])

    plt.xticks([1, 2], ['WT', 'HET'])
    ax1.axes.set_ylim([0, 2])

    plt.show()

if __name__ == '__main__':
    sheets = ['28042020', '11052020', '12052020', '13052020', '24082020', '25082020', '26082020', '12102020',
              '14102020', '26102020', '27102020', '16112020', '11012021', '16022021']
    event_name = 15
    stat = 1
    loc_list = [r'D:\LMT_data_post\event_information_post.xlsx',r'C:\Users\Bram\Documents\radboud\LMT_data_merged\event_information_merged.xlsx']
    i=0
    for loc in loc_list:
        if i == 0:
            pre_or_post = 'pre merge'
        else:
            pre_or_post = 'post merge'

        compare_pre_post_merge(sheets,event_name,stat,loc,pre_or_post)
        i+= 1