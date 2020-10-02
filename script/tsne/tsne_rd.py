#!/bin/env python

import time
from sklearn.manifold import TSNE
import numpy as np
import argparse
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

if __name__=='__main__':
    starttime=time.time()

    parser = argparse.ArgumentParser()
    parser.add_argument('--input', '-i', type=str, default='input.npy',
                        help='input of t-SNE')
    parser.add_argument('--output', '-o', type=str, default='output.npy',
                        help='output of t-SNE')
    args = parser.parse_args()

    data_t = np.load(args.input, mmap_mode='r')
    tsne=TSNE(n_components=2)
    X=tsne.fit_transform(data_t)
    np.save(args.output, X) # output of t-sne

    plt.figure()
    plt.scatter(X[:, 0], X[:, 1])
    plt.legend()
    plt.savefig("tsne.png") # save figure

    endtime=time.time()
    print('time:',endtime-starttime)
