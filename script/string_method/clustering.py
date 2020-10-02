#!/bin/env python
import numpy as np
import os

x = np.load('./after_dl_tsne_2d_s0.npy')
x=x[4:]
c = np.load('./centers_20.npy')

for n in range(c.shape[0]):
    os.mkdir('c' + str(n+1))

for i in range(x.shape[0]):
    print('item:' + str(i+1))
    dist=[]
#    print('i:' + str(i))
#    print('dist:' + str(np.linalg.norm(x[i]-x[0])))
    for n in range(c.shape[0]): 
        dist.append([n, np.linalg.norm(x[i]-c[n])])
    dist=sorted(dist, key=lambda x:x[1])
#    print(dist)
    if dist[0][1]<30.0:
        print(dist[0])
        for n in range(c.shape[0]):
            if dist[0][0] == n:
                with open('c' + str(n+1) + '/c' + str(n+1), 'a') as f:
                    f.write(str(i+1) + " " + str(dist[0][1]) + "\n")

