Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659A46DCFF
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhLHUaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40078 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhLHUaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:14 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:47130)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WT-00GaQL-Dm; Wed, 08 Dec 2021 13:26:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WR-00CjR6-Hy; Wed, 08 Dec 2021 13:26:40 -0700
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
Date:   Wed,  8 Dec 2021 14:25:31 -0600
Message-Id: <20211208202532.16409-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WR-00CjR6-Hy;;;mid=<20211208202532.16409-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Y0tzBfHIGdQ1NLRAR+VAShVgTIqhJh1U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1250 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 10 (0.8%), parse: 1.16
        (0.1%), extract_message_metadata: 13 (1.1%), get_uri_detail_list: 3.2
        (0.3%), tests_pri_-1000: 14 (1.1%), tests_pri_-950: 1.19 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 218 (17.4%), check_bayes:
        216 (17.3%), b_tokenize: 13 (1.0%), b_tok_get_all: 11 (0.9%),
        b_comp_prob: 2.8 (0.2%), b_tok_touch_all: 185 (14.8%), b_finish: 0.96
        (0.1%), tests_pri_0: 965 (77.2%), check_dkim_signature: 1.02 (0.1%),
        check_dkim_adsp: 3.3 (0.3%), poll_dns_idle: 1.05 (0.1%), tests_pri_10:
        3.0 (0.2%), tests_pri_500: 20 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/10] kthread: Ensure struct kthread is present for all kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Today the rules are a bit iffy and arbitrary about which kernel
threads have struct kthread present.  Both idle threads and thread
started with create_kthread want struct kthread present so that is
effectively all kernel threads.  Make the rule that if PF_KTHREAD
and the task is running then struct kthread is present.

This will allow the kernel thread code to using tsk->exit_code
with different semantics from ordinary processes.

To make ensure that struct kthread is present for all
kernel threads move it's allocation into copy_process.

Add a deallocation of struct kthread in exec for processes
that were kernel threads.

Move the allocation of struct kthread for the initial thread
earlier so that it is not repeated for each additional idle
thread.

Move the initialization of struct kthread into set_kthread_struct
so that the structure is always and reliably initailized.

Clear set_child_tid in free_kthread_struct to ensure the kthread
struct is reliably freed during exec.  The function
free_kthread_struct does not need to clear vfork_done during exec as
exec_mm_release called from exec_mmap has already cleared vfork_done.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               |  2 ++
 include/linux/kthread.h |  2 +-
 kernel/fork.c           |  4 ++++
 kernel/kthread.c        | 31 ++++++++++++++-----------------
 kernel/sched/core.c     | 16 ++++++++--------
 5 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..59cac7c18178 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1307,6 +1307,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	force_uaccess_begin();
 
+	if (me->flags & PF_KTHREAD)
+		free_kthread_struct(me);
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index d86a7e3b9a52..4f3433afb54b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,7 +33,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  unsigned int cpu,
 					  const char *namefmt);
 
-void set_kthread_struct(struct task_struct *p);
+bool set_kthread_struct(struct task_struct *p);
 
 void kthread_set_per_cpu(struct task_struct *k, int cpu);
 bool kthread_is_per_cpu(struct task_struct *k);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..04fa3e5d97af 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2118,6 +2118,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
+	if (p->flags & PF_KTHREAD) {
+		if (!set_kthread_struct(p))
+			goto bad_fork_cleanup_threadgroup_lock;
+	}
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
 	if (IS_ERR(p->mempolicy)) {
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4388d6694a7f..8e5f44bed027 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -93,20 +93,27 @@ static inline struct kthread *__to_kthread(struct task_struct *p)
 	return kthread;
 }
 
-void set_kthread_struct(struct task_struct *p)
+bool set_kthread_struct(struct task_struct *p)
 {
 	struct kthread *kthread;
 
-	if (__to_kthread(p))
-		return;
+	if (WARN_ON_ONCE(to_kthread(p)))
+		return false;
 
 	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
+	if (!kthread)
+		return false;
+
+	init_completion(&kthread->exited);
+	init_completion(&kthread->parked);
+	p->vfork_done = &kthread->exited;
+
 	/*
 	 * We abuse ->set_child_tid to avoid the new member and because it
-	 * can't be wrongly copied by copy_process(). We also rely on fact
-	 * that the caller can't exec, so PF_KTHREAD can't be cleared.
+	 * can't be wrongly copied by copy_process().
 	 */
 	p->set_child_tid = (__force void __user *)kthread;
+	return true;
 }
 
 void free_kthread_struct(struct task_struct *k)
@@ -114,13 +121,13 @@ void free_kthread_struct(struct task_struct *k)
 	struct kthread *kthread;
 
 	/*
-	 * Can be NULL if this kthread was created by kernel_thread()
-	 * or if kmalloc() in kthread() failed.
+	 * Can be NULL if kmalloc() in set_kthread_struct() failed.
 	 */
 	kthread = to_kthread(k);
 #ifdef CONFIG_BLK_CGROUP
 	WARN_ON_ONCE(kthread && kthread->blkcg_css);
 #endif
+	k->set_child_tid = (__force void __user *)NULL;
 	kfree(kthread);
 }
 
@@ -315,7 +322,6 @@ static int kthread(void *_create)
 	struct kthread *self;
 	int ret;
 
-	set_kthread_struct(current);
 	self = to_kthread(current);
 
 	/* If user was SIGKILLed, I release the structure. */
@@ -325,17 +331,8 @@ static int kthread(void *_create)
 		kthread_exit(-EINTR);
 	}
 
-	if (!self) {
-		create->result = ERR_PTR(-ENOMEM);
-		complete(done);
-		kthread_exit(-ENOMEM);
-	}
-
 	self->threadfn = threadfn;
 	self->data = data;
-	init_completion(&self->exited);
-	init_completion(&self->parked);
-	current->vfork_done = &self->exited;
 
 	/*
 	 * The new thread inherited kthreadd's priority and CPU mask. Reset
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fda64ac..0404a8c572a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8599,14 +8599,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 
 	__sched_fork(0, idle);
 
-	/*
-	 * The idle task doesn't need the kthread struct to function, but it
-	 * is dressed up as a per-CPU kthread and thus needs to play the part
-	 * if we want to avoid special-casing it in code that deals with per-CPU
-	 * kthreads.
-	 */
-	set_kthread_struct(idle);
-
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
@@ -9427,6 +9419,14 @@ void __init sched_init(void)
 	mmgrab(&init_mm);
 	enter_lazy_tlb(&init_mm, current);
 
+	/*
+	 * The idle task doesn't need the kthread struct to function, but it
+	 * is dressed up as a per-CPU kthread and thus needs to play the part
+	 * if we want to avoid special-casing it in code that deals with per-CPU
+	 * kthreads.
+	 */
+	WARN_ON(set_kthread_struct(current));
+
 	/*
 	 * Make us the idle thread. Technically, schedule() should not be
 	 * called from this thread, however somewhere below it might be,
-- 
2.29.2

