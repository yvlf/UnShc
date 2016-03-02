#!/bin/bash

#
# Author: Luiz Otavio Duarte a.k.a. (LOD)
#  11/03/08 - v.0.1
# Updated: Yann CAM v0.2 - yann.cam@gmail.com | www.asafety.fr
#  06/27/13 - v.0.2
#  -- Adding new objdump format (2.22) to retrieve data (especially on Ubuntu distribution)
#  -- Patch few regex with sorted address list
#
VERSION="0.2"

OBJDUMP=/usr/bin/objdump
GREP=/bin/grep
CUT=/usr/bin/cut
SHRED=/usr/bin/shred

BINARY=$1
TMPBINARY=$(mktemp /tmp/XXXXXX)
OBJFILE=$(mktemp /tmp/XXXXXX)
STRINGFILE=$(mktemp /tmp/XXXXXX)
CALLFILE=$(mktemp /tmp/XXXXXX)

CALLADDRFILE=$(mktemp /tmp/XXXXXX)
CALLSIZEFILE=$(mktemp /tmp/XXXXXX)

declare -A LISTOFCALL

# Variable to know the index of variables.
j=0

function usage(){
 echo "!- usage : $0 <file.sh.x>"
 echo "!- e.g : $0 script.sh.x"
}

function check_binaries() {
 if [ ! -x ${OBJDUMP} ]
 then
  echo "!- Error, cannot execute or find objdump binary"
  exit 1
 fi
 if [ ! -x ${GREP} ]
 then
  echo "!- Error, cannot execute or find grep binary"
  exit 1
 fi
 if [ ! -x ${CUT} ]
 then
  echo "!- Error, cannot execute or find cut binary"
  exit 1
 fi
 if [ ! -x ${SHRED} ]
 then
  echo "!- Error, cannot execute or find shred binary"
  exit 1
 fi
}

function generate_dump() {
 # Generate objdump to OBJFILE
 $OBJDUMP -D $BINARY > $OBJFILE

 # Generate another dump para STRINGFILE
 $OBJDUMP -s $BINARY > $STRINGFILE
}

function extract_variables_from_binary(){
 ##
 # For ever full address in $CALLFILE
 ##
 IFS=$'\n' read -d '' -r -a LISTOFADDR < $CALLADDRFILE
 IFS=$'\n' read -d '' -r -a LISTOFSIZE < $CALLSIZEFILE
echo ${#LISTOFADDR[*]}
 for (( x=0; x<${#LISTOFADDR[*]}; x=x+1 ))
 do
  i=${LISTOFADDR[$x]}
  NBYTES=${LISTOFSIZE[$x]}
  echo -n "[$x] Working with var address: $i | size : $NBYTES"
  # Some diferences in assembly.
  # We can have:
  #  mov <adr>,%eax
  #  push 0x<hex>
  #  push %eax
  #  call $CALLADDR
  #
  #  or
  #
  #  push 0x<hex>
  #  push 0x<adr>
  #  call $CALLADDR
  #
  # UPDATE 27/06/2013 :
  # Adding support of objdump format in Ubuntu distribution
  # New format supported :
  #
  #  movl   $0x<hex>,0x4(%esp)
  #
  #  movl   $0x<adr>,(%esp)
  #  call   $CALLADDR
  #
  #if [ "x$($GREP "movl" $CALLFILE)" != "x" ]
  #then
  #  NBYTES=$($GREP -B 2 -E "$i" $CALLFILE | head -n 1 | $GREP movl | $GREP -Eo "0x[0-9a-f]+," | $GREP -Eo "0x[0-9a-f]+" )
  #elif [ "x$($GREP "mov.*$i" $CALLFILE)" != "x" ]
  #then
  # NBYTES=$($GREP -A 1 -E "$i" $CALLFILE | $GREP push | $GREP -Eo "0x[0-9a-f]+" )
  #else
  # NBYTES=$($GREP -B 1 -E "$i" $CALLFILE | $GREP push | $GREP -Eo "0x[0-9a-f]+" )
  #fi
  #echo -n "| length extracted : [$NBYTES]"
  echo -n "."

  ##
  # Key is the address with the variable content.
  ##
  KEY=$(echo $i | $CUT -d 'x' -f 2)

  ##
  # A 2 bytes variable (NBYTES > 0) can be found like this: (in STRINGFILE)
  # ---------------X
  # X---------------
  #
  # So we need 2 lines from STRINGFILE to make it all correct. So:
  NLINES=$(( ($NBYTES / 16) +2 ))

  # All line in STRINGFILE starts from 0 to f. So LASTBIT tells me the
  #  index in the line to start recording.
  let LASTBYTE="0x${KEY:$((${#KEY}-1))}"

  # echo :-
  # echo :- $KEY: $NBYTES - $LASTBYTE

  # Grep all lines needed from STRINGFILE, merge lines.
  STRING=$( $GREP -A $(($NLINES-1)) -E "^ ${KEY:0:$((${#KEY}-1))}0 " $STRINGFILE | awk '{ print $2$3$4$5}' | tr '\n' 'T' | sed -e "s:T::g")

  echo -n "."
  # Change string to begin in the line index.
  STRING=${STRING:$((2*$LASTBYTE))}
  # Cut the string to the number off bytes of the variable.
  STRING=${STRING:0:$(($NBYTES * 2))}


  ###
  # We need to mount a \x??\x?? structure so:
  FINALSTRING=""
  for ((i=0;i<$((${#STRING} /2 ));i++))
  do
   FINALSTRING="${FINALSTRING}\x${STRING:$(($i * 2)):2}"
  done

  echo "."

  define_variable

done
}

function define_variable() {

 ##
 # The variable name depends on the arc4 call sequence.
 ##
 # The first time is called arc4 with MSG1 variable.. and so one.
 ##

 if [ $j -eq 0 ]
 then
  VAR_MSG1=$FINALSTRING
  VAR_MSG1_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 1 ]
 then
  VAR_DATE=$FINALSTRING
  VAR_DATE_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 2 ]
 then
  VAR_SHLL=$FINALSTRING
  VAR_SHLL_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 3 ]
 then
  VAR_INLO=$FINALSTRING
  VAR_INLO_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 4 ]
 then
  VAR_XECC=$FINALSTRING
  VAR_XECC_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 5 ]
 then
  VAR_LSTO=$FINALSTRING
  VAR_LSTO_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 6 ]
 then
  VAR_TST1=$FINALSTRING
  VAR_TST1_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 7 ]
 then
  VAR_CHK1=$FINALSTRING
  VAR_CHK1_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 8 ]
 then
  VAR_MSG2=$FINALSTRING
  VAR_MSG2_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 9 ]
 then
  VAR_RLAX=$FINALSTRING
  VAR_RLAX_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 10 ]
 then
  VAR_OPTS=$FINALSTRING
  VAR_OPTS_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 11 ]
 then
  VAR_TEXT=$FINALSTRING
  VAR_TEXT_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 12 ]
 then
  VAR_TST2=$FINALSTRING
  VAR_TST2_Z=$NBYTES
  j=$(($j + 1))
 elif [ $j -eq 13 ]
 then
  VAR_CHK2=$FINALSTRING
  VAR_CHK2_Z=$NBYTES
  j=$(($j + 1))
 fi

}

function extract_password_from_binary(){

 echo :- Extracting password

 ###
 # The password is used in the key function right before first call to arc4.
 ##
 # So the previous call from the first "call CALLADDR" is the function I need.
 ##
 # Update 27/06/2013 : Add new objdump format

 $GREP -B 8 -m 1 "call   $CALLADDR" $OBJFILE | $GREP -v $CALLADDR > $CALLFILE
 cat $CALLFILE
 # Discovering the address containing the key.
 # Update 27/06/2013 : Add new objdump format
 if [ "x$($GREP "movl" $CALLFILE)" != "x" ]
 then
  KEY_ADDR=$($GREP -B 4 -m 1 "call" $CALLFILE | $GREP mov | $GREP -oE "0x[0-9a-z]{7}")

  # Discovering the key size.
  KEY_SIZE=$($GREP -B 3 -m 1 "call" $CALLFILE | $GREP movl | $GREP -oE "0x[0-9a-z]+," | $GREP -oE "0x[0-9a-z]+")
 else
  KEY_ADDR=$($GREP -B 3 -m 1 "call" $CALLFILE | $GREP mov | $GREP -oE "0x[0-9a-z]+")

  # Discovering the key size.
  KEY_SIZE=$($GREP -B 3 -m 1 "call" $CALLFILE | $GREP push | $GREP -oE "0x[0-9a-z]+")
 fi

echo "KEYADDR : $KEY_ADDR"
echo "KEYSIZE : $KEY_SIZE"

 # Defining the address without 0x.
 KEY=$(echo $KEY_ADDR | $CUT -d 'x' -f 2)

 # Like the other NLINES
 NLINES=$(( ($KEY_SIZE / 16) +2 ))
 # Like the other LASTBYTE
 LASTBYTE="0x${KEY:$((${#KEY}-1))}"

 STRING=$( $GREP -A $(($NLINES-1)) -E "^ ${KEY:0:$((${#KEY}-1))}0 " $STRINGFILE | awk '{ print $2$3$4$5}' | tr '\n' 'T' | sed -e "s:T::g")

 STRING=${STRING:$((2*$LASTBYTE))}
 STRING=${STRING:0:$(($KEY_SIZE * 2))}

 FINALSTRING=""
 for ((i=0;i<$((${#STRING} /2 ));i++))
 do
  FINALSTRING="${FINALSTRING}\x${STRING:$(($i * 2)):2}"
 done

 VAR_PSWD=$FINALSTRING
}

function generic_file(){
##
# This function append a generic engine for decrypt
#  from shc project. With my own new variables =P
##
cat > ${TMPBINARY}.c << EOF
#define msg1_z $VAR_MSG1_Z
#define date_z $VAR_DATE_Z
#define shll_z $VAR_SHLL_Z
#define inlo_z $VAR_INLO_Z
#define xecc_z $VAR_XECC_Z
#define lsto_z $VAR_LSTO_Z
#define tst1_z $VAR_TST1_Z
#define chk1_z $VAR_CHK1_Z
#define msg2_z $VAR_MSG2_Z
#define rlax_z $VAR_RLAX_Z
#define opts_z $VAR_OPTS_Z
#define text_z $VAR_TEXT_Z
#define tst2_z $VAR_TST2_Z
#define chk2_z $VAR_CHK2_Z
#define pswd_z $KEY_SIZE

static char msg1 [] = "$VAR_MSG1";
static char date [] = "$VAR_DATE";
static char shll [] = "$VAR_SHLL";
static char inlo [] = "$VAR_INLO";
static char xecc [] = "$VAR_XECC";
static char lsto [] = "$VAR_LSTO";
static char tst1 [] = "$VAR_TST1";
static char chk1 [] = "$VAR_CHK1";
static char msg2 [] = "$VAR_MSG2";
static char rlax [] = "$VAR_RLAX";
static char opts [] = "$VAR_OPTS";
static char text [] = "$VAR_TEXT";
static char tst2 [] = "$VAR_TST2";
static char chk2 [] = "$VAR_CHK2";
static char pswd [] = "$VAR_PSWD";

#define      hide_z     4096

/* rtc.c */

#include <sys/stat.h>
#include <sys/types.h>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

/* 'Alleged RC4' */

static unsigned char stte[256], indx, jndx, kndx;

/*
 * Reset arc4 stte.
 */
void stte_0(void)
{
        indx = jndx = kndx = 0;
        do {
                stte[indx] = indx;
        } while (++indx);
}

/*
 * Set key. Can be used more than once.
 */
void key(void * str, int len)
{
        unsigned char tmp, * ptr = (unsigned char *)str;
        while (len > 0) {
                do {
                        tmp = stte[indx];
                        kndx += tmp;
                        kndx += ptr[(int)indx % len];
                        stte[indx] = stte[kndx];
                        stte[kndx] = tmp;
                } while (++indx);
                ptr += 256;
                len -= 256;
        }
}

/*
 * Crypt data.
 */
void arc4(void * str, int len)
{
        unsigned char tmp, * ptr = (unsigned char *)str;
        while (len > 0) {
                indx++;
                tmp = stte[indx];
                jndx += tmp;
                stte[indx] = stte[jndx];
                stte[jndx] = tmp;
                tmp += stte[indx];
                *ptr ^= stte[tmp];
                ptr++;
                len--;
        }
}

/* End of ARC4 */

/*
 * Key with file invariants.
 */
int key_with_file(char * file)
{
        struct stat statf[1];
        struct stat control[1];

        if (stat(file, statf) < 0)
                return -1;

        /* Turn on stable fields */
        memset(control, 0, sizeof(control));
        control->st_ino = statf->st_ino;
        control->st_dev = statf->st_dev;
        control->st_rdev = statf->st_rdev;
        control->st_uid = statf->st_uid;
        control->st_gid = statf->st_gid;
        control->st_size = statf->st_size;
        control->st_mtime = statf->st_mtime;
        control->st_ctime = statf->st_ctime;
        key(control, sizeof(control));
        return 0;
}

void rmarg(char ** argv, char * arg)
{
        for (; argv && *argv && *argv != arg; argv++);
        for (; argv && *argv; argv++)
                *argv = argv[1];
}

// Modif en long !!!
int chkenv(int argc)
{
        char buff[512];
        unsigned mask, m;
        int l, a, c;
        char * string;
        extern char ** environ;

        mask  = (unsigned)chkenv;
        mask ^= (unsigned)getpid() * ~mask;
        sprintf(buff, "x%x", mask);
        string = getenv(buff);
        l = strlen(buff);
        if (!string) {
                /* 1st */
                sprintf(&buff[l], "=%u %d", mask, argc);
                putenv(strdup(buff));
                return 0;
        }
        c = sscanf(string, "%u %d%c", &m, &a, buff);
        if (c == 2 && m == mask) {
                /* 3rd */
                rmarg(environ, &string[-l - 1]);
                return 1 + (argc - a);
        }
        return -1;
}

char * xsh(int argc, char ** argv)
{
        char * scrpt;
        int ret, i, j;
        char ** varg;

        stte_0();
         key(pswd, pswd_z);
        arc4(msg1, msg1_z);
        arc4(date, date_z);
        if (date[0] && date[0]<time(NULL))
                return msg1;
        arc4(shll, shll_z);
        arc4(inlo, inlo_z);
        arc4(xecc, xecc_z);
        arc4(lsto, lsto_z);
        arc4(tst1, tst1_z);
         key(tst1, tst1_z);
        arc4(chk1, chk1_z);
        if ((chk1_z != tst1_z) || memcmp(tst1, chk1, tst1_z))
                return tst1;
        ret = chkenv(argc);
        arc4(msg2, msg2_z);
        if (ret < 0)
                return msg2;
        varg = (char **)calloc(argc + 10, sizeof(char *));
        if (!varg)
                return 0;
        if (ret) {
                arc4(rlax, rlax_z);
                if (!rlax[0] && key_with_file(shll))
                        return shll;
                arc4(opts, opts_z);
                arc4(text, text_z);
                printf("%s",text);
                return 0;
                arc4(tst2, tst2_z);
                 key(tst2, tst2_z);
                arc4(chk2, chk2_z);
                if ((chk2_z != tst2_z) || memcmp(tst2, chk2, tst2_z))
                        return tst2;
                if (text_z < hide_z) {
                        /* Prepend spaces til a hide_z script size. */
                        scrpt = malloc(hide_z);
                        if (!scrpt)
                                return 0;
                        memset(scrpt, (int) ' ', hide_z);
                        memcpy(&scrpt[hide_z - text_z], text, text_z);
                } else {
                        scrpt = text;   /* Script text */
                }
        } else {                        /* Reexecute */
                if (*xecc) {
                        scrpt = malloc(512);
                        if (!scrpt)
                                return 0;
                        sprintf(scrpt, xecc, argv[0]);
                } else {
                        scrpt = argv[0];
                }
        }
        j = 0;
        varg[j++] = argv[0];            /* My own name at execution */
        if (ret && *opts)
                varg[j++] = opts;       /* Options on 1st line of code */
        if (*inlo)
                varg[j++] = inlo;       /* Option introducing inline code */
        varg[j++] = scrpt;              /* The script itself */
        if (*lsto)
                varg[j++] = lsto;       /* Option meaning last option */
        i = (ret > 1) ? ret : 0;        /* Args numbering correction */
        while (i < argc)
                varg[j++] = argv[i++];  /* Main run-time arguments */
        varg[j] = 0;                    /* NULL terminated array */
        execvp(shll, varg);
        return shll;
}

int main(int argc, char ** argv)
{
        argv[1] = xsh(argc, argv);
        return 1;
}
EOF
}

##########################################
## Starting
echo ":- unshc - The shc decrypter."
echo ":- Version: $VERSION"

if [ $# -lt 1 ]
then
 usage
 exit 0
fi

if [ ! -e $1 ]
then
 echo "!- Error, File $1 not found."
 exit 1
fi

check_binaries

generate_dump

# find out the most called function. (ARC4 =P)
# Update 27/06/2013 : Regexps updated to match new objdump format and retrieve the $CALLADDR from his number of call (bug initial with "sort")
CALLADDR=$($GREP -Eo "call.*[0-9a-f]{7}" $OBJFILE | $GREP -Eo [0-9a-f]{7} | sort | uniq -c | sort | $GREP -Eo "(14).*[0-9a-f]{7}" | $GREP -Eo [0-9a-f]{7})
echo ":- Selected Call: $CALLADDR (arc4)"

##
# find out the parameters used to call CALLADDR.
# The CALLFILE stores pre-calls, moves and pushes. Before call CALLADDR
##
#$GREP -B 3 "call   $CALLADDR" $OBJFILE | $GREP -Ev "(push.*eax)|(--)|(call)|(je)" > $CALLFILE

# Retrieve ordered list of address var and put it to $CALLFILE
$GREP -B 5 "call   $CALLADDR" $OBJFILE | grep -v "$CALLADDR" | grep -Eo "(0x[0-9a-f]{7})" > $CALLADDRFILE
# Retrieve ordered list of size var and append it to $CALFILE
$GREP -B 5 "call   $CALLADDR" $OBJFILE | grep -v "$CALLADDR" | grep -Eo "(0x[0-9a-f]+,)" | grep -Eo "(0x[0-9a-f]+)" | grep -Ev "0x[0-9a-f]{7}" > $CALLSIZEFILE


### echo ":- CALLFILE content "
#cat $CALLFILE


# Retrieve the data used in each parameter.
extract_variables_from_binary


# Now is time to recover the password... funny... password.
extract_password_from_binary

generic_file

gcc -o $TMPBINARY ${TMPBINARY}.c

echo ":- Executing $TMPBINARY"
echo ":- Generating ${BINARY%x}"

$TMPBINARY > ${BINARY%.x}

$SHRED -zu -n 1 $OBJFILE $CALLFILE $CALLADDRFILE $CALLSIZEFILE $STRINGFILE $TMPBINARY ${TMPBINARY}.c
echo ":- All done!"

exit 0