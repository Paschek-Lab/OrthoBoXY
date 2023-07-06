#!/usr/bin/bash

echo
echo '../src/kikugawa_iso -l 1.0 -alpha 1.0 -hmax 100 -kmax 100'
../src/kikugawa_iso -l 1.0 -alpha 1.0 -hmax 100 -kmax 100

echo
echo '../src/kikugawa_aniso -lx 1.0 -ly 1.0 -lz 1.0 -alpha 1.0 -hmax 100 -kmax 100'
../src/kikugawa_aniso -lx 1.0 -ly 1.0 -lz 1.0 -alpha 1.0 -hmax 100 -kmax 100

echo
echo '../src/kikugawa_aniso -hmax 100 -kmax 100 -alpha 1.0 -lx 1.0 -ly 1.0 -lz 2.7933596497'
../src/kikugawa_aniso -hmax 100 -kmax 100 -alpha 1.0 -lx 1.0 -ly 1.0 -lz 2.7933596497
