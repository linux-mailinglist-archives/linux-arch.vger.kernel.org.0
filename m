Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB548388C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiACVea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:30 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53518 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiACVeH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:34:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:59342)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxz-008tnC-5U; Mon, 03 Jan 2022 14:34:07 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxy-006zvm-0t; Mon, 03 Jan 2022 14:34:06 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:10 -0600
Message-Id: <20220103213312.9144-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxy-006zvm-0t;;;mid=<20220103213312.9144-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19WsUgJ+H/UpszfMEuPnr4iNIjMQzk65Hk=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 11 (2.0%), parse: 1.23
        (0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 14 (2.6%), tests_pri_-950: 1.52 (0.3%),
        tests_pri_-900: 1.28 (0.2%), tests_pri_-90: 80 (15.0%), check_bayes:
        78 (14.7%), b_tokenize: 13 (2.4%), b_tok_get_all: 12 (2.2%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 46 (8.7%), b_finish: 1.14
        (0.2%), tests_pri_0: 390 (73.7%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 15/17] signal: Add JOBCTL_WILL_EXIT to mark exiting tasks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Mark tasks that need to exit with JOBCTL_WILL_EXIT instead of reusing
the per thread SIGKILL.

This removes the double meaning of the per thread SIGKILL and makes it
possible to detect when a task has already been scheduled for exiting
and to skip unnecessary work if the task is already scheduled to exit.

A jobctl flag was choosen for this purpose because jobctl changes are
protected by siglock, and updates are already careful not to change or
clear other bits in jobctl.  Protection by a lock when changing the
value is necessary as JOBCTL_WILL_EXIT will not be limited to being
set by the current task.  That task->jobctl is protected by siglock is
convenient as siglock is already held everywhere I want to set or reset
JOBCTL_WILL_EXIT.

Teach wants_signal and retarget_shared_pending to use
JOBCTL_TASK_EXITING to detect threads that have an exit pending and so
will not be processing any more signals.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  6 ++++--
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  2 +-
 kernel/exit.c                |  4 ++--
 kernel/signal.c              | 19 +++++++++----------
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9559e29daada..4e82ee51633d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -352,7 +352,6 @@ static int zap_process(struct task_struct *start, int exit_code)
 	struct task_struct *t;
 	int nr = 0;
 
-	/* Allow SIGKILL, see prepare_signal() */
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
@@ -376,9 +375,11 @@ static int zap_threads(struct task_struct *tsk,
 	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
 		signal->core_state = core_state;
 		nr = zap_process(tsk, exit_code);
+		atomic_set(&core_state->nr_threads, nr);
+		 /* Allow SIGKILL, see prepare_signal() */
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
-		atomic_set(&core_state->nr_threads, nr);
+		tsk->jobctl &= ~JOBCTL_WILL_EXIT;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 	return nr;
@@ -425,6 +426,7 @@ static void coredump_finish(bool core_dumped)
 		current->signal->group_exit_code |= 0x80;
 	next = current->signal->core_state->dumper.next;
 	current->signal->core_state = NULL;
+	current->jobctl |= JOBCTL_WILL_EXIT;
 	spin_unlock_irq(&current->sighand->siglock);
 
 	while ((curr = next) != NULL) {
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..9887d737ccfb 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_WILL_EXIT_BIT	31	/* task will exit */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_WILL_EXIT	(1UL << JOBCTL_WILL_EXIT_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index eed54f9ea2fc..989bb665f107 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -373,7 +373,7 @@ static inline int signal_pending(struct task_struct *p)
 
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	return unlikely(p->jobctl & JOBCTL_WILL_EXIT);
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)
diff --git a/kernel/exit.c b/kernel/exit.c
index 27bc0ccfea78..7a7a0cbac28e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -906,7 +906,7 @@ do_group_exit(int exit_code)
 
 	if (sig->flags & SIGNAL_GROUP_EXIT)
 		exit_code = sig->group_exit_code;
-	else if (sig->group_exec_task)
+	else if (current->jobctl & JOBCTL_WILL_EXIT)
 		exit_code = 0;
 	else if (!thread_group_empty(current)) {
 		struct sighand_struct *const sighand = current->sighand;
@@ -915,7 +915,7 @@ do_group_exit(int exit_code)
 		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
-		else if (sig->group_exec_task)
+		else if (current->jobctl & JOBCTL_WILL_EXIT)
 			exit_code = 0;
 		else {
 			struct task_struct *t;
diff --git a/kernel/signal.c b/kernel/signal.c
index b0201e05be40..6179e34ce666 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -153,7 +153,8 @@ static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 
 static bool recalc_sigpending_tsk(struct task_struct *t)
 {
-	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) ||
+	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE |
+			  JOBCTL_WILL_EXIT)) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked) ||
 	    cgroup_task_frozen(t)) {
@@ -911,7 +912,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		if (core_state) {
 			if (sig == SIGKILL) {
 				struct task_struct *dumper = core_state->dumper.task;
-				sigaddset(&dumper->pending.signal, SIGKILL);
+				dumper->jobctl |= JOBCTL_WILL_EXIT;
 				signal_wake_up(dumper, 1);
 			}
 		}
@@ -985,7 +986,7 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	if (sigismember(&p->blocked, sig))
 		return false;
 
-	if (p->flags & PF_EXITING)
+	if (p->jobctl & JOBCTL_WILL_EXIT)
 		return false;
 
 	if (sig == SIGKILL)
@@ -1363,10 +1364,9 @@ int force_sig_info(struct kernel_siginfo *info)
 
 void schedule_task_exit_locked(struct task_struct *task)
 {
-	task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
-	/* Only bother with threads that might be alive */
-	if (!(task->flags & PF_POSTCOREDUMP)) {
-		sigaddset(&task->pending.signal, SIGKILL);
+	if (!(task->jobctl & JOBCTL_WILL_EXIT)) {
+		task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
+		task->jobctl |= JOBCTL_WILL_EXIT;
 		signal_wake_up(task, 1);
 	}
 }
@@ -2695,9 +2695,8 @@ bool get_signal(struct ksignal *ksig)
 		int exit_code;
 
 		/* Has this task already been marked for death? */
-		if (__fatal_signal_pending(current)) {
+		if (current->jobctl & JOBCTL_WILL_EXIT) {
 			ksig->info.si_signo = signr = SIGKILL;
-			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
 				&sighand->action[SIGKILL - 1]);
 			recalc_sigpending();
@@ -2935,7 +2934,7 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 
 	t = tsk;
 	while_each_thread(tsk, t) {
-		if (t->flags & PF_EXITING)
+		if (t->jobctl & JOBCTL_WILL_EXIT)
 			continue;
 
 		if (!has_pending_signals(&retarget, &t->blocked))
-- 
2.29.2

