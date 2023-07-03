#!/usr/bin/bash

echo
echo '../src/kikugawa_iso -b 1.0 -alpha 1.0 -hmax 100 -kmax 100'
../src/kikugawa_iso -b 1.0 -alpha 1.0 -hmax 100 -kmax 100

echo
echo '../src/kikugawa_aniso -bx 1.0 -by 1.0 -bz 1.0 -alpha 1.0 -hmax 100 -kmax 100'
../src/kikugawa_aniso -bx 1.0 -by 1.0 -bz 1.0 -alpha 1.0 -hmax 100 -kmax 100

echo
echo '../src/kikugawa_aniso -hmax 100 -kmax 100 -bx 1.0 -by 1.0 -bz 2.7933596497257'
../src/kikugawa_aniso -hmax 100 -kmax 100 -bx 1.0 -by 1.0 -bz 2.7933596497257

echo
echo '../src/kikugawa_aniso -hmax 100 -kmax 100 -bx 1.0 -by 1.0 -bz 2.7933596497'
../src/kikugawa_aniso -hmax 100 -kmax 100 -bx 1.0 -by 1.0 -bz 2.7933596497
