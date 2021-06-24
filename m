Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9193B3688
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFXTFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 15:05:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59868 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhFXTFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:05:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:33542)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUct-008eU2-2h; Thu, 24 Jun 2021 13:02:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47212 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUcr-003HZQ-M6; Thu, 24 Jun 2021 13:02:58 -0600
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
Date:   Thu, 24 Jun 2021 14:02:50 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87y2az5bmt.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUcr-003HZQ-M6;;;mid=<87y2az5bmt.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/lXuwnEpH9d/WqY5Bt5fTe321yxl0TTdU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 815 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.7 (0.5%), b_tie_ro: 2.6 (0.3%), parse: 0.83
        (0.1%), extract_message_metadata: 11 (1.3%), get_uri_detail_list: 2.5
        (0.3%), tests_pri_-1000: 12 (1.4%), tests_pri_-950: 1.08 (0.1%),
        tests_pri_-900: 0.87 (0.1%), tests_pri_-90: 378 (46.3%), check_bayes:
        376 (46.2%), b_tokenize: 10 (1.2%), b_tok_get_all: 239 (29.3%),
        b_comp_prob: 1.93 (0.2%), b_tok_touch_all: 122 (15.0%), b_finish: 0.79
        (0.1%), tests_pri_0: 399 (48.9%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 1.95 (0.2%), poll_dns_idle: 0.63 (0.1%),
        tests_pri_10: 1.83 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 7/9] signal: Make individual tasks exiting a first class concept.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Implement start_task_exit_locked and rewrite the de_thread logic
in exec using it.

Calling start_task_exit_locked is equivalent to asyncrhonously
calling exit(2) aka pthread_exit on a task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 10 +++++++++-
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  1 +
 kernel/signal.c              | 37 ++++++++++++++++--------------------
 4 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..b6f50213f0a0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,6 +1040,7 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1058,7 +1059,14 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	sig->group_exit_task = tsk;
-	sig->notify_count = zap_other_threads(tsk);
+	sig->group_stop_count = 0;
+	sig->notify_count = 0;
+	__for_each_thread(sig, t) {
+		if (t == tsk)
+			continue;
+		sig->notify_count++;
+		start_task_exit_locked(t, SIGKILL);
+	}
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
 
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..e94833b0c819 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_TASK_EXITING_BIT 31	/* the task is exiting */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_TASK_EXITING	(1UL << JOBCTL_TASK_EXITING_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c007e55cb119..a958381ba4a9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -429,6 +429,7 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 }
 
 void start_group_exit(int exit_code);
+void start_task_exit_locked(struct task_struct *task, int exit_code);
 
 void task_join_group_stop(struct task_struct *task);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 95a076af600a..afbc001220dd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -264,6 +264,12 @@ static inline void print_dropped_signal(int sig)
 				current->comm, current->pid, sig);
 }
 
+static void task_set_jobctl_exiting(struct task_struct *task, int exit_code)
+{
+	WARN_ON_ONCE(task->jobctl & ~JOBCTL_STOP_SIGMASK);
+	task->jobctl = JOBCTL_TASK_EXITING | (exit_code & JOBCTL_STOP_SIGMASK);
+}
+
 /**
  * task_set_jobctl_pending - set jobctl pending bits
  * @task: target task
@@ -1407,28 +1413,15 @@ int force_sig_info(struct kernel_siginfo *info)
 	return force_sig_info_to_task(info, current, false);
 }
 
-/*
- * Nuke all other threads in the group.
- */
-int zap_other_threads(struct task_struct *p)
+void start_task_exit_locked(struct task_struct *task, int exit_code)
 {
-	struct task_struct *t = p;
-	int count = 0;
-
-	p->signal->group_stop_count = 0;
-
-	while_each_thread(p, t) {
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		count++;
-
-		/* Don't bother with already dead threads */
-		if (t->exit_state)
-			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
-		signal_wake_up(t, 1);
+	task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
+	/* Only bother with threads that might be alive */
+	if (!task->exit_state) {
+		task_set_jobctl_exiting(task, exit_code);
+		sigaddset(&task->pending.signal, SIGKILL);
+		signal_wake_up(task, 1);
 	}
-
-	return count;
 }
 
 struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
@@ -2714,7 +2707,7 @@ bool get_signal(struct ksignal *ksig)
 	}
 
 	/* Has this task already been marked for death? */
-	if (signal_group_exit(signal)) {
+	if (signal_group_exit(signal) || (current->jobctl & JOBCTL_TASK_EXITING)) {
 		ksig->info.si_signo = signr = SIGKILL;
 		sigdelset(&current->pending.signal, SIGKILL);
 		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
@@ -2874,6 +2867,8 @@ bool get_signal(struct ksignal *ksig)
 			if (signal_group_exit(signal)) {
 				/* Another thread got here before we took the lock.  */
 				exit_code = signal->group_exit_code;
+			} else if (current->jobctl & JOBCTL_TASK_EXITING) {
+				exit_code = current->jobctl & JOBCTL_STOP_SIGMASK;
 			} else {
 				start_group_exit_locked(signal, exit_code);
 			}
-- 
2.20.1

