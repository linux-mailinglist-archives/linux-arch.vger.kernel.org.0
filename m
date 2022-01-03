Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A570D483888
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiACVeZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:25 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53544 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiACVeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:34:11 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:59418)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uy2-008tne-AD; Mon, 03 Jan 2022 14:34:10 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uy0-006zvm-9C; Mon, 03 Jan 2022 14:34:08 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:11 -0600
Message-Id: <20220103213312.9144-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uy0-006zvm-9C;;;mid=<20220103213312.9144-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OVBiRPGvA36vV0sSJn7+q19HoR7Q84/s=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 494 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.02
        (0.2%), extract_message_metadata: 13 (2.5%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 14 (2.8%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 68 (13.7%), check_bayes:
        66 (13.4%), b_tokenize: 11 (2.1%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 42 (8.6%), b_finish: 0.85
        (0.2%), tests_pri_0: 369 (74.8%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.29 (0.3%), tests_pri_10:
        3.2 (0.7%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 16/17] signal: Record the exit_code when an exit is scheduled
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With ptrace_stop no longer using task->exit_code it is safe
to set task->exit_code when an exit is scheduled.

Use the bit JOBCTL_WILL_EXIT to detect when a exit is first scheduled
and only set exit_code the first time.  Only use the code provided
to do_exit if the task has not yet been schedled to exit.

In get_signal and do_grup_exit when JOBCTL_WILL_EXIT is set read the
recored exit_code from current->exit_code, instead of assuming
exit_code will always be 0.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  2 +-
 fs/exec.c                    |  2 +-
 include/linux/sched/signal.h |  2 +-
 kernel/exit.c                | 12 ++++++++----
 kernel/signal.c              |  7 ++++---
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4e82ee51633d..c54b502bf648 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -357,7 +357,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
-		schedule_task_exit_locked(t);
+		schedule_task_exit_locked(t, exit_code);
 		if (t != current && !(t->flags & PF_POSTCOREDUMP))
 			nr++;
 	}
diff --git a/fs/exec.c b/fs/exec.c
index b9f646fddc51..3203605e54cb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1062,7 +1062,7 @@ static int de_thread(struct task_struct *tsk)
 		if (t == tsk)
 			continue;
 		sig->notify_count++;
-		schedule_task_exit_locked(t);
+		schedule_task_exit_locked(t, 0);
 	}
 
 	while (sig->notify_count) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 989bb665f107..e8034ecaee84 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -426,7 +426,7 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
-void schedule_task_exit_locked(struct task_struct *task);
+void schedule_task_exit_locked(struct task_struct *task, int exit_code);
 
 void task_join_group_stop(struct task_struct *task);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 7a7a0cbac28e..e95500e2d27c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -735,6 +735,11 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	spin_lock_irq(&tsk->sighand->siglock);
+	schedule_task_exit_locked(tsk, code);
+	code = tsk->exit_code;
+	spin_unlock_irq(&tsk->sighand->siglock);
+
 	WARN_ON(blk_needs_flush_plug(tsk));
 
 	kcov_task_exit(tsk);
@@ -773,7 +778,6 @@ void __noreturn do_exit(long code)
 		tty_audit_exit();
 	audit_free(tsk);
 
-	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
 	exit_mm();
@@ -907,7 +911,7 @@ do_group_exit(int exit_code)
 	if (sig->flags & SIGNAL_GROUP_EXIT)
 		exit_code = sig->group_exit_code;
 	else if (current->jobctl & JOBCTL_WILL_EXIT)
-		exit_code = 0;
+		exit_code = current->exit_code;
 	else if (!thread_group_empty(current)) {
 		struct sighand_struct *const sighand = current->sighand;
 
@@ -916,7 +920,7 @@ do_group_exit(int exit_code)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
 		else if (current->jobctl & JOBCTL_WILL_EXIT)
-			exit_code = 0;
+			exit_code = current->exit_code;
 		else {
 			struct task_struct *t;
 
@@ -926,7 +930,7 @@ do_group_exit(int exit_code)
 			__for_each_thread(sig, t) {
 				if (t == current)
 					continue;
-				schedule_task_exit_locked(t);
+				schedule_task_exit_locked(t, exit_code);
 			}
 		}
 		spin_unlock_irq(&sighand->siglock);
diff --git a/kernel/signal.c b/kernel/signal.c
index 6179e34ce666..e8fac8a3c935 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,7 +1057,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_stop_count = 0;
 			t = p;
 			do {
-				schedule_task_exit_locked(t);
+				schedule_task_exit_locked(t, sig);
 			} while_each_thread(p, t);
 			return;
 		}
@@ -1362,11 +1362,12 @@ int force_sig_info(struct kernel_siginfo *info)
 	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
 }
 
-void schedule_task_exit_locked(struct task_struct *task)
+void schedule_task_exit_locked(struct task_struct *task, int exit_code)
 {
 	if (!(task->jobctl & JOBCTL_WILL_EXIT)) {
 		task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
 		task->jobctl |= JOBCTL_WILL_EXIT;
+		task->exit_code = exit_code;
 		signal_wake_up(task, 1);
 	}
 }
@@ -2703,7 +2704,7 @@ bool get_signal(struct ksignal *ksig)
 			if (signal->flags & SIGNAL_GROUP_EXIT)
 				exit_code = signal->group_exit_code;
 			else {
-				exit_code = 0;
+				exit_code = current->exit_code;
 				group_exit = false;
 			}
 			goto fatal;
-- 
2.29.2

