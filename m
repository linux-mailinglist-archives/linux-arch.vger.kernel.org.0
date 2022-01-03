Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F85483883
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiACVeR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:17 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55742 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiACVeC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:34:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54298)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxu-008wCZ-5g; Mon, 03 Jan 2022 14:34:02 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxt-006zvm-1z; Mon, 03 Jan 2022 14:34:01 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:08 -0600
Message-Id: <20220103213312.9144-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxt-006zvm-1z;;;mid=<20220103213312.9144-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ve0A1nOdiKJFClkslmix271YQhosArc8=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 525 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 8 (1.6%), parse: 1.00 (0.2%),
         extract_message_metadata: 12 (2.3%), get_uri_detail_list: 2.6 (0.5%),
        tests_pri_-1000: 13 (2.6%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 82 (15.6%), check_bayes:
        81 (15.3%), b_tokenize: 10 (1.9%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 56 (10.7%), b_finish: 0.81
        (0.2%), tests_pri_0: 391 (74.5%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 13/17] signal: Make individual tasks exiting a first class concept
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a helper schedule_task_exit_locked that is equivalent to
asynchronously calling exit(2) except for not having an exit code.

This is a generalization of what happens in de_thread, zap_process,
prepare_signal, complete_signal, and zap_other_threads when individual
tasks are asked to shutdown.

The various code paths optimize away the setting sigaddset and
signal_wake_up based on different conditions.  Neither sigaddset nor
signal_wake_up are needed if the task has already started running
do_exit.  So skip the work if PF_POSTCOREDUMP is set.  Which is the
earliest any of the original hand rolled implementations used.

Update get_signal to detect either signal group exit or a single task
exit by testing for __fatal_signal_pending.  This works because the
all of the tasks in group exits are killed with
schedule_task_exit_locked.

For clarity the code in get_signal has been updated to call do_exit
instead of do_group_exit when a single task is exiting.

While this schedule_task_exit_locked is a generalization of what
happens in prepare_signal I do not change prepare_signal to use
schedule_task_exit_locked to deliver SIGKILL to a coredumping process.
This keeps all of the specialness delivering a signal to a coredumping
process limited to prepare_signal and the coredump code itself.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  7 ++-----
 include/linux/sched/signal.h |  2 ++
 kernel/signal.c              | 36 +++++++++++++++++++++---------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 09302a6a0d80..9559e29daada 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -358,12 +358,9 @@ static int zap_process(struct task_struct *start, int exit_code)
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
-			sigaddset(&t->pending.signal, SIGKILL);
-			signal_wake_up(t, 1);
+		schedule_task_exit_locked(t);
+		if (t != current && !(t->flags & PF_POSTCOREDUMP))
 			nr++;
-		}
 	}
 
 	return nr;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b6ecb9fc4cd2..7c62b7c29cc0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -427,6 +427,8 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
+void schedule_task_exit_locked(struct task_struct *task);
+
 void task_join_group_stop(struct task_struct *task);
 
 #ifdef TIF_RESTORE_SIGMASK
diff --git a/kernel/signal.c b/kernel/signal.c
index 2a24cca00ca1..cbfb9020368e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1056,9 +1056,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_stop_count = 0;
 			t = p;
 			do {
-				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
-				signal_wake_up(t, 1);
+				schedule_task_exit_locked(t);
 			} while_each_thread(p, t);
 			return;
 		}
@@ -1363,6 +1361,16 @@ int force_sig_info(struct kernel_siginfo *info)
 	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
 }
 
+void schedule_task_exit_locked(struct task_struct *task)
+{
+	task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
+	/* Only bother with threads that might be alive */
+	if (!(task->flags & PF_POSTCOREDUMP)) {
+		sigaddset(&task->pending.signal, SIGKILL);
+		signal_wake_up(task, 1);
+	}
+}
+
 /*
  * Nuke all other threads in the group.
  */
@@ -1374,16 +1382,9 @@ int zap_other_threads(struct task_struct *p)
 	p->signal->group_stop_count = 0;
 
 	while_each_thread(p, t) {
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		count++;
-
-		/* Don't bother with already dead threads */
-		if (t->exit_state)
-			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
-		signal_wake_up(t, 1);
+		schedule_task_exit_locked(t);
 	}
-
 	return count;
 }
 
@@ -2706,12 +2707,12 @@ bool get_signal(struct ksignal *ksig)
 
 	for (;;) {
 		struct k_sigaction *ka;
+		bool group_exit = true;
 		enum pid_type type;
 		int exit_code;
 
 		/* Has this task already been marked for death? */
-		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
-		     signal->group_exec_task) {
+		if (__fatal_signal_pending(current)) {
 			ksig->info.si_signo = signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
@@ -2719,8 +2720,10 @@ bool get_signal(struct ksignal *ksig)
 			recalc_sigpending();
 			if (signal->flags & SIGNAL_GROUP_EXIT)
 				exit_code = signal->group_exit_code;
-			else
+			else {
 				exit_code = 0;
+				group_exit = false;
+			}
 			goto fatal;
 		}
 
@@ -2880,7 +2883,10 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(exit_code);
+		if (group_exit)
+			do_group_exit(exit_code);
+		else
+			do_exit(exit_code);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.29.2

