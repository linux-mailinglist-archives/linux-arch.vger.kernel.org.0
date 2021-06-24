Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3C3B366D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhFXTC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 15:02:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58958 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXTC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:02:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:46860)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUa7-008e3h-Lr; Thu, 24 Jun 2021 13:00:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47032 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUa2-003RMg-UB; Thu, 24 Jun 2021 13:00:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
Date:   Thu, 24 Jun 2021 13:59:55 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87r1gr6qc4.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUa2-003RMg-UB;;;mid=<87r1gr6qc4.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OKdfvLvmvM7QU4EEXK+6v9XD9oN13GRc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2135 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (0.6%), b_tie_ro: 10 (0.5%), parse: 2.2 (0.1%),
         extract_message_metadata: 19 (0.9%), get_uri_detail_list: 5 (0.2%),
        tests_pri_-1000: 16 (0.8%), tests_pri_-950: 1.71 (0.1%),
        tests_pri_-900: 1.72 (0.1%), tests_pri_-90: 281 (13.1%), check_bayes:
        279 (13.1%), b_tokenize: 27 (1.3%), b_tok_get_all: 21 (1.0%),
        b_comp_prob: 5 (0.3%), b_tok_touch_all: 221 (10.3%), b_finish: 0.98
        (0.0%), tests_pri_0: 1781 (83.4%), check_dkim_signature: 0.75 (0.0%),
        check_dkim_adsp: 2.5 (0.1%), poll_dns_idle: 0.57 (0.0%), tests_pri_10:
        3.1 (0.1%), tests_pri_500: 12 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/9] signal/seccomp: Refactor seccomp signal and coredump generation
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Factor out force_sig_seccomp from the seccomp signal generation and
place it in kernel/signal.c.  The function force_sig_seccomp takes a
paramter force_coredump to indicate that the sigaction field should be
reset to SIGDFL so that a coredump will be generated when the signal
is delivered.

force_sig_seccomp is then used to replace both seccomp_send_sigsys
and seccomp_init_siginfo.

force_sig_info_to_task gains an extra parameter to force using
the default signal action.

With this change seccomp is no longer a special case and there
becomes exactly one place do_coredump is called from.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/seccomp.c             | 43 ++++++++----------------------------
 kernel/signal.c              | 30 +++++++++++++++++++++----
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f4278fa21fe..774be5d3ac3e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -329,6 +329,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey);
 int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
 
 int force_sig_ptrace_errno_trap(int errno, void __user *addr);
+int force_sig_seccomp(int syscall, int reason, bool force_coredump);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 6ecd3f3a52b5..3e06d4628d98 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -920,30 +920,6 @@ void get_seccomp_filter(struct task_struct *tsk)
 	refcount_inc(&orig->users);
 }
 
-static void seccomp_init_siginfo(kernel_siginfo_t *info, int syscall, int reason)
-{
-	clear_siginfo(info);
-	info->si_signo = SIGSYS;
-	info->si_code = SYS_SECCOMP;
-	info->si_call_addr = (void __user *)KSTK_EIP(current);
-	info->si_errno = reason;
-	info->si_arch = syscall_get_arch(current);
-	info->si_syscall = syscall;
-}
-
-/**
- * seccomp_send_sigsys - signals the task to allow in-process syscall emulation
- * @syscall: syscall number to send to userland
- * @reason: filter-supplied reason code to send to userland (via si_errno)
- *
- * Forces a SIGSYS with a code of SYS_SECCOMP and related sigsys info.
- */
-static void seccomp_send_sigsys(int syscall, int reason)
-{
-	struct kernel_siginfo info;
-	seccomp_init_siginfo(&info, syscall, reason);
-	force_sig_info(&info);
-}
 #endif	/* CONFIG_SECCOMP_FILTER */
 
 /* For use with seccomp_actions_logged */
@@ -1195,7 +1171,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		/* Show the handler the original registers. */
 		syscall_rollback(current, current_pt_regs());
 		/* Let the filter pass back 16 bits of data. */
-		seccomp_send_sigsys(this_syscall, data);
+		force_sig_seccomp(this_syscall, data, false);
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
@@ -1266,18 +1242,17 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
 		    get_nr_threads(current) == 1) {
-			kernel_siginfo_t info;
-
 			/* Show the original registers in the dump. */
 			syscall_rollback(current, current_pt_regs());
-			/* Trigger a manual coredump since do_exit skips it. */
-			seccomp_init_siginfo(&info, this_syscall, data);
-			do_coredump(&info);
+			/* Trigger a coredump with SIGSYS */
+			force_sig_seccomp(this_syscall, data, true);
+		} else {
+			if (action == SECCOMP_RET_KILL_THREAD)
+				do_exit(SIGSYS);
+			else
+				do_group_exit(SIGSYS);
 		}
-		if (action == SECCOMP_RET_KILL_THREAD)
-			do_exit(SIGSYS);
-		else
-			do_group_exit(SIGSYS);
+		return -1;
 	}
 
 	unreachable();
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..da37cc4515f2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -54,6 +54,7 @@
 #include <asm/unistd.h>
 #include <asm/siginfo.h>
 #include <asm/cacheflush.h>
+#include <asm/syscall.h>	/* for syscall_get_* */
 
 /*
  * SLAB caches for signal bits.
@@ -1349,7 +1350,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
  * that is why we also clear SIGNAL_UNKILLABLE.
  */
 static int
-force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
+force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
 {
 	unsigned long int flags;
 	int ret, blocked, ignored;
@@ -1360,7 +1361,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
-	if (blocked || ignored) {
+	if (blocked || ignored || sigdfl) {
 		action->sa.sa_handler = SIG_DFL;
 		if (blocked) {
 			sigdelset(&t->blocked, sig);
@@ -1381,7 +1382,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 
 int force_sig_info(struct kernel_siginfo *info)
 {
-	return force_sig_info_to_task(info, current);
+	return force_sig_info_to_task(info, current, false);
 }
 
 /*
@@ -1712,7 +1713,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_flags = flags;
 	info.si_isr = isr;
 #endif
-	return force_sig_info_to_task(&info, t);
+	return force_sig_info_to_task(&info, t, false);
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
@@ -1820,6 +1821,27 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
 	return force_sig_info(&info);
 }
 
+/**
+ * force_sig_seccomp - signals the task to allow in-process syscall emulation
+ * @syscall: syscall number to send to userland
+ * @reason: filter-supplied reason code to send to userland (via si_errno)
+ *
+ * Forces a SIGSYS with a code of SYS_SECCOMP and related sigsys info.
+ */
+int force_sig_seccomp(int syscall, int reason, bool force_coredump)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_SECCOMP;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = reason;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall;
+	return force_sig_info_to_task(&info, current, force_coredump);
+}
+
 /* For the crazy architectures that include trap information in
  * the errno field, instead of an actual errno value.
  */
-- 
2.20.1

