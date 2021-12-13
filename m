Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8363647381B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhLMWy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:59 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41916 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbhLMWy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51374)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDf-0081Y4-Rt; Mon, 13 Dec 2021 15:54:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDe-007pqT-Gh; Mon, 13 Dec 2021 15:54:55 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:50 -0600
Message-Id: <20211213225350.27481-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDe-007pqT-Gh;;;mid=<20211213225350.27481-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Lbs+tHYdygWWUhu2vBsg3lNOGTPj2TtE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 496 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 11 (2.1%), parse: 0.99
        (0.2%), extract_message_metadata: 11 (2.3%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 13 (2.7%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.25 (0.3%), tests_pri_-90: 56 (11.3%), check_bayes:
        55 (11.0%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 30 (6.0%), b_finish: 1.00
        (0.2%), tests_pri_0: 383 (77.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 1.24 (0.2%), tests_pri_10:
        3.4 (0.7%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 8/8] signal: Remove the helper signal_group_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This helper is misleading.  It tests for an ongoing exec as well as
the process having received a fatal signal.

Sometimes it is appropriate to treat an on-going exec differently than
a process that is shutting down due to a fatal signal.  In particular
taking the fast path out of exit_signals instead of retargeting
signals is not appropriate during exec, and not changing the the exit
code in do_group_exit during exec.

Removing the helper so that both cases must be coded for explicitly
makes it more obvious what is going on as both cases must be coded for
explicitly.

While removing the helper fix the two cases where I have observed
using signal_group_helper resulted in the wrong result.

For the unset exit_code in do_group_exit during an exec I use 0 as I
think that is what group_exit_code has been set to most of the time.
During a thread group stop group_exit_code is set to the stop signal
and when the thread group receives SIGCONT group_exit_code is reset to
0.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                | 5 +++--
 fs/exec.c                    | 2 +-
 include/linux/sched/signal.h | 7 -------
 kernel/exit.c                | 8 ++++++--
 kernel/signal.c              | 8 +++++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ef56595a0d87..09302a6a0d80 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -372,11 +372,12 @@ static int zap_process(struct task_struct *start, int exit_code)
 static int zap_threads(struct task_struct *tsk,
 			struct core_state *core_state, int exit_code)
 {
+	struct signal_struct *signal = tsk->signal;
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!signal_group_exit(tsk->signal)) {
-		tsk->signal->core_state = core_state;
+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+		signal->core_state = core_state;
 		nr = zap_process(tsk, exit_code);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
diff --git a/fs/exec.c b/fs/exec.c
index 9d2925811011..82db656ca709 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1045,7 +1045,7 @@ static int de_thread(struct task_struct *tsk)
 	 * Kill all other threads in the thread group.
 	 */
 	spin_lock_irq(lock);
-	if (signal_group_exit(sig)) {
+	if ((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task) {
 		/*
 		 * Another group action in progress, just
 		 * return so that the signal is processed.
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d3248aba5183..b6ecb9fc4cd2 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -271,13 +271,6 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
-/* If true, all threads except ->group_exec_task have pending SIGKILL */
-static inline int signal_group_exit(const struct signal_struct *sig)
-{
-	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
-		(sig->group_exec_task != NULL);
-}
-
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
diff --git a/kernel/exit.c b/kernel/exit.c
index 527c5e4430ae..e7104f803be0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -907,15 +907,19 @@ do_group_exit(int exit_code)
 
 	BUG_ON(exit_code & 0x80); /* core dumps don't get here */
 
-	if (signal_group_exit(sig))
+	if (sig->flags & SIGNAL_GROUP_EXIT)
 		exit_code = sig->group_exit_code;
+	else if (sig->group_exec_task)
+		exit_code = 0;
 	else if (!thread_group_empty(current)) {
 		struct sighand_struct *const sighand = current->sighand;
 
 		spin_lock_irq(&sighand->siglock);
-		if (signal_group_exit(sig))
+		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
+		else if (sig->group_exec_task)
+			exit_code = 0;
 		else {
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
diff --git a/kernel/signal.c b/kernel/signal.c
index 9eb3e2c1f9f7..860d844542b2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2392,7 +2392,8 @@ static bool do_signal_stop(int signr)
 		WARN_ON_ONCE(signr & ~JOBCTL_STOP_SIGMASK);
 
 		if (!likely(current->jobctl & JOBCTL_STOP_DEQUEUED) ||
-		    unlikely(signal_group_exit(sig)))
+		    unlikely(sig->flags & SIGNAL_GROUP_EXIT) ||
+		    unlikely(sig->group_exec_task))
 			return false;
 		/*
 		 * There is no group stop already in progress.  We must
@@ -2699,7 +2700,8 @@ bool get_signal(struct ksignal *ksig)
 		enum pid_type type;
 
 		/* Has this task already been marked for death? */
-		if (signal_group_exit(signal)) {
+		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
+		     signal->group_exec_task) {
 			ksig->info.si_signo = signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
@@ -2955,7 +2957,7 @@ void exit_signals(struct task_struct *tsk)
 	 */
 	cgroup_threadgroup_change_begin(tsk);
 
-	if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
+	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
-- 
2.29.2

