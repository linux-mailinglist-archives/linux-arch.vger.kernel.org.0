Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B44AB28D
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 23:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbiBFWIo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 17:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiBFWIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 17:08:43 -0500
X-Greylist: delayed 2546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 14:08:40 PST
Received: from mail.cs.msu.ru (mx.cs.msu.ru [188.44.42.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C388C06173B;
        Sun,  6 Feb 2022 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
        s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SxElmGiCpa8m1ttzwycKf6rNtuPLNfb+V62BNUAdLwg=; b=GCGa0r/JMRst3k0T4kvuqMtmnm
        bYqLwcXpy7VwbY0jiAxAhDOfOHj3EizHt9h+5wU/l3FE4VTHo3G45rP9rgU7oAIWXezqr1svJh3no
        6E+4c9JW1vf/TBg2U9VoE1UoBToIbpJLf78cGsC7AWJ8lS6szf+eON7wWDr36Hq5B4MgJFcQs+Gk3
        uohu2Yvsa/Ail1L87AIuAU+gaXmyph2G0PRKUKNTNPEyFDE2LOOLcqnF75CWVfPcdRjUpyIVyy4bv
        OImXUVa/a3rD0QPMZIalkgxbgZhvi/VmILcpoxcxqVsTxyH6Stk9bDKZaf+7EXY0QhyZyHAD3BqQ6
        3WQJSQdQ==;
Received: from [37.204.119.143] (port=42158 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1nGp27-000LqO-MT; Mon, 07 Feb 2022 00:25:21 +0300
Date:   Mon, 7 Feb 2022 00:25:12 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Walt Drummond <walt@drummond.us>
Cc:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, hca@linux.ibm.com, deller@gmx.de,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jirislaby@kernel.org, mattst88@gmail.com, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au, paulus@samba.org, rth@twiddle.net,
        dalias@libc.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
        ysato@users.osdn.me, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Message-ID: <YgA8uIVSX5WSC6Wr@cello>
References: <20220206154856.2355838-1-walt@drummond.us>
 <20220206154856.2355838-4-walt@drummond.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cO02Fnj5BNdGOJp4"
Content-Disposition: inline
In-Reply-To: <20220206154856.2355838-4-walt@drummond.us>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 3/3] vstatus: Display an informational message when
 the VSTATUS character is pressed or TIOCSTAT ioctl is called.
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--cO02Fnj5BNdGOJp4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2022 at 07:48:54AM -0800, Walt Drummond wrote:
> When triggered by pressing the VSTATUS key or calling the TIOCSTAT
> ioctl, the n_tty line discipline will display a message on the user's
> tty that provides basic information about the system and an
> 'interesting' process in the current foreground process group, eg:
>=20
>   load: 0.58  cmd: sleep 744474 [sleeping] 0.36r 0.00u 0.00s 0% 772k
>=20
> The status message provides:
>  - System load average
>  - Command name and process id (from the perspective of the session)
>  - Scheduler state
>  - Total wall-clock run time
>  - User space run time
>  - System space run time
>  - Percentage of on-cpu time
>  - Resident set size
>=20
> The message is only displayed when the tty has the VSTATUS character
> set, the local flags ICANON and IEXTEN are enabled and NOKERNINFO is
> disabled; it is always displayed when TIOCSTAT is called regardless of
> tty settings.
>=20
> Signed-off-by: Walt Drummond <walt@drummond.us>
> ---
>  drivers/tty/Makefile       |   2 +-
>  drivers/tty/n_tty.c        |  34 +++++++
>  drivers/tty/n_tty_status.c | 181 +++++++++++++++++++++++++++++++++++++
>  drivers/tty/tty_io.c       |   2 +-
>  include/linux/tty.h        |   5 +
>  5 files changed, 222 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/tty/n_tty_status.c
>=20
> <...>
> @@ -2430,6 +2459,11 @@ static int n_tty_ioctl(struct tty_struct *tty, str=
uct file *file,
>  			retval =3D read_cnt(ldata);
>  		up_write(&tty->termios_rwsem);
>  		return put_user(retval, (unsigned int __user *) arg);
> +	case TIOCSTAT:

Perhaps we want to guard this (example pseudocode follows):

		if (*our ldisc is not n_tty*)
			return an error like -ENOTTY;

=2E..since kerninfo is useless for non-UI ttys, e. g. serial device
drivers, and this ioctl could mess them up if this code path can be
taken. (I have not verified this kind of breakage is possible.) Please
see the complete rationale below, this paragraph is an illustrational
note for it.

> +		down_read(&tty->termios_rwsem);
> +		n_tty_status(tty);
> +		up_read(&tty->termios_rwsem);
> +		return 0;
>  	default:
>  		return n_tty_ioctl_helper(tty, file, cmd, arg);
>  	}
> diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
> new file mode 100644
> index 000000000000..f0e053651368
> --- /dev/null
> +++ b/drivers/tty/n_tty_status.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-1.0+
> +/*
> + * n_tty_status.c --- implements VSTATUS and TIOCSTAT from BSD
> + *
> + * Display a basic status message containing information about the
> + * foreground process and system load on the users tty, triggered by
> + * the VSTATUS character or TIOCSTAT. Ex,
> + *
> + *   load: 14.11  cmd: tcsh 19623 [running] 185756.62r 88.00u 17.50s 0% =
4260k
> + *
> + */
> +
> +#include <linux/tty.h>
> +#include <linux/mm.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/sched/mm.h>
> +
> +/* Convert nanoseconds into centiseconds */
> +static inline long ns_to_cs(long l)
> +{
> +	return l / (NSEC_PER_MSEC * 10);
> +
> +}
> +
> +/* We want the pid from the context of session */
> +static inline pid_t __get_pid(struct task_struct *tsk, struct tty_struct=
 *tty)
> +{
> +	struct pid_namespace *ns;
> +
> +	spin_lock_irq(&tty->ctrl.lock);
> +	ns =3D ns_of_pid(tty->ctrl.session);
> +	spin_unlock_irq(&tty->ctrl.lock);
> +
> +	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns);
> +}
> +
> +/* This is the same odd "bitmap" described in
> + * fs/proc/array.c:get_task_state().  Consistency with standard
> + * implementations of VSTATUS requires a different set of state
> + * names.

As far as I can remember, VSTATUS is not subject to any standard, so no
implementation is *standard* by any means. The 2 most popular libre &
open source BSD derivatives implement the VSTATUS message with different
details (e. g. OpenBSD does not check for column 0, FreeBSD does) and
use different message formats.
We are not obliged to copy the message format or the task state names
=66rom another system (which most likely uses a different set of task
states, or might change its task state set independently of Linux),
especially since the message is not part of any API and is not even
readable by processes who read or write on the terminal.

(If the terminal is a pty, then there is a user process which has
possession of an fd to the pty master, but anyway it can not =E2=80=94 and
should not =E2=80=94 distinguish between terminal output produced by proces=
ses
or by the ldisc.)

> + */
> +static const char * const task_state_name_array[] =3D {
> +	"running",
> +	"sleeping",
> +	"disk sleep",
> +	"stopped",
> +	"tracing stop",
> +	"dead",
> +	"zombie",
> +	"parked",
> +	"idle",
> +};
> +
> +static inline const char *get_task_state_name(struct task_struct *tsk)
> +{
> +	BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) !=3D ARRAY_SIZE(task_state_name=
_array));
> +	return task_state_name_array[task_state_index(tsk)];
> +}
> +
> <...>
> +size_t n_tty_get_status(struct tty_struct *tty, char *msg, size_t msglen)
> +{
> +	struct task_struct *p;
> +	struct mm_struct *mm;
> +	struct rusage rusage;
> +	unsigned long loadavg[3];
> +	uint64_t pcpu, cputime, wallclock;
> +	struct timespec64 utime, stime, rtime;
> +	char tname[TASK_COMM_LEN];
> +	unsigned int pid;
> +	char *state;
> +	unsigned long rss =3D 0;
> +	size_t len =3D 0;
> +
> +	get_avenrun(loadavg, FIXED_1/200, 0);
> +	len =3D scnprintf(msg + len, msglen - len, "load: %lu.%02lu  ",
> +			LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> +
> +	if (tty->ctrl.session =3D=3D NULL) {
> +		len +=3D scnprintf(msg + len, msglen - len,
> +				 "not a controlling terminal\n");
> +		goto out;
> +	}
> +
> +	if (tty->ctrl.pgrp =3D=3D NULL) {
> +		len +=3D scnprintf(msg + len, msglen - len,
> +				 "no foreground process group\n");
> +		goto out;
> +	}
> +
> +	/* Note that if p is refcounted */
> +	p =3D pick_process(tty);
> +	if (p =3D=3D NULL) {
> +		len +=3D scnprintf(msg + len, msglen - len,
> +				 "empty foreground process group\n");
> +		goto out;
> +	}
> +
> +	mm =3D get_task_mm(p);
> +	if (mm) {
> +		rss =3D get_mm_rss(mm) * PAGE_SIZE / 1024;
> +		mmput(mm);
> +	}
> +	get_task_comm(tname, p);
> +	getrusage(p, RUSAGE_BOTH, &rusage);
> +	pid =3D __get_pid(p, tty);
> +	state =3D (char *) get_task_state_name(p);
> +	wallclock =3D ktime_get_ns() - p->start_time;
> +	put_task_struct(p);
> +
> +	/* After this point, any of the information we have on p might
> +	 * become stale.  It's OK if the status message is a little bit
> +	 * lossy.
> +	 */

=2E..By the moment the user sees the status message, the presented
information is a bit stale anyway, but still relevant. :)

> +
> +	utime.tv_sec =3D rusage.ru_utime.tv_sec;
> +	utime.tv_nsec =3D rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> +	stime.tv_sec =3D rusage.ru_stime.tv_sec;
> +	stime.tv_nsec =3D rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> +	rtime =3D ns_to_timespec64(wallclock);
> +
> +	cputime =3D timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> +	pcpu =3D div64_u64(cputime * 100, wallclock);

Other reviewers have mentioned that this number does not make too much
sense, as we can see the dividend and the divisor in the message. It
would make more sense to display CPU consumption by the process in a
recent enough time window, or some other "hogginess" estimate, but I
doubt this information is available.

> +
> +	len +=3D scnprintf(msg + len, msglen - len,
> +			 /* task, PID, task state */
> +			 "cmd: %s %d [%s] "
> +			 /* rtime,    utime,      stime,      %cpu   rss */
> +			 "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk\n",
> +			 tname,	pid, state,
> +			 rtime.tv_sec, ns_to_cs(rtime.tv_nsec),
> +			 utime.tv_sec, ns_to_cs(utime.tv_nsec),
> +			 stime.tv_sec, ns_to_cs(stime.tv_nsec),
> +			 pcpu, rss);
> +
> +out:
> +	return len;
> +}
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 6616d4a0d41d..f2f4f48ea502 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -125,7 +125,7 @@ struct ktermios tty_std_termios =3D {	/* for the bene=
fit of tty drivers  */
>  	.c_oflag =3D OPOST | ONLCR,
>  	.c_cflag =3D B38400 | CS8 | CREAD | HUPCL,
>  	.c_lflag =3D ISIG | ICANON | ECHO | ECHOE | ECHOK |
> -		   ECHOCTL | ECHOKE | IEXTEN,
> +		   ECHOCTL | ECHOKE | IEXTEN | NOKERNINFO,

Does this mean that nokerninfo is on by default? Do we have a reason to
do that?

As of this patch we require icanon and iexten to be set for the message
to be composed and printed. An experiment shows PTY encapsulation
programs like openssh turn off both those flags on the tty they run on
before they take control (contrary to what has been said in LWN), so
they are unimpacted.

The termios(3) page from man-pages states:
   Raw mode
       cfmakeraw() sets the terminal to something like the "raw"  mode
       of  the old Version 7 terminal driver: input is available char=E2=80=
=90
       acter by character, echoing is disabled, and all  special  pro=E2=80=
=90
       cessing  of  terminal  input and output characters is disabled.
       The terminal attributes are set as follows:

           termios_p->c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                           | INLCR | IGNCR | ICRNL | IXON);
           termios_p->c_oflag &=3D ~OPOST;
           termios_p->c_lflag &=3D ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN=
);
           termios_p->c_cflag &=3D ~(CSIZE | PARENB);
           termios_p->c_cflag |=3D CS8;

So any program which uses this API effectively turns off kerninfo as
implemented here.

There are 2 ways n_tty_status() can be called as of this patch: either
=66rom inside n_tty or via TIOCSTAT. The first path can't be taken on ttys
whose ldisc is not N_TTY, the second path we can fix as proposed in the
comment to the TIOCSTAT hunk if needed. IOW, we can make this safe for
device drivers.

Given all this, is there any other reason to enable nokerninfo (i. e.
disable status message) by default?

>  	.c_cc =3D INIT_C_CC,
>  	.c_ispeed =3D 38400,
>  	.c_ospeed =3D 38400,
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index cbe5d535a69d..2e483708608c 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -49,6 +49,7 @@
>  #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
>  #define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
>  #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
> +#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
> =20
>  #define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
>  #define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
> @@ -114,6 +115,7 @@
>  #define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
>  #define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
>  #define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
> +#define L_NOKERNINFO(tty) _L_FLAG((tty), NOKERNINFO)
> =20
>  struct device;
>  struct signal_struct;
> @@ -389,6 +391,9 @@ extern void __init n_tty_init(void);
>  static inline void n_tty_init(void) { }
>  #endif
> =20
> +/* n_tty_status.c */
> +size_t n_tty_get_status(struct tty_struct *tty, char *msg, size_t msglen=
);
> +
>  /* tty_audit.c */
>  #ifdef CONFIG_AUDIT
>  extern void tty_audit_exit(void);
> --=20
> 2.30.2

Thanks!

--cO02Fnj5BNdGOJp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAmIAPLEACgkQ9dQjyAYL
01Ag7RAAmK3xEYPAUMsDOh6NTQA+bHGadAkr7e+kP0tXcw62AxX2RuQbcnsNTacC
9qVRPO/Lciq2gZn2RbnVBnopWk3DVytbUyec2+gda6HBaAWeepNvJ1+rhBf6AvDX
yeT08qSWN9G01/2ttjpcHmzf6t792yKFdl1fvFwq0B3urw+xF7G7ggzzwSACZxpG
mpxil/UrtdWuCta9dm4/mA/2UaxVmcqNa2p1vs1zMVJ4cQG/Ldg82bOj1gGQV1Xo
kGsRbZLATp3gBOA1nr9uAfz1UkSNJ3wslU0GivZcN2fxPtyECDq0WTzoeyfVKC2d
bNToXaYb1mpFvmHXZQq1PlMmd8ZP13nNhnrCzk3ZA5zGohH6K00IwTQiIqtLBiaK
dDkZtdCkWkJbxU3VgUaLrc61PXMyUcVv8Yaos44OcLKOouibrlKEXjunx2B5k1UP
1damdqoB+9UL4LuujG4Kk77rrU5w59uB9BvOOdqeDMv2S0cZkc7MpY7kNuhBaeJf
vlM1wQ/I3fr1hEq2IOCEeIbTtUbwiJ1e82lt4lrORYIg05M0MhQbJyloqNh//ZTn
X6oufrmy7jWl7SNUi8xvmxb1QI4zGO2BZepUtBbFRgSy4GYdoUNlbpZ6PnV9vN8/
/QZlbMo4Qv8WdD+MTEiYK4EM9oTYkBiCQPvuda9RO5EcOt4I1zs=
=9D2m
-----END PGP SIGNATURE-----

--cO02Fnj5BNdGOJp4--
