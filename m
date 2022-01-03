Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7548387B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiACVeE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:04 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45908 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiACVd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:56668)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxn-00ET1a-AZ; Mon, 03 Jan 2022 14:33:55 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxl-006zvm-W6; Mon, 03 Jan 2022 14:33:54 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:05 -0600
Message-Id: <20220103213312.9144-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxl-006zvm-W6;;;mid=<20220103213312.9144-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CoLSF+5aKtgflxHOhPtbt/lqg7uqig4s=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 723 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (1.8%), b_tie_ro: 11 (1.5%), parse: 1.83
        (0.3%), extract_message_metadata: 20 (2.8%), get_uri_detail_list: 5
        (0.7%), tests_pri_-1000: 6 (0.9%), tests_pri_-950: 1.82 (0.3%),
        tests_pri_-900: 1.44 (0.2%), tests_pri_-90: 222 (30.8%), check_bayes:
        203 (28.2%), b_tokenize: 16 (2.2%), b_tok_get_all: 11 (1.5%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 169 (23.3%), b_finish: 1.32
        (0.2%), tests_pri_0: 436 (60.4%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 4.1 (0.6%), poll_dns_idle: 1.93 (0.3%), tests_pri_10:
        4.0 (0.6%), tests_pri_500: 11 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/17] ptrace: Return the signal to continue with from ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The signal a task should continue with after a ptrace stop is
inconsistently read, cleared, and sent.  Solve this by reading and
clearing the signal to be sent in ptrace_stop.

In an ideal world everything except ptrace_signal would share a common
implementation of continuing with the signal, so ptracers could count
on the signal they ask to continue with actually being delivered.  For
now retain bug compatibility and just return with the signal number
the ptracer requested the code continue with.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h    |  2 +-
 include/linux/tracehook.h | 10 +++++-----
 kernel/signal.c           | 31 ++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 06f27736c6f8..323c9950e705 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_request(struct task_struct *child, long request,
 			  unsigned long addr, unsigned long data);
-extern void ptrace_notify(int exit_code, unsigned long message);
+extern int ptrace_notify(int exit_code, unsigned long message);
 extern void __ptrace_link(struct task_struct *child,
 			  struct task_struct *new_parent,
 			  const struct cred *ptracer_cred);
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 5e60af8a11fc..2fd0bfe866c0 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -57,21 +57,21 @@ struct linux_binprm;
 static inline int ptrace_report_syscall(unsigned long message)
 {
 	int ptrace = current->ptrace;
+	int signr;
 
 	if (!(ptrace & PT_PTRACED))
 		return 0;
 
-	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0), message);
+	signr = ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0),
+			      message);
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
 	 * stopping signal is not SIGTRAP.  -brl
 	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	if (signr)
+		send_sig(signr, current, 1);
 
 	return fatal_signal_pending(current);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 75bb062d8534..9903ff12e581 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2194,15 +2194,17 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * That makes it a way to test a stopped process for
  * being ptrace-stopped vs being job-control-stopped.
  *
- * If we actually decide not to stop at all because the tracer
- * is gone, we keep current->exit_code unless clear_code.
+ * Returns the signal the ptracer requested the code resume
+ * with.  If the code did not stop because the tracer is gone,
+ * the stop signal remains unchanged unless clear_code.
  */
-static void ptrace_stop(int exit_code, int why, int clear_code,
+static int ptrace_stop(int exit_code, int why, int clear_code,
 			unsigned long message, kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
+	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2311,8 +2313,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 
 		/* tasklist protects us from ptrace_freeze_traced() */
 		__set_current_state(TASK_RUNNING);
+		read_code = false;
 		if (clear_code)
-			current->exit_code = 0;
+			exit_code = 0;
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2322,8 +2325,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
+	if (read_code) exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
+	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
@@ -2334,9 +2339,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
 	recalc_sigpending_tsk(current);
+	return exit_code;
 }
 
-static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
+static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
 {
 	kernel_siginfo_t info;
 
@@ -2347,18 +2353,21 @@ static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long me
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	ptrace_stop(exit_code, why, 1, message, &info);
+	return ptrace_stop(exit_code, why, 1, message, &info);
 }
 
-void ptrace_notify(int exit_code, unsigned long message)
+int ptrace_notify(int exit_code, unsigned long message)
 {
+	int signr;
+
 	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
 	if (unlikely(current->task_works))
 		task_work_run();
 
 	spin_lock_irq(&current->sighand->siglock);
-	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, message);
+	signr = ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, message);
 	spin_unlock_irq(&current->sighand->siglock);
+	return signr;
 }
 
 /**
@@ -2517,7 +2526,6 @@ static void do_jobctl_trap(void)
 	} else {
 		WARN_ON_ONCE(!signr);
 		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
-		current->exit_code = 0;
 	}
 }
 
@@ -2570,15 +2578,12 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
+	signr = ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
-	signr = current->exit_code;
 	if (signr == 0)
 		return signr;
 
-	current->exit_code = 0;
-
 	/*
 	 * Update the siginfo structure if the signal has
 	 * changed.  If the debugger wanted something
-- 
2.29.2

