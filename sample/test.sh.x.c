#if 0
	shc Version 3.8.9b, Generic Script Compiler
	Copyright (c) 1994-2015 Francisco Rosales <frosal@fi.upm.es>

	shc-3.8.9b/shc -v -r -f test.sh 
#endif

static  char data [] = 
#define      shll_z	10
#define      shll	((&data[1]))
	"\065\114\120\362\275\043\315\204\341\152\342\071"
#define      inlo_z	3
#define      inlo	((&data[12]))
	"\317\070\244"
#define      chk2_z	19
#define      chk2	((&data[17]))
	"\211\020\004\223\276\376\145\315\146\243\154\064\367\351\032\163"
	"\066\023\330\070\065\141\241\266\052"
#define      date_z	1
#define      date	((&data[40]))
	"\113"
#define      tst1_z	22
#define      tst1	((&data[43]))
	"\352\006\323\075\236\251\031\362\026\105\170\073\270\340\236\321"
	"\361\276\300\060\361\300\126\063\304"
#define      chk1_z	22
#define      chk1	((&data[67]))
	"\144\210\246\134\113\175\127\316\223\201\247\122\004\353\277\331"
	"\206\324\154\050\005\334\270\174\034\315\031\121"
#define      pswd_z	256
#define      pswd	((&data[118]))
	"\237\130\076\211\342\117\353\203\005\025\263\347\137\063\121\226"
	"\036\127\133\261\221\101\026\015\173\332\174\345\153\012\115\253"
	"\103\334\261\363\241\172\263\325\116\036\214\131\045\201\141\267"
	"\004\167\242\156\367\021\133\163\353\327\130\127\342\245\002\046"
	"\202\264\031\044\056\315\371\175\354\206\326\021\010\067\311\014"
	"\257\154\172\247\175\326\032\151\256\163\300\221\030\303\267\233"
	"\167\321\277\245\236\270\042\212\077\370\234\107\060\146\124\340"
	"\322\317\207\117\245\242\270\124\026\170\345\057\074\234\312\263"
	"\155\211\130\014\102\173\226\201\163\063\311\244\231\035\204\153"
	"\354\014\272\222\257\163\347\305\354\314\364\050\151\276\334\327"
	"\110\064\343\212\260\172\013\044\255\324\310\106\362\115\262\336"
	"\132\154\160\012\340\127\317\314\044\304\365\216\203\321\145\313"
	"\006\110\125\266\303\141\332\160\066\243\267\050\361\151\007\114"
	"\326\167\126\266\317\045\203\364\352\170\202\155\111\350\071\120"
	"\061\217\006\364\360\341\145\047\205\034\117\166\206\127\302\134"
	"\317\030\023\236\076\227\223\051\017\026\227\131\376\320\251\057"
	"\137\260\043\120\222\210\170\027\245\310\216\053\037\121\210\356"
	"\151\234\215\250\063\040\321\103\135\343\047\257\352\210\145\212"
	"\341\243\024\304\362\000\107\367\025\373\337\165\057\060\014\115"
	"\210\147\377\031\250\025\047\006\371\116\265\344\327\032\157\271"
	"\275\203\175\260\203\305"
#define      msg2_z	19
#define      msg2	((&data[422]))
	"\207\016\167\162\274\001\336\166\267\057\376\165\113\050\267\102"
	"\146\303\120\373\360\357\267\032"
#define      xecc_z	15
#define      xecc	((&data[444]))
	"\241\063\111\206\077\203\267\341\176\372\262\111\105\103\152\074"
	"\131"
#define      lsto_z	1
#define      lsto	((&data[461]))
	"\052"
#define      rlax_z	1
#define      rlax	((&data[462]))
	"\332"
#define      tst2_z	19
#define      tst2	((&data[463]))
	"\005\352\172\011\155\127\011\215\120\032\013\324\131\160\131\125"
	"\373\326\007\000\236\140"
#define      opts_z	1
#define      opts	((&data[485]))
	"\124"
#define      text_z	194
#define      text	((&data[517]))
	"\026\077\143\235\116\122\125\150\220\225\353\315\356\026\037\156"
	"\107\152\075\056\232\344\056\071\104\355\133\042\133\001\304\274"
	"\337\100\355\210\067\137\036\114\002\343\216\110\246\307\020\213"
	"\331\002\304\317\017\246\165\264\052\174\376\301\172\242\211\173"
	"\073\130\135\267\126\374\271\214\142\101\206\176\333\044\140\031"
	"\315\243\246\201\322\230\000\115\327\002\262\072\051\355\116\375"
	"\167\312\161\010\217\305\253\317\204\260\343\333\310\170\024\104"
	"\141\332\233\041\041\120\203\047\053\205\374\361\005\141\251\016"
	"\357\162\311\364\162\227\134\325\176\311\127\155\000\271\360\013"
	"\172\276\051\121\336\225\017\304\153\237\155\365\253\302\364\244"
	"\214\030\370\204\167\322\123\004\172\206\005\052\313\350\141\304"
	"\106\015\013\210\071\377\160\140\232\240\076\217\155\364\076\364"
	"\206\021\373\204\076\001\237\066\341\062\360\376\023\260\244\275"
	"\206\037\247\263\245\210\337\157\201\227\212\057\067\212\371\373"
	"\244\162\101\047\017\217\172\144\367\013\372\343\330\350\371\367"
	"\126\101\142\224\157\374\171\236\066\276\213\222\340\347\223\245"
#define      msg1_z	42
#define      msg1	((&data[751]))
	"\151\143\107\315\133\122\310\077\053\226\267\011\230\101\155\343"
	"\113\105\220\134\017\040\340\362\241\206\040\054\043\106\077\204"
	"\041\365\030\236\242\300\034\047\332\156\061\231\061\156\317\350"
	"\011\306\346\260\070\042\007\171\205\233\350"/* End of data[] */;
#define      hide_z	4096
#define DEBUGEXEC	0	/* Define as 1 to debug execvp calls */
#define TRACEABLE	0	/* Define as 1 to enable ptrace the executable */

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

#if DEBUGEXEC
void debugexec(char * sh11, int argc, char ** argv)
{
	int i;
	fprintf(stderr, "shll=%s\n", sh11 ? sh11 : "<null>");
	fprintf(stderr, "argc=%d\n", argc);
	if (!argv) {
		fprintf(stderr, "argv=<null>\n");
	} else { 
		for (i = 0; i <= argc ; i++)
			fprintf(stderr, "argv[%d]=%.60s\n", i, argv[i] ? argv[i] : "<null>");
	}
}
#endif /* DEBUGEXEC */

void rmarg(char ** argv, char * arg)
{
	for (; argv && *argv && *argv != arg; argv++);
	for (; argv && *argv; argv++)
		*argv = argv[1];
}

int chkenv(int argc)
{
	char buff[512];
	unsigned long mask, m;
	int l, a, c;
	char * string;
	extern char ** environ;

	mask  = (unsigned long)&chkenv;
	mask ^= (unsigned long)getpid() * ~mask;
	sprintf(buff, "x%lx", mask);
	string = getenv(buff);
#if DEBUGEXEC
	fprintf(stderr, "getenv(%s)=%s\n", buff, string ? string : "<null>");
#endif
	l = strlen(buff);
	if (!string) {
		/* 1st */
		sprintf(&buff[l], "=%lu %d", mask, argc);
		putenv(strdup(buff));
		return 0;
	}
	c = sscanf(string, "%lu %d%c", &m, &a, buff);
	if (c == 2 && m == mask) {
		/* 3rd */
		rmarg(environ, &string[-l - 1]);
		return 1 + (argc - a);
	}
	return -1;
}

#if !TRACEABLE

#define _LINUX_SOURCE_COMPAT
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

#if !defined(PTRACE_ATTACH) && defined(PT_ATTACH)
#	define PTRACE_ATTACH	PT_ATTACH
#endif
void untraceable(char * argv0)
{
	char proc[80];
	int pid, mine;

	switch(pid = fork()) {
	case  0:
		pid = getppid();
		/* For problematic SunOS ptrace */
#if defined(__FreeBSD__)
		sprintf(proc, "/proc/%d/mem", (int)pid);
#else
		sprintf(proc, "/proc/%d/as",  (int)pid);
#endif
		close(0);
		mine = !open(proc, O_RDWR|O_EXCL);
		if (!mine && errno != EBUSY)
			mine = !ptrace(PTRACE_ATTACH, pid, 0, 0);
		if (mine) {
			kill(pid, SIGCONT);
		} else {
			perror(argv0);
			kill(pid, SIGKILL);
		}
		_exit(mine);
	case -1:
		break;
	default:
		if (pid == waitpid(pid, 0, 0))
			return;
	}
	perror(argv0);
	_exit(1);
}
#endif /* !TRACEABLE */

char * xsh(int argc, char ** argv)
{
	char * scrpt;
	int ret, i, j;
	char ** varg;
	char * me = argv[0];

	stte_0();
	 key(pswd, pswd_z);
	arc4(msg1, msg1_z);
	arc4(date, date_z);
	if (date[0] && (atoll(date)<time(NULL)))
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
		arc4(tst2, tst2_z);
		 key(tst2, tst2_z);
		arc4(chk2, chk2_z);
		if ((chk2_z != tst2_z) || memcmp(tst2, chk2, tst2_z))
			return tst2;
		/* Prepend hide_z spaces to script text to hide it. */
		scrpt = malloc(hide_z + text_z);
		if (!scrpt)
			return 0;
		memset(scrpt, (int) ' ', hide_z);
		memcpy(&scrpt[hide_z], text, text_z);
	} else {			/* Reexecute */
		if (*xecc) {
			scrpt = malloc(512);
			if (!scrpt)
				return 0;
			sprintf(scrpt, xecc, me);
		} else {
			scrpt = me;
		}
	}
	j = 0;
	varg[j++] = argv[0];		/* My own name at execution */
	if (ret && *opts)
		varg[j++] = opts;	/* Options on 1st line of code */
	if (*inlo)
		varg[j++] = inlo;	/* Option introducing inline code */
	varg[j++] = scrpt;		/* The script itself */
	if (*lsto)
		varg[j++] = lsto;	/* Option meaning last option */
	i = (ret > 1) ? ret : 0;	/* Args numbering correction */
	while (i < argc)
		varg[j++] = argv[i++];	/* Main run-time arguments */
	varg[j] = 0;			/* NULL terminated array */
#if DEBUGEXEC
	debugexec(shll, j, varg);
#endif
	execvp(shll, varg);
	return shll;
}

int main(int argc, char ** argv)
{
#if DEBUGEXEC
	debugexec("main", argc, argv);
#endif
#if !TRACEABLE
	untraceable(argv[0]);
#endif
	argv[1] = xsh(argc, argv);
	fprintf(stderr, "%s%s%s: %s\n", argv[0],
		errno ? ": " : "",
		errno ? strerror(errno) : "",
		argv[1] ? argv[1] : "<null>"
	);
	return 1;
}
