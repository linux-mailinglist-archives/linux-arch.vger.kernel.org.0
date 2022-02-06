Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC04AB085
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiBFQAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 11:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbiBFQAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 11:00:33 -0500
Received: from talisker.home.drummond.us (drummond.us [74.95.14.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19FC043187
        for <linux-arch@vger.kernel.org>; Sun,  6 Feb 2022 08:00:31 -0800 (PST)
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 216FnImH2356038;
        Sun, 6 Feb 2022 07:49:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1644162558;
        bh=aNgt1OQUFA8f0/r3D51wP/eI84n4kfaRWwTm3a27CXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBLnk4LAbv4sGw2NOq3HCzWLaF46Wkffs7++cRNl9bGKKkse1q4NxLObP5U/gZnxz
         q2OqNmFrgPnnS0uYr0Krdi/m/t39A7YWYmVEQLWB1kowtrOnO0iNgM1HA+DvpO11Fw
         kazlNsBZrUDscPme1S9j/ygWRW6KWNcLZ+9hxKNfwTzq2CLFqU2bgMXMAspPIhrlvW
         hWH1A0Bc5RRU/MufBKXhoSNV17NP9eRcJEHv216JyhbtvUdMvdVQwRlfhH1NSZ/bE/
         SzZ5TXqJCCjP9n3Jd7PdT01q+t3+C/tuKdyIdubbia60izTs/pcGrdcSsmLPeIjXxL
         JJPEMsgpAMPFA==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 216FnH8P2356037;
        Sun, 6 Feb 2022 07:49:17 -0800
From:   Walt Drummond <walt@drummond.us>
To:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, hca@linux.ibm.com, deller@gmx.de,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jirislaby@kernel.org, mattst88@gmail.com, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au, paulus@samba.org, rth@twiddle.net,
        dalias@libc.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
        ysato@users.osdn.me
Cc:     linux-kernel@vger.kernel.org, ar@cs.msu.ru, walt@drummond.us,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 3/3] vstatus: Display an informational message when the VSTATUS character is pressed or TIOCSTAT ioctl is called.
Date:   Sun,  6 Feb 2022 07:48:54 -0800
Message-Id: <20220206154856.2355838-4-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206154856.2355838-1-walt@drummond.us>
References: <20220206154856.2355838-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When triggered by pressing the VSTATUS key or calling the TIOCSTAT
ioctl, the n_tty line discipline will display a message on the user's
tty that provides basic information about the system and an
'interesting' process in the current foreground process group, eg:

  load: 0.58  cmd: sleep 744474 [sleeping] 0.36r 0.00u 0.00s 0% 772k

The status message provides:
 - System load average
 - Command name and process id (from the perspective of the session)
 - Scheduler state
 - Total wall-clock run time
 - User space run time
 - System space run time
 - Percentage of on-cpu time
 - Resident set size

The message is only displayed when the tty has the VSTATUS character
set, the local flags ICANON and IEXTEN are enabled and NOKERNINFO is
disabled; it is always displayed when TIOCSTAT is called regardless of
tty settings.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 drivers/tty/Makefile       |   2 +-
 drivers/tty/n_tty.c        |  34 +++++++
 drivers/tty/n_tty_status.c | 181 +++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_io.c       |   2 +-
 include/linux/tty.h        |   5 +
 5 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tty/n_tty_status.c

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index a2bd75fbaaa4..3539d7ab77e5 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
 				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
-				   n_null.o
+				   n_null.o n_tty_status.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 64a058a4c63b..fd70efc333d7 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -80,6 +80,7 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
+#define STATUS_LINE_LEN 160   /* tty status line will truncate at this length */
 
 #undef N_TTY_TRACE
 #ifdef N_TTY_TRACE
@@ -127,6 +128,8 @@ struct n_tty_data {
 	struct mutex output_lock;
 };
 
+static void n_tty_status(struct tty_struct *tty);
+
 #define MASK(x) ((x) & (N_TTY_BUF_SIZE - 1))
 
 static inline size_t read_cnt(struct n_tty_data *ldata)
@@ -1334,6 +1337,11 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			commit_echoes(tty);
 			return;
 		}
+		if (c == STATUS_CHAR(tty) && L_IEXTEN(tty)) {
+			if (!L_NOKERNINFO(tty))
+				n_tty_status(tty);
+			return;
+		}
 		if (c == '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
 				echo_char_raw('\n', ldata);
@@ -1763,6 +1771,7 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 			set_bit(EOF_CHAR(tty), ldata->char_map);
 			set_bit('\n', ldata->char_map);
 			set_bit(EOL_CHAR(tty), ldata->char_map);
+			set_bit(STATUS_CHAR(tty), ldata->char_map);
 			if (L_IEXTEN(tty)) {
 				set_bit(WERASE_CHAR(tty), ldata->char_map);
 				set_bit(LNEXT_CHAR(tty), ldata->char_map);
@@ -2413,6 +2422,26 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 	return nr;
 }
 
+static void n_tty_status(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	char *msg;
+	size_t len;
+
+	msg = kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
+
+	if (ldata->column != 0) {
+		*msg = '\n';
+		len = n_tty_get_status(tty, msg + 1, STATUS_LINE_LEN - 1);
+	} else {
+		len = n_tty_get_status(tty, msg, STATUS_LINE_LEN);
+	}
+
+	do_n_tty_write(tty, NULL, msg, len);
+
+	kfree(msg);
+}
+
 static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
@@ -2430,6 +2459,11 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 			retval = read_cnt(ldata);
 		up_write(&tty->termios_rwsem);
 		return put_user(retval, (unsigned int __user *) arg);
+	case TIOCSTAT:
+		down_read(&tty->termios_rwsem);
+		n_tty_status(tty);
+		up_read(&tty->termios_rwsem);
+		return 0;
 	default:
 		return n_tty_ioctl_helper(tty, file, cmd, arg);
 	}
diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
new file mode 100644
index 000000000000..f0e053651368
--- /dev/null
+++ b/drivers/tty/n_tty_status.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-1.0+
+/*
+ * n_tty_status.c --- implements VSTATUS and TIOCSTAT from BSD
+ *
+ * Display a basic status message containing information about the
+ * foreground process and system load on the users tty, triggered by
+ * the VSTATUS character or TIOCSTAT. Ex,
+ *
+ *   load: 14.11  cmd: tcsh 19623 [running] 185756.62r 88.00u 17.50s 0% 4260k
+ *
+ */
+
+#include <linux/tty.h>
+#include <linux/mm.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+
+/* Convert nanoseconds into centiseconds */
+static inline long ns_to_cs(long l)
+{
+	return l / (NSEC_PER_MSEC * 10);
+
+}
+
+/* We want the pid from the context of session */
+static inline pid_t __get_pid(struct task_struct *tsk, struct tty_struct *tty)
+{
+	struct pid_namespace *ns;
+
+	spin_lock_irq(&tty->ctrl.lock);
+	ns = ns_of_pid(tty->ctrl.session);
+	spin_unlock_irq(&tty->ctrl.lock);
+
+	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns);
+}
+
+/* This is the same odd "bitmap" described in
+ * fs/proc/array.c:get_task_state().  Consistency with standard
+ * implementations of VSTATUS requires a different set of state
+ * names.
+ */
+static const char * const task_state_name_array[] = {
+	"running",
+	"sleeping",
+	"disk sleep",
+	"stopped",
+	"tracing stop",
+	"dead",
+	"zombie",
+	"parked",
+	"idle",
+};
+
+static inline const char *get_task_state_name(struct task_struct *tsk)
+{
+	BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) != ARRAY_SIZE(task_state_name_array));
+	return task_state_name_array[task_state_index(tsk)];
+}
+
+static inline struct task_struct *compare(struct task_struct *new,
+					  struct task_struct *old)
+{
+	unsigned int ostate, nstate;
+
+	if (old == NULL)
+		return new;
+
+	ostate = task_state_index(old);
+	nstate = task_state_index(new);
+
+	if (ostate == nstate) {
+		if (old->start_time > new->start_time)
+			return old;
+		return new;
+	}
+
+	if (ostate < nstate)
+		return old;
+
+	return new;
+}
+
+static struct task_struct *pick_process(struct tty_struct *tty)
+{
+	struct task_struct *new, *winner = NULL;
+
+	read_lock(&tasklist_lock);
+	spin_lock_irq(&tty->ctrl.lock);
+
+	do_each_pid_task(tty->ctrl.pgrp, PIDTYPE_PGID, new) {
+		winner = compare(new, winner);
+	} while_each_pid_task(tty->ctrl.pgrp, PIDTYPE_PGID, new);
+
+	spin_unlock_irq(&tty->ctrl.lock);
+
+	if (winner)
+		winner = get_task_struct(winner);
+
+	read_unlock(&tasklist_lock);
+
+	return winner;
+}
+
+size_t n_tty_get_status(struct tty_struct *tty, char *msg, size_t msglen)
+{
+	struct task_struct *p;
+	struct mm_struct *mm;
+	struct rusage rusage;
+	unsigned long loadavg[3];
+	uint64_t pcpu, cputime, wallclock;
+	struct timespec64 utime, stime, rtime;
+	char tname[TASK_COMM_LEN];
+	unsigned int pid;
+	char *state;
+	unsigned long rss = 0;
+	size_t len = 0;
+
+	get_avenrun(loadavg, FIXED_1/200, 0);
+	len = scnprintf(msg + len, msglen - len, "load: %lu.%02lu  ",
+			LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
+
+	if (tty->ctrl.session == NULL) {
+		len += scnprintf(msg + len, msglen - len,
+				 "not a controlling terminal\n");
+		goto out;
+	}
+
+	if (tty->ctrl.pgrp == NULL) {
+		len += scnprintf(msg + len, msglen - len,
+				 "no foreground process group\n");
+		goto out;
+	}
+
+	/* Note that if p is refcounted */
+	p = pick_process(tty);
+	if (p == NULL) {
+		len += scnprintf(msg + len, msglen - len,
+				 "empty foreground process group\n");
+		goto out;
+	}
+
+	mm = get_task_mm(p);
+	if (mm) {
+		rss = get_mm_rss(mm) * PAGE_SIZE / 1024;
+		mmput(mm);
+	}
+	get_task_comm(tname, p);
+	getrusage(p, RUSAGE_BOTH, &rusage);
+	pid = __get_pid(p, tty);
+	state = (char *) get_task_state_name(p);
+	wallclock = ktime_get_ns() - p->start_time;
+	put_task_struct(p);
+
+	/* After this point, any of the information we have on p might
+	 * become stale.  It's OK if the status message is a little bit
+	 * lossy.
+	 */
+
+	utime.tv_sec = rusage.ru_utime.tv_sec;
+	utime.tv_nsec = rusage.ru_utime.tv_usec * NSEC_PER_USEC;
+	stime.tv_sec = rusage.ru_stime.tv_sec;
+	stime.tv_nsec = rusage.ru_stime.tv_usec * NSEC_PER_USEC;
+	rtime = ns_to_timespec64(wallclock);
+
+	cputime = timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
+	pcpu = div64_u64(cputime * 100, wallclock);
+
+	len += scnprintf(msg + len, msglen - len,
+			 /* task, PID, task state */
+			 "cmd: %s %d [%s] "
+			 /* rtime,    utime,      stime,      %cpu   rss */
+			 "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk\n",
+			 tname,	pid, state,
+			 rtime.tv_sec, ns_to_cs(rtime.tv_nsec),
+			 utime.tv_sec, ns_to_cs(utime.tv_nsec),
+			 stime.tv_sec, ns_to_cs(stime.tv_nsec),
+			 pcpu, rss);
+
+out:
+	return len;
+}
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6616d4a0d41d..f2f4f48ea502 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -125,7 +125,7 @@ struct ktermios tty_std_termios = {	/* for the benefit of tty drivers  */
 	.c_oflag = OPOST | ONLCR,
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
 	.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
-		   ECHOCTL | ECHOKE | IEXTEN,
+		   ECHOCTL | ECHOKE | IEXTEN | NOKERNINFO,
 	.c_cc = INIT_C_CC,
 	.c_ispeed = 38400,
 	.c_ospeed = 38400,
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cbe5d535a69d..2e483708608c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -49,6 +49,7 @@
 #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
 #define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
 #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
+#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
 
 #define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
 #define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
@@ -114,6 +115,7 @@
 #define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
 #define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
+#define L_NOKERNINFO(tty) _L_FLAG((tty), NOKERNINFO)
 
 struct device;
 struct signal_struct;
@@ -389,6 +391,9 @@ extern void __init n_tty_init(void);
 static inline void n_tty_init(void) { }
 #endif
 
+/* n_tty_status.c */
+size_t n_tty_get_status(struct tty_struct *tty, char *msg, size_t msglen);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 extern void tty_audit_exit(void);
-- 
2.30.2

