def sort_split(results):
    """
    This function takes a list of rows from a table and splits the rows in 4 sublists for each animal and sorts them on:
    AnimalA, AnimalB, AnimalC, AnimalD, the event name and the startframe in that order.
    """
    animals = [[], [], [], []]

    for line in results:
        if line[5] == 1:
            animals[0].append(line)
        elif line[5] == 2:
            animals[1].append(line)
        elif line[5] == 3:
            animals[2].append(line)
        else:
            animals[3].append(line)

    animals[0] = sorted(animals[0], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[1], x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[1] = sorted(animals[1], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[1], x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[2] = sorted(animals[2], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[1], x[3]))  # <- Sort the 2d lists animals and then the start frame
    animals[3] = sorted(animals[3], key=lambda x: ((x[6] is None, x[6]), (x[7] is None, x[7]), (x[8] is None, x[8]),
                                                   x[1], x[3]))  # <- Sort the 2d lists animals and then the start frame

    return animals
