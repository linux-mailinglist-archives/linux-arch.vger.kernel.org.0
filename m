Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F17473819
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhLMWy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:54:58 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41876 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbhLMWyy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:54:54 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51286)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDd-0081XW-9T; Mon, 13 Dec 2021 15:54:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60446 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwuDc-007pqT-1Z; Mon, 13 Dec 2021 15:54:52 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 13 Dec 2021 16:53:49 -0600
Message-Id: <20211213225350.27481-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mwuDc-007pqT-1Z;;;mid=<20211213225350.27481-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19dnpH5orn0bEV6865YbFWpQznsONdXJOI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 620 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.11 (0.2%),
         extract_message_metadata: 13 (2.1%), get_uri_detail_list: 2.1 (0.3%),
        tests_pri_-1000: 14 (2.3%), tests_pri_-950: 1.47 (0.2%),
        tests_pri_-900: 1.33 (0.2%), tests_pri_-90: 209 (33.7%), check_bayes:
        207 (33.4%), b_tokenize: 9 (1.5%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 2.5 (0.4%), b_tok_touch_all: 184 (29.6%), b_finish: 1.05
        (0.2%), tests_pri_0: 353 (57.0%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 0.58 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 11 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/8] signal: Rename group_exit_task group_exec_task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The only remaining user of group_exit_task is exec.  Rename the field
so that it is clear which part of the code uses it.

Update the comment above the definition of group_exec_task
to document how it is currently used.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    |  8 ++++----
 include/linux/sched/signal.h | 12 ++++--------
 kernel/exit.c                |  4 ++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 59cac7c18178..9d2925811011 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1054,7 +1054,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
-	sig->group_exit_task = tsk;
+	sig->group_exec_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
@@ -1082,7 +1082,7 @@ static int de_thread(struct task_struct *tsk)
 			write_lock_irq(&tasklist_lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
-			 * exit_notify() can't miss ->group_exit_task
+			 * exit_notify() can't miss ->group_exec_task
 			 */
 			sig->notify_count = -1;
 			if (likely(leader->exit_state))
@@ -1149,7 +1149,7 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
 no_thread_group:
@@ -1162,7 +1162,7 @@ static int de_thread(struct task_struct *tsk)
 killed:
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 	read_unlock(&tasklist_lock);
 	return -EAGAIN;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ecc10e148799..d3248aba5183 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -109,13 +109,9 @@ struct signal_struct {
 
 	/* thread group exit support */
 	int			group_exit_code;
-	/* overloaded:
-	 * - notify group_exit_task when ->count is equal to notify_count
-	 * - everyone except group_exit_task is stopped during signal delivery
-	 *   of fatal signals, group_exit_task processes the signal.
-	 */
+	/* notify group_exec_task when notify_count is less or equal to 0 */
 	int			notify_count;
-	struct task_struct	*group_exit_task;
+	struct task_struct	*group_exec_task;
 
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
@@ -275,11 +271,11 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
-/* If true, all threads except ->group_exit_task have pending SIGKILL */
+/* If true, all threads except ->group_exec_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
 	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
-		(sig->group_exit_task != NULL);
+		(sig->group_exec_task != NULL);
 }
 
 extern void flush_signals(struct task_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index 6c4b04531f17..527c5e4430ae 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -116,7 +116,7 @@ static void __exit_signal(struct task_struct *tsk)
 		 * then notify it:
 		 */
 		if (sig->notify_count > 0 && !--sig->notify_count)
-			wake_up_process(sig->group_exit_task);
+			wake_up_process(sig->group_exec_task);
 
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
@@ -697,7 +697,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
 	/* mt-exec, de_thread() is waiting for group leader */
 	if (unlikely(tsk->signal->notify_count < 0))
-		wake_up_process(tsk->signal->group_exit_task);
+		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
-- 
2.29.2

