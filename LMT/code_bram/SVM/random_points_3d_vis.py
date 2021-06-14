import math

import matplotlib.pyplot as plt
import random
import numpy as np


from code_bram.SVM.simple_SVM import visualise_2_features

plt.ion()

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

points_middleX =[]
points_middleY =[]
points_middleZ = []
data_class = []
points = []
points_roundX = []
points_roundY = []
points_roundZ = []
for i in range(100):
    points_middleX.append(random.uniform(2,4))
    points_middleY.append(random.uniform(2,4))
    points.append([random.uniform(2,4),random.uniform(2,4)])
    data_class.append(1)
for i in range(1000):

    will = random.random()
    if will < 0.25:
        points_roundX.append(random.uniform(0, 1))
        points_roundY.append(random.uniform(0, 6))
        points.append([random.uniform(0, 1), random.uniform(0, 6)])

    elif will > 0.25 and will < 0.5:
        points_roundX.append(random.uniform(5, 6))
        points_roundY.append(random.uniform(0, 6))
        points.append([random.uniform(5, 6), random.uniform(0, 6)])
    elif will > 0.5 and will < 0.75:
        points_roundX.append(random.uniform(0, 6))
        points_roundY.append(random.uniform(5, 6))
        points.append([random.uniform(0, 6), random.uniform(5, 6)])
    else:
        points_roundX.append(random.uniform(0, 6))
        points_roundY.append(random.uniform(0, 1))
        points.append([random.uniform(0, 6), random.uniform(0, 1)])
    data_class.append(0)

i=0
while i < len(points_middleX):
    points_middleZ.append(math.sqrt( ((points_middleX[i]-3)**2)+((points_middleY[i]-3)**2) ))
    #points_middleZ.append(1)
    i+= 1
i=0
while i < len(points_roundX):
    points_roundZ.append(math.sqrt( ((points_roundX[i]-3)**2)+((points_roundY[i]-3)**2) ))

    #points_roundZ.append(2)
    i+= 1
print(points_middleZ)


ax.scatter(points_middleX,points_middleY,points_middleZ,color='red')
ax.scatter(points_roundX,points_roundY,points_roundZ,color ='blue')


ax.set_xlabel('Feature 1')
ax.set_ylabel('Feature 2')
#ax.set_zlabel('RBF added feature')

ax.view_init(elev=5, azim=60)
ax.set_zlim(-5,5)

plt.show()




#visualise_2_features(points,data_class)
