#!/bin/bash
# Copyright © 2014, William N. Braswell, Jr.. All Rights Reserved. This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.

#cd /home/wbraswell/austin_perl_mongers/rperl/rperl-latest
#pwd
#echo "1 " $1 > /tmp/perlcritic_args.out
#echo "2 " $2 >> /tmp/perlcritic_args.out
#echo "3 " $3 >> /tmp/perlcritic_args.out
#echo "4 " $4 >> /tmp/perlcritic_args.out
#echo "5 " $5 >> /tmp/perlcritic_args.out
#echo "6 " $6 >> /tmp/perlcritic_args.out
#/home/wbraswell/perl5/bin/perlcritic $1 --verbose "$3" > /tmp/perlcritic.out
#/home/wbraswell/perl5/bin/perlcritic $1 --verbose "$3"
/home/wbraswell/perl5/bin/perlcritic $1 $2 "$3"