Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC146DCF2
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhLHU34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:29:56 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60764 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbhLHU3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:29:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:41774)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W9-00H1jN-CY; Wed, 08 Dec 2021 13:26:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W7-00CjR6-P7; Wed, 08 Dec 2021 13:26:20 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:25 -0600
Message-Id: <20211208202532.16409-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3W7-00CjR6-P7;;;mid=<20211208202532.16409-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kbIcwDNF8Iyggq6b+HwJYPh0d32BPmHE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
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
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 991 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (0.5%), b_tie_ro: 3.2 (0.3%), parse: 1.44
        (0.1%), extract_message_metadata: 12 (1.2%), get_uri_detail_list: 3.7
        (0.4%), tests_pri_-1000: 11 (1.1%), tests_pri_-950: 0.96 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 128 (13.0%), check_bayes:
        127 (12.8%), b_tokenize: 9 (0.9%), b_tok_get_all: 9 (0.9%),
        b_comp_prob: 1.94 (0.2%), b_tok_touch_all: 104 (10.5%), b_finish: 0.77
        (0.1%), tests_pri_0: 818 (82.6%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 1.75 (0.2%), poll_dns_idle: 0.33 (0.0%),
        tests_pri_10: 2.8 (0.3%), tests_pri_500: 7 (0.7%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 03/10] exit: Move oops specific logic from do_exit into make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The beginning of do_exit has become cluttered and difficult to read as
it is filled with checks to handle things that can only happen when
the kernel is operating improperly.

Now that we have a dedicated function for cleaning up a task when the
kernel is operating improperly move the checks there.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c       | 78 ++++++++++++++++++++++-----------------------
 kernel/futex/core.c |  2 +-
 kernel/kexec_core.c |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index bfa513c5b227..d0ec6f6b41cb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -735,36 +735,8 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
-	/*
-	 * We can get here from a kernel oops, sometimes with preemption off.
-	 * Start by checking for critical errors.
-	 * Then fix up important state like USER_DS and preemption.
-	 * Then do everything else.
-	 */
-
 	WARN_ON(blk_needs_flush_plug(tsk));
 
-	if (unlikely(in_interrupt()))
-		panic("Aiee, killing interrupt handler!");
-	if (unlikely(!tsk->pid))
-		panic("Attempted to kill the idle task!");
-
-	/*
-	 * If do_exit is called because this processes oopsed, it's possible
-	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
-	 * continuing. Amongst other possible reasons, this is to prevent
-	 * mm_release()->clear_child_tid() from writing to a user-controlled
-	 * kernel address.
-	 */
-	force_uaccess_begin();
-
-	if (unlikely(in_atomic())) {
-		pr_info("note: %s[%d] exited with preempt_count %d\n",
-			current->comm, task_pid_nr(current),
-			preempt_count());
-		preempt_count_set(PREEMPT_ENABLED);
-	}
-
 	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
 
@@ -773,17 +745,6 @@ void __noreturn do_exit(long code)
 
 	validate_creds_for_do_exit(tsk);
 
-	/*
-	 * We're taking recursive faults here in do_exit. Safest is to just
-	 * leave this task alone and wait for reboot.
-	 */
-	if (unlikely(tsk->flags & PF_EXITING)) {
-		pr_alert("Fixing recursive fault but reboot is needed!\n");
-		futex_exit_recursive(tsk);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule();
-	}
-
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
 
@@ -889,7 +850,46 @@ void __noreturn make_task_dead(int signr)
 	/*
 	 * Take the task off the cpu after something catastrophic has
 	 * happened.
+	 *
+	 * We can get here from a kernel oops, sometimes with preemption off.
+	 * Start by checking for critical errors.
+	 * Then fix up important state like USER_DS and preemption.
+	 * Then do everything else.
 	 */
+	struct task_struct *tsk = current;
+
+	if (unlikely(in_interrupt()))
+		panic("Aiee, killing interrupt handler!");
+	if (unlikely(!tsk->pid))
+		panic("Attempted to kill the idle task!");
+
+	/*
+	 * If make_task_dead is called because this processes oopsed, it's possible
+	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
+	 * continuing. Amongst other possible reasons, this is to prevent
+	 * mm_release()->clear_child_tid() from writing to a user-controlled
+	 * kernel address.
+	 */
+	force_uaccess_begin();
+
+	if (unlikely(in_atomic())) {
+		pr_info("note: %s[%d] exited with preempt_count %d\n",
+			current->comm, task_pid_nr(current),
+			preempt_count());
+		preempt_count_set(PREEMPT_ENABLED);
+	}
+
+	/*
+	 * We're taking recursive faults here in make_task_dead. Safest is to just
+	 * leave this task alone and wait for reboot.
+	 */
+	if (unlikely(tsk->flags & PF_EXITING)) {
+		pr_alert("Fixing recursive fault but reboot is needed!\n");
+		futex_exit_recursive(tsk);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule();
+	}
+
 	do_exit(signr);
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 25d8a88b32e5..39a1522865b5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1044,7 +1044,7 @@ static void futex_cleanup(struct task_struct *tsk)
  * actually finished the futex cleanup. The worst case for this is that the
  * waiter runs through the wait loop until the state becomes visible.
  *
- * This is called from the recursive fault handling path in do_exit().
+ * This is called from the recursive fault handling path in make_task_dead().
  *
  * This is best effort. Either the futex exit code has run already or
  * not. If the OWNER_DIED bit has been set on the futex then the waiter can
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5a5d192a89ac..68480f731192 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -81,7 +81,7 @@ int kexec_should_crash(struct task_struct *p)
 	if (crash_kexec_post_notifiers)
 		return 0;
 	/*
-	 * There are 4 panic() calls in do_exit() path, each of which
+	 * There are 4 panic() calls in make_task_dead() path, each of which
 	 * corresponds to each of these 4 conditions.
 	 */
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
-- 
2.29.2

