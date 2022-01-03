Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6B483886
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiACVeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:34:23 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55768 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiACVeF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:34:05 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54410)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxw-008wD7-RU; Mon, 03 Jan 2022 14:34:04 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxv-006zvm-8s; Mon, 03 Jan 2022 14:34:04 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:09 -0600
Message-Id: <20220103213312.9144-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxv-006zvm-8s;;;mid=<20220103213312.9144-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/7rKcji5T4omSxiJmES4YaISAldVmmCdw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 373 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (3.3%), b_tie_ro: 10 (2.8%), parse: 1.06
        (0.3%), extract_message_metadata: 11 (3.1%), get_uri_detail_list: 1.79
        (0.5%), tests_pri_-1000: 13 (3.6%), tests_pri_-950: 1.52 (0.4%),
        tests_pri_-900: 1.30 (0.3%), tests_pri_-90: 75 (20.2%), check_bayes:
        74 (19.8%), b_tokenize: 7 (2.0%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.94 (0.5%), b_tok_touch_all: 54 (14.4%), b_finish: 1.21
        (0.3%), tests_pri_0: 243 (65.3%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 3.2 (0.9%), poll_dns_idle: 1.36 (0.4%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 14/17] signal: Remove zap_other_threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The two callers of zap_other_threads want different things. The
function do_group_exit wants to set the exit code and it does not care
about the number of threads exiting.  In de_thread the current thread
is not exiting so there is not really an exit code.

Since schedule_task_exit_locked factors out the tricky bits stop
sharing the loop in zap_other_threads between de_thread and
do_group_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 12 +++++++++---
 include/linux/sched/signal.h |  1 -
 kernel/exit.c                |  9 ++++++++-
 kernel/signal.c              | 17 -----------------
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 82db656ca709..b9f646fddc51 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1037,6 +1037,7 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1055,9 +1056,14 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	sig->group_exec_task = tsk;
-	sig->notify_count = zap_other_threads(tsk);
-	if (!thread_group_leader(tsk))
-		sig->notify_count--;
+	sig->group_stop_count = 0;
+	sig->notify_count = 0;
+	__for_each_thread(sig, t) {
+		if (t == tsk)
+			continue;
+		sig->notify_count++;
+		schedule_task_exit_locked(t);
+	}
 
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7c62b7c29cc0..eed54f9ea2fc 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -343,7 +343,6 @@ extern void force_sig(int);
 extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
-extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
diff --git a/kernel/exit.c b/kernel/exit.c
index aedefe5eb0eb..27bc0ccfea78 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -918,9 +918,16 @@ do_group_exit(int exit_code)
 		else if (sig->group_exec_task)
 			exit_code = 0;
 		else {
+			struct task_struct *t;
+
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
-			zap_other_threads(current);
+			sig->group_stop_count = 0;
+			__for_each_thread(sig, t) {
+				if (t == current)
+					continue;
+				schedule_task_exit_locked(t);
+			}
 		}
 		spin_unlock_irq(&sighand->siglock);
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index cbfb9020368e..b0201e05be40 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1371,23 +1371,6 @@ void schedule_task_exit_locked(struct task_struct *task)
 	}
 }
 
-/*
- * Nuke all other threads in the group.
- */
-int zap_other_threads(struct task_struct *p)
-{
-	struct task_struct *t = p;
-	int count = 0;
-
-	p->signal->group_stop_count = 0;
-
-	while_each_thread(p, t) {
-		count++;
-		schedule_task_exit_locked(t);
-	}
-	return count;
-}
-
 struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 					   unsigned long *flags)
 {
-- 
2.29.2

