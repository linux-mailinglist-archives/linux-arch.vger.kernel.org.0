Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0548387E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiACVeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:14 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55714 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiACVd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54168)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxp-008wC2-R7; Mon, 03 Jan 2022 14:33:57 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxo-006zvm-Gp; Mon, 03 Jan 2022 14:33:57 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:06 -0600
Message-Id: <20220103213312.9144-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxo-006zvm-Gp;;;mid=<20220103213312.9144-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX190mElOvs4SYiKuQHnfeTivnEFRnZqD7i0=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMBrknScrpt_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 581 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 8 (1.4%), parse: 1.13 (0.2%),
        extract_message_metadata: 13 (2.2%), get_uri_detail_list: 3.4 (0.6%),
        tests_pri_-1000: 14 (2.3%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 85 (14.7%), check_bayes:
        84 (14.4%), b_tokenize: 13 (2.2%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 57 (9.8%), b_finish: 0.71
        (0.1%), tests_pri_0: 440 (75.6%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.12 (0.2%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 12 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/17] ptrace: Separate task->ptrace_code out from task->exit_code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A process can be marked for death by setting SIGNAL_GROUP_EXIT and
group_exit_code, long before do_exit is called.  Unfortunately because
of PTRACE_EVENT_EXIT residing in do_exit this same tactic can not be
used for task death.

Correct this by adding a new task field task->ptrace_code that holds
the code for ptrace stops.  This allows task->exit_code to be set to
the exit code long before the PTRACE_EVENT_EXIT ptrace stop.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/array.c       |  3 +++
 include/linux/sched.h |  1 +
 kernel/exit.c         |  2 +-
 kernel/ptrace.c       | 12 ++++++------
 kernel/signal.c       | 18 +++++++++---------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 43a7abde9e42..3042015c11ad 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -519,6 +519,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		cgtime = sig->cgtime;
 		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
+		if (task_is_traced(task) && !(task->jobctl & JOBCTL_LISTENING))
+			exit_code = task->ptrace_code;
+
 		/* add up live thread stats at the group level */
 		if (whole) {
 			struct task_struct *t = task;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 52f2fdffa3ab..c3d732bf7833 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1174,6 +1174,7 @@ struct task_struct {
 	/* Ptrace state: */
 	unsigned long			ptrace_message;
 	kernel_siginfo_t		*last_siginfo;
+	int				ptrace_code;
 
 	struct task_io_accounting	ioac;
 #ifdef CONFIG_PSI
diff --git a/kernel/exit.c b/kernel/exit.c
index 7121db37c411..aedefe5eb0eb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1134,7 +1134,7 @@ static int *task_stopped_code(struct task_struct *p, bool ptrace)
 {
 	if (ptrace) {
 		if (task_is_traced(p) && !(p->jobctl & JOBCTL_LISTENING))
-			return &p->exit_code;
+			return &p->ptrace_code;
 	} else {
 		if (p->signal->flags & SIGNAL_STOP_STOPPED)
 			return &p->signal->group_exit_code;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index eea265082e97..8bbd73ab9a34 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -172,7 +172,7 @@ void __ptrace_unlink(struct task_struct *child)
 
 static bool looks_like_a_spurious_pid(struct task_struct *task)
 {
-	if (task->exit_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
+	if (task->ptrace_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
 		return false;
 
 	if (task_pid_vnr(task) == task->ptrace_message)
@@ -573,7 +573,7 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
 	 * tasklist_lock avoids the race with wait_task_stopped(), see
 	 * the comment in ptrace_resume().
 	 */
-	child->exit_code = data;
+	child->ptrace_code = data;
 	__ptrace_detach(current, child);
 	write_unlock_irq(&tasklist_lock);
 
@@ -863,11 +863,11 @@ static int ptrace_resume(struct task_struct *child, long request,
 	}
 
 	/*
-	 * Change ->exit_code and ->state under siglock to avoid the race
-	 * with wait_task_stopped() in between; a non-zero ->exit_code will
+	 * Change ->ptrace_code and ->state under siglock to avoid the race
+	 * with wait_task_stopped() in between; a non-zero ->ptrace_code will
 	 * wrongly look like another report from tracee.
 	 *
-	 * Note that we need siglock even if ->exit_code == data and/or this
+	 * Note that we need siglock even if ->ptrace_code == data and/or this
 	 * status was not reported yet, the new status must not be cleared by
 	 * wait_task_stopped() after resume.
 	 *
@@ -878,7 +878,7 @@ static int ptrace_resume(struct task_struct *child, long request,
 	need_siglock = data && !thread_group_empty(current);
 	if (need_siglock)
 		spin_lock_irq(&child->sighand->siglock);
-	child->exit_code = data;
+	child->ptrace_code = data;
 	wake_up_state(child, __TASK_TRACED);
 	if (need_siglock)
 		spin_unlock_irq(&child->sighand->siglock);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9903ff12e581..fd3c404de8b6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2168,7 +2168,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  		info.si_status = tsk->signal->group_exit_code & 0x7f;
  		break;
  	case CLD_TRAPPED:
- 		info.si_status = tsk->exit_code & 0x7f;
+		info.si_status = tsk->ptrace_code & 0x7f;
  		break;
  	default:
  		BUG();
@@ -2198,7 +2198,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * with.  If the code did not stop because the tracer is gone,
  * the stop signal remains unchanged unless clear_code.
  */
-static int ptrace_stop(int exit_code, int why, int clear_code,
+static int ptrace_stop(int code, int why, int clear_code,
 			unsigned long message, kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
@@ -2248,7 +2248,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	current->ptrace_message = message;
 	current->last_siginfo = info;
-	current->exit_code = exit_code;
+	current->ptrace_code = code;
 
 	/*
 	 * If @why is CLD_STOPPED, we're trapping to participate in a group
@@ -2315,7 +2315,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		__set_current_state(TASK_RUNNING);
 		read_code = false;
 		if (clear_code)
-			exit_code = 0;
+			code = 0;
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2325,10 +2325,10 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	if (read_code) exit_code = current->exit_code;
+	if (read_code) code = current->ptrace_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
-	current->exit_code = 0;
+	current->ptrace_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
@@ -2339,7 +2339,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
 	recalc_sigpending_tsk(current);
-	return exit_code;
+	return code;
 }
 
 static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
@@ -2501,11 +2501,11 @@ static bool do_signal_stop(int signr)
  *
  * When PT_SEIZED, it's used for both group stop and explicit
  * SEIZE/INTERRUPT traps.  Both generate PTRACE_EVENT_STOP trap with
- * accompanying siginfo.  If stopped, lower eight bits of exit_code contain
+ * accompanying siginfo.  If stopped, lower eight bits of ptrace_code contain
  * the stop signal; otherwise, %SIGTRAP.
  *
  * When !PT_SEIZED, it's used only for group stop trap with stop signal
- * number as exit_code and no siginfo.
+ * number as ptrace_code and no siginfo.
  *
  * CONTEXT:
  * Must be called with @current->sighand->siglock held, which may be
-- 
2.29.2

