#!/bin/env python

def main():
    star='sd_dppr.star'
    h='head.star'

    with open(star, mode='r') as fi:
        while 1:
            l=fi.readline()
            if len(l.split(' ')) <= 3:
                fo=open(h, mode='a')
                fo.write(l)
                fo.close()
            else:
                break

if __name__ == '__main__':
    main()

