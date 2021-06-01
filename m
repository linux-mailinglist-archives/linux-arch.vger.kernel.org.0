Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC519397254
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFAL3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAL3x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 07:29:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD562C061574;
        Tue,  1 Jun 2021 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6k95mn5OA30wkBbHd3Cej14k/Nl83/wEbBpelepxgJA=; b=P5nsjzzpnhm0moIcF6q50QQsfM
        SgICvI+biW2/1vc4uShtsf49KkNrCOGRYbkNS+BEKmcS08Bm8vIveVSnrhRPYhhAwHd2kwv9bp2qS
        jgv/GkJbQN1AGtvR2ZEs/Xh/+rwC6JdoSVD7QYUsqHKjJEbTKVqHlSXDEIwaWbKoYR+V9Zi4nNIYs
        mOnAesJvYkfhCnDtUEvFNFypwR8FjzumI69/Iu4xcpXzP8bPKRh1XT91nSyuu9Rk/3Fkol/0cetTx
        Cdaabhsf0yLrcwIHLXfxFlC7GSGHw6U1vS6TxtKGcv6Vhf4EmAAUfBdjUpiI+faqyLiEGkPhJCu1B
        3EH/pNig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lo2Yr-002YBC-Fu; Tue, 01 Jun 2021 11:28:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 561F6300269;
        Tue,  1 Jun 2021 13:27:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E8A02011BE60; Tue,  1 Jun 2021 13:27:59 +0200 (CEST)
Date:   Tue, 1 Jun 2021 13:27:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [RFC][PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 01, 2021 at 10:21:15AM +0200, Peter Zijlstra wrote:
> 
> Hi,
> 
> This here rewrites the core freezer to behave better wrt thawing. By
> replacing PF_FROZEN with TASK_FROZEN, a special block state, it is
> ensured frozen tasks stay frozen until woken and don't randomly wake up
> early, as is currently possible.
> 
> As such, it does away with PF_FROZEN and PF_FREEZER_SKIP (yay).
> 
> It does however completely wreck kernel/cgroup/legacy_freezer.c and I've
> not yet spend any time on trying to figure out that code, will do so
> shortly.
> 
> Other than that, the freezer seems to work fine, I've tested it with:
> 
>   echo freezer > /sys/power/pm_test
>   echo mem > /sys/power/state
> 
> Even while having a GDB session active, and that all works.
> 
> Another notable bit is in init/do_mounts_initrd.c; afaict that has been
> 'broken' for quite a while and is simply removed.
> 
> Please have a look.
> 
> Somewhat-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

cgroup crud now compiles, also fixed some allmodconfig fails.

---
 drivers/android/binder.c       |   4 +-
 drivers/media/pci/pt3/pt3.c    |   4 +-
 fs/cifs/inode.c                |   4 +-
 fs/cifs/transport.c            |   5 +-
 fs/coredump.c                  |   4 +-
 fs/nfs/file.c                  |   3 +-
 fs/nfs/inode.c                 |  12 +-
 fs/nfs/nfs3proc.c              |   3 +-
 fs/nfs/nfs4proc.c              |  14 +--
 fs/nfs/nfs4state.c             |   3 +-
 fs/nfs/pnfs.c                  |   4 +-
 fs/xfs/xfs_trans_ail.c         |   8 +-
 include/linux/completion.h     |   2 +
 include/linux/freezer.h        | 244 ++---------------------------------------
 include/linux/sched.h          |   9 +-
 include/linux/sunrpc/sched.h   |   7 +-
 include/linux/wait.h           |  40 ++++++-
 init/do_mounts_initrd.c        |   7 +-
 kernel/cgroup/legacy_freezer.c |  23 ++--
 kernel/exit.c                  |   4 +-
 kernel/fork.c                  |   4 +-
 kernel/freezer.c               | 115 +++++++++++++------
 kernel/futex.c                 |   4 +-
 kernel/hung_task.c             |   4 +-
 kernel/power/main.c            |   5 +-
 kernel/power/process.c         |  10 +-
 kernel/sched/completion.c      |  16 +++
 kernel/sched/core.c            |   2 +-
 kernel/signal.c                |  14 +--
 kernel/time/hrtimer.c          |   4 +-
 mm/khugepaged.c                |   4 +-
 net/sunrpc/sched.c             |  12 +-
 net/unix/af_unix.c             |   8 +-
 33 files changed, 225 insertions(+), 381 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcec598b89f2..70b1dbf2c2b1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3712,10 +3712,9 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	struct binder_proc *proc = thread->proc;
 	int ret = 0;
 
-	freezer_do_not_count();
 	binder_inner_proc_lock(proc);
 	for (;;) {
-		prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		if (binder_has_work_ilocked(thread, do_proc_work))
 			break;
 		if (do_proc_work)
@@ -3732,7 +3731,6 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	}
 	finish_wait(&thread->wait, &wait);
 	binder_inner_proc_unlock(proc);
-	freezer_count();
 
 	return ret;
 }
diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index c0bc86793355..cc3cfbc0e33c 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -445,8 +445,8 @@ static int pt3_fetch_thread(void *data)
 		pt3_proc_dma(adap);
 
 		delay = ktime_set(0, PT3_FETCH_DELAY * NSEC_PER_MSEC);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		freezable_schedule_hrtimeout_range(&delay,
+		set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+		schedule_hrtimeout_range(&delay,
 					PT3_FETCH_DELAY_DELTA * NSEC_PER_MSEC,
 					HRTIMER_MODE_REL);
 	}
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 1dfa57982522..8fccf35392ec 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2280,7 +2280,7 @@ cifs_invalidate_mapping(struct inode *inode)
 static int
 cifs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
@@ -2297,7 +2297,7 @@ cifs_revalidate_mapping(struct inode *inode)
 		return 0;
 
 	rc = wait_on_bit_lock_action(flags, CIFS_INO_LOCK, cifs_wait_bit_killable,
-				     TASK_KILLABLE);
+				     TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	if (rc)
 		return rc;
 
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c1725b55f364..9258101bafbb 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -771,8 +771,9 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 {
 	int error;
 
-	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+	error = wait_event_state(server->response_q,
+				 midQ->mid_state != MID_REQUEST_SUBMITTED,
+				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 2868e3e171ae..50d5db61e6e0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -465,9 +465,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		freezer_do_not_count();
-		wait_for_completion(&core_state->startup);
-		freezer_count();
+		wait_for_completion_freezable(&core_state->startup);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..41e4bb19023d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -558,7 +558,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
-			nfs_wait_bit_killable, TASK_KILLABLE);
+			   nfs_wait_bit_killable,
+			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 
 	lock_page(page);
 	mapping = page_file_mapping(page);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 529c4099f482..df97984e9e5d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -72,18 +72,13 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 	return nfs_fileid_to_ino_t(fattr->fileid);
 }
 
-static int nfs_wait_killable(int mode)
+int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
 }
-
-int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
-{
-	return nfs_wait_killable(mode);
-}
 EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
 /**
@@ -1323,7 +1318,8 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	 */
 	for (;;) {
 		ret = wait_on_bit_action(bitlock, NFS_INO_INVALIDATING,
-					 nfs_wait_bit_killable, TASK_KILLABLE);
+					 nfs_wait_bit_killable,
+					 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (ret)
 			goto out;
 		spin_lock(&inode->i_lock);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 5c4e23abc345..85043fc451e9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -36,7 +36,8 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 		res = rpc_call_sync(clnt, msg, flags);
 		if (res != -EJUKEBOX)
 			break;
-		freezable_schedule_timeout_killable_unsafe(NFS_JUKEBOX_RETRY_TIME);
+		__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
 		res = -ERESTARTSYS;
 	} while (!fatal_signal_pending(current));
 	return res;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 87d04f2c9385..925c8bc217b5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -411,8 +411,8 @@ static int nfs4_delay_killable(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_killable_unsafe(
-		nfs4_update_delay(timeout));
+	__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	schedule_timeout(nfs4_update_delay(timeout));
 	if (!__fatal_signal_pending(current))
 		return 0;
 	return -EINTR;
@@ -422,7 +422,8 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
+	schedule_timeout(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
 		return 0;
 	return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
@@ -7280,7 +7281,8 @@ nfs4_retry_setlk_simple(struct nfs4_state *state, int cmd,
 		status = nfs4_proc_setlk(state, cmd, request);
 		if ((status != -EAGAIN) || IS_SETLK(cmd))
 			break;
-		freezable_schedule_timeout_interruptible(timeout);
+		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		schedule_timeout(timeout);
 		timeout *= 2;
 		timeout = min_t(unsigned long, NFS4_LOCK_MAXTIMEOUT, timeout);
 		status = -ERESTARTSYS;
@@ -7348,10 +7350,8 @@ nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 			break;
 
 		status = -ERESTARTSYS;
-		freezer_do_not_count();
-		wait_woken(&waiter.wait, TASK_INTERRUPTIBLE,
+		wait_woken(&waiter.wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
 			   NFS4_LOCK_MAXTIMEOUT);
-		freezer_count();
 	} while (!signalled());
 
 	remove_wait_queue(q, &waiter.wait);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f22818a80c2c..37f1aea98f8f 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1307,7 +1307,8 @@ int nfs4_wait_clnt_recover(struct nfs_client *clp)
 
 	refcount_inc(&clp->cl_count);
 	res = wait_on_bit_action(&clp->cl_state, NFS4CLNT_MANAGER_RUNNING,
-				 nfs_wait_bit_killable, TASK_KILLABLE);
+				 nfs_wait_bit_killable,
+				 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	if (res)
 		goto out;
 	if (clp->cl_cons_state < 0)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 03e0b34c4a64..807d8d56a09a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1898,7 +1898,7 @@ static int pnfs_prepare_to_retry_layoutget(struct pnfs_layout_hdr *lo)
 	pnfs_layoutcommit_inode(lo->plh_inode, false);
 	return wait_on_bit_action(&lo->plh_flags, NFS_LAYOUT_RETURN,
 				   nfs_wait_bit_killable,
-				   TASK_KILLABLE);
+				   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
 
 static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
@@ -3173,7 +3173,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 		status = wait_on_bit_lock_action(&nfsi->flags,
 				NFS_INO_LAYOUTCOMMITTING,
 				nfs_wait_bit_killable,
-				TASK_KILLABLE);
+				TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (status)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index dbb69b4bf3ed..bbf135df69c5 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -585,9 +585,9 @@ xfsaild(
 
 	while (1) {
 		if (tout && tout <= 20)
-			set_current_state(TASK_KILLABLE);
+			set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
 		else
-			set_current_state(TASK_INTERRUPTIBLE);
+			set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 
 		/*
 		 * Check kthread_should_stop() after we set the task state to
@@ -636,14 +636,14 @@ xfsaild(
 		    ailp->ail_target == ailp->ail_target_prev &&
 		    list_empty(&ailp->ail_buf_list)) {
 			spin_unlock(&ailp->ail_lock);
-			freezable_schedule();
+			schedule();
 			tout = 0;
 			continue;
 		}
 		spin_unlock(&ailp->ail_lock);
 
 		if (tout)
-			freezable_schedule_timeout(msecs_to_jiffies(tout));
+			schedule_timeout(msecs_to_jiffies(tout));
 
 		__set_current_state(TASK_RUNNING);
 
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab079629..76f8b5dac648 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -100,9 +100,11 @@ static inline void reinit_completion(struct completion *x)
 }
 
 extern void wait_for_completion(struct completion *);
+extern void wait_for_completion_freezable(struct completion *);
 extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
+extern int wait_for_completion_killable_freezable(struct completion *x);
 extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0621c5f86c39..c1cece97fd82 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -8,9 +8,11 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_FREEZER
-extern atomic_t system_freezing_cnt;	/* nr of freezing conds in effect */
+DECLARE_STATIC_KEY_FALSE(freezer_active);
+
 extern bool pm_freezing;		/* PM freezing in effect */
 extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
 
@@ -22,10 +24,7 @@ extern unsigned int freeze_timeout_msecs;
 /*
  * Check if a process has been frozen
  */
-static inline bool frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
+extern bool frozen(struct task_struct *p);
 
 extern bool freezing_slow_path(struct task_struct *p);
 
@@ -34,9 +33,10 @@ extern bool freezing_slow_path(struct task_struct *p);
  */
 static inline bool freezing(struct task_struct *p)
 {
-	if (likely(!atomic_read(&system_freezing_cnt)))
-		return false;
-	return freezing_slow_path(p);
+	if (static_branch_unlikely(&freezer_active))
+		return freezing_slow_path(p);
+
+	return false;
 }
 
 /* Takes and releases task alloc lock using task_lock() */
@@ -48,23 +48,14 @@ extern int freeze_kernel_threads(void);
 extern void thaw_processes(void);
 extern void thaw_kernel_threads(void);
 
-/*
- * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
- * If try_to_freeze causes a lockdep warning it means the caller may deadlock
- */
-static inline bool try_to_freeze_unsafe(void)
+static inline bool try_to_freeze(void)
 {
 	might_sleep();
 	if (likely(!freezing(current)))
 		return false;
-	return __refrigerator(false);
-}
-
-static inline bool try_to_freeze(void)
-{
 	if (!(current->flags & PF_NOFREEZE))
 		debug_check_no_locks_held();
-	return try_to_freeze_unsafe();
+	return __refrigerator(false);
 }
 
 extern bool freeze_task(struct task_struct *p);
@@ -79,195 +70,6 @@ static inline bool cgroup_freezing(struct task_struct *task)
 }
 #endif /* !CONFIG_CGROUP_FREEZER */
 
-/*
- * The PF_FREEZER_SKIP flag should be set by a vfork parent right before it
- * calls wait_for_completion(&vfork) and reset right after it returns from this
- * function.  Next, the parent should call try_to_freeze() to freeze itself
- * appropriately in case the child has exited before the freezing of tasks is
- * complete.  However, we don't want kernel threads to be frozen in unexpected
- * places, so we allow them to block freeze_processes() instead or to set
- * PF_NOFREEZE if needed. Fortunately, in the ____call_usermodehelper() case the
- * parent won't really block freeze_processes(), since ____call_usermodehelper()
- * (the child) does a little before exec/exit and it can't be frozen before
- * waking up the parent.
- */
-
-
-/**
- * freezer_do_not_count - tell freezer to ignore %current
- *
- * Tell freezers to ignore the current task when determining whether the
- * target frozen state is reached.  IOW, the current task will be
- * considered frozen enough by freezers.
- *
- * The caller shouldn't do anything which isn't allowed for a frozen task
- * until freezer_cont() is called.  Usually, freezer[_do_not]_count() pair
- * wrap a scheduling operation and nothing much else.
- */
-static inline void freezer_do_not_count(void)
-{
-	current->flags |= PF_FREEZER_SKIP;
-}
-
-/**
- * freezer_count - tell freezer to stop ignoring %current
- *
- * Undo freezer_do_not_count().  It tells freezers that %current should be
- * considered again and tries to freeze if freezing condition is already in
- * effect.
- */
-static inline void freezer_count(void)
-{
-	current->flags &= ~PF_FREEZER_SKIP;
-	/*
-	 * If freezing is in progress, the following paired with smp_mb()
-	 * in freezer_should_skip() ensures that either we see %true
-	 * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	try_to_freeze();
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline void freezer_count_unsafe(void)
-{
-	current->flags &= ~PF_FREEZER_SKIP;
-	smp_mb();
-	try_to_freeze_unsafe();
-}
-
-/**
- * freezer_should_skip - whether to skip a task when determining frozen
- *			 state is reached
- * @p: task in quesion
- *
- * This function is used by freezers after establishing %true freezing() to
- * test whether a task should be skipped when determining the target frozen
- * state is reached.  IOW, if this function returns %true, @p is considered
- * frozen enough.
- */
-static inline bool freezer_should_skip(struct task_struct *p)
-{
-	/*
-	 * The following smp_mb() paired with the one in freezer_count()
-	 * ensures that either freezer_count() sees %true freezing() or we
-	 * see cleared %PF_FREEZER_SKIP and return %false.  This makes it
-	 * impossible for a task to slip frozen state testing after
-	 * clearing %PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	return p->flags & PF_FREEZER_SKIP;
-}
-
-/*
- * These functions are intended to be used whenever you want allow a sleeping
- * task to be frozen. Note that neither return any clear indication of
- * whether a freeze event happened while in this function.
- */
-
-/* Like schedule(), but should not block the freezer. */
-static inline void freezable_schedule(void)
-{
-	freezer_do_not_count();
-	schedule();
-	freezer_count();
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline void freezable_schedule_unsafe(void)
-{
-	freezer_do_not_count();
-	schedule();
-	freezer_count_unsafe();
-}
-
-/*
- * Like schedule_timeout(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline long freezable_schedule_timeout(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/*
- * Like schedule_timeout_interruptible(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline long freezable_schedule_timeout_interruptible(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_interruptible(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
-{
-	long __retval;
-
-	freezer_do_not_count();
-	__retval = schedule_timeout_interruptible(timeout);
-	freezer_count_unsafe();
-	return __retval;
-}
-
-/* Like schedule_timeout_killable(), but should not block the freezer. */
-static inline long freezable_schedule_timeout_killable(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_killable(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline long freezable_schedule_timeout_killable_unsafe(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_killable(timeout);
-	freezer_count_unsafe();
-	return __retval;
-}
-
-/*
- * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
-		u64 delta, const enum hrtimer_mode mode)
-{
-	int __retval;
-	freezer_do_not_count();
-	__retval = schedule_hrtimeout_range(expires, delta, mode);
-	freezer_count();
-	return __retval;
-}
-
-/*
- * Freezer-friendly wrappers around wait_event_interruptible(),
- * wait_event_killable() and wait_event_interruptible_timeout(), originally
- * defined in <linux/wait.h>
- */
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-#define wait_event_freezekillable_unsafe(wq, condition)			\
-({									\
-	int __retval;							\
-	freezer_do_not_count();						\
-	__retval = wait_event_killable(wq, (condition));		\
-	freezer_count_unsafe();						\
-	__retval;							\
-})
-
 #else /* !CONFIG_FREEZER */
 static inline bool frozen(struct task_struct *p) { return false; }
 static inline bool freezing(struct task_struct *p) { return false; }
@@ -281,35 +83,9 @@ static inline void thaw_kernel_threads(void) {}
 
 static inline bool try_to_freeze(void) { return false; }
 
-static inline void freezer_do_not_count(void) {}
 static inline void freezer_count(void) {}
-static inline int freezer_should_skip(struct task_struct *p) { return 0; }
 static inline void set_freezable(void) {}
 
-#define freezable_schedule()  schedule()
-
-#define freezable_schedule_unsafe()  schedule()
-
-#define freezable_schedule_timeout(timeout)  schedule_timeout(timeout)
-
-#define freezable_schedule_timeout_interruptible(timeout)		\
-	schedule_timeout_interruptible(timeout)
-
-#define freezable_schedule_timeout_interruptible_unsafe(timeout)	\
-	schedule_timeout_interruptible(timeout)
-
-#define freezable_schedule_timeout_killable(timeout)			\
-	schedule_timeout_killable(timeout)
-
-#define freezable_schedule_timeout_killable_unsafe(timeout)		\
-	schedule_timeout_killable(timeout)
-
-#define freezable_schedule_hrtimeout_range(expires, delta, mode)	\
-	schedule_hrtimeout_range(expires, delta, mode)
-
-#define wait_event_freezekillable_unsafe(wq, condition)			\
-		wait_event_killable(wq, condition)
-
 #endif /* !CONFIG_FREEZER */
 
 #endif	/* FREEZER_H_INCLUDED */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2982cfab1ae9..bfadc1dbcf24 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,12 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+#define TASK_FREEZABLE			0x1000
+#define __TASK_FREEZABLE_UNSAFE		0x2000
+#define TASK_FROZEN			0x4000
+#define TASK_STATE_MAX			0x8000
+
+#define TASK_FREEZABLE_UNSAFE		(TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
@@ -1579,7 +1584,6 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USED_ASYNC		0x00004000	/* Used async_schedule*(), used by module init */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
@@ -1591,7 +1595,6 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
-#define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd675..4ecc7939997b 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -263,7 +263,7 @@ int		rpc_malloc(struct rpc_task *);
 void		rpc_free(struct rpc_task *);
 int		rpciod_up(void);
 void		rpciod_down(void);
-int		__rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *);
+int		rpc_wait_for_completion_task(struct rpc_task *task);
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 struct net;
 void		rpc_show_tasks(struct net *);
@@ -274,11 +274,6 @@ extern struct workqueue_struct *rpciod_workqueue;
 extern struct workqueue_struct *xprtiod_workqueue;
 void		rpc_prepare_task(struct rpc_task *task);
 
-static inline int rpc_wait_for_completion_task(struct rpc_task *task)
-{
-	return __rpc_wait_for_completion_task(task, NULL);
-}
-
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 static inline const char * rpc_qname(const struct rpc_wait_queue *q)
 {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index fe10e8570a52..f017880c25f0 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -335,8 +335,8 @@ do {										\
 } while (0)
 
 #define __wait_event_freezable(wq_head, condition)				\
-	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-			    freezable_schedule())
+	___wait_event(wq_head, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE),	\
+			0, 0, schedule())
 
 /**
  * wait_event_freezable - sleep (or freeze) until a condition gets true
@@ -394,8 +394,8 @@ do {										\
 
 #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
-		      TASK_INTERRUPTIBLE, 0, timeout,				\
-		      __ret = freezable_schedule_timeout(__ret))
+		      (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 0, timeout,		\
+		      __ret = schedule_timeout(__ret))
 
 /*
  * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
@@ -615,8 +615,8 @@ do {										\
 
 
 #define __wait_event_freezable_exclusive(wq, condition)				\
-	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,			\
-			freezable_schedule())
+	___wait_event(wq, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 1, 0,\
+			schedule())
 
 #define wait_event_freezable_exclusive(wq, condition)				\
 ({										\
@@ -905,6 +905,34 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __wait_event_state(wq, condition, state)				\
+	___wait_event(wq, condition, state, 0, 0, schedule())
+
+/**
+ * wait_event_state - sleep until a condition gets true
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @state: state to sleep in
+ *
+ * The process is put to sleep (@state) until the @condition evaluates to true
+ * or a signal is received.  The @condition is checked each time the waitqueue
+ * @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function will return -ERESTARTSYS if it was interrupted by a
+ * signal and 0 if @condition evaluated to true.
+ */
+#define wait_event_state(wq_head, condition, state)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_state(wq_head, condition, state);		\
+	__ret;									\
+})
+
 #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_KILLABLE, 0, timeout,				\
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 533d81ed74d4..2f1227053694 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -80,10 +80,9 @@ static void __init handle_initrd(void)
 	init_chdir("/old");
 
 	/*
-	 * In case that a resume from disk is carried out by linuxrc or one of
-	 * its children, we need to tell the freezer not to wait for us.
+	 * PF_FREEZER_SKIP is pointless because UMH is laundered through a
+	 * workqueue and that doesn't have the current context.
 	 */
-	current->flags |= PF_FREEZER_SKIP;
 
 	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
@@ -91,8 +90,6 @@ static void __init handle_initrd(void)
 		return;
 	call_usermodehelper_exec(info, UMH_WAIT_PROC);
 
-	current->flags &= ~PF_FREEZER_SKIP;
-
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 08236798d173..1b6b21851e9d 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -113,7 +113,7 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
 
 	if (parent && (parent->state & CGROUP_FREEZING)) {
 		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		atomic_inc(&system_freezing_cnt);
+		static_branch_inc(&freezer_active);
 	}
 
 	mutex_unlock(&freezer_mutex);
@@ -134,7 +134,7 @@ static void freezer_css_offline(struct cgroup_subsys_state *css)
 	mutex_lock(&freezer_mutex);
 
 	if (freezer->state & CGROUP_FREEZING)
-		atomic_dec(&system_freezing_cnt);
+		static_branch_dec(&freezer_active);
 
 	freezer->state = 0;
 
@@ -179,6 +179,7 @@ static void freezer_attach(struct cgroup_taskset *tset)
 			__thaw_task(task);
 		} else {
 			freeze_task(task);
+
 			/* clear FROZEN and propagate upwards */
 			while (freezer && (freezer->state & CGROUP_FROZEN)) {
 				freezer->state &= ~CGROUP_FROZEN;
@@ -271,16 +272,8 @@ static void update_if_frozen(struct cgroup_subsys_state *css)
 	css_task_iter_start(css, 0, &it);
 
 	while ((task = css_task_iter_next(&it))) {
-		if (freezing(task)) {
-			/*
-			 * freezer_should_skip() indicates that the task
-			 * should be skipped when determining freezing
-			 * completion.  Consider it frozen in addition to
-			 * the usual frozen condition.
-			 */
-			if (!frozen(task) && !freezer_should_skip(task))
-				goto out_iter_end;
-		}
+		if (freezing(task) && !frozen(task))
+			goto out_iter_end;
 	}
 
 	freezer->state |= CGROUP_FROZEN;
@@ -357,7 +350,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 
 	if (freeze) {
 		if (!(freezer->state & CGROUP_FREEZING))
-			atomic_inc(&system_freezing_cnt);
+			static_branch_inc(&freezer_active);
 		freezer->state |= state;
 		freeze_cgroup(freezer);
 	} else {
@@ -366,9 +359,9 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 		freezer->state &= ~state;
 
 		if (!(freezer->state & CGROUP_FREEZING)) {
-			if (was_freezing)
-				atomic_dec(&system_freezing_cnt);
 			freezer->state &= ~CGROUP_FROZEN;
+			if (was_freezing)
+				static_branch_dec(&freezer_active);
 			unfreeze_cgroup(freezer);
 		}
 	}
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..1a628f36c42a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -468,10 +468,10 @@ static void exit_mm(void)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
+			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
-			freezable_schedule();
+			schedule();
 		}
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
diff --git a/kernel/fork.c b/kernel/fork.c
index e595e77913eb..cd332f6816c0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1272,11 +1272,9 @@ static int wait_for_vfork_done(struct task_struct *child,
 {
 	int killed;
 
-	freezer_do_not_count();
 	cgroup_enter_frozen();
-	killed = wait_for_completion_killable(vfork);
+	killed = wait_for_completion_killable_freezable(vfork);
 	cgroup_leave_frozen(false);
-	freezer_count();
 
 	if (killed) {
 		task_lock(child);
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..df235fba6989 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -13,8 +13,8 @@
 #include <linux/kthread.h>
 
 /* total number of freezing conditions in effect */
-atomic_t system_freezing_cnt = ATOMIC_INIT(0);
-EXPORT_SYMBOL(system_freezing_cnt);
+DEFINE_STATIC_KEY_FALSE(freezer_active);
+EXPORT_SYMBOL(freezer_active);
 
 /* indicate whether PM freezing is in effect, protected by
  * system_transition_mutex
@@ -29,7 +29,7 @@ static DEFINE_SPINLOCK(freezer_lock);
  * freezing_slow_path - slow path for testing whether a task needs to be frozen
  * @p: task to be tested
  *
- * This function is called by freezing() if system_freezing_cnt isn't zero
+ * This function is called by freezing() if freezer_active isn't zero
  * and tests whether @p needs to enter and stay in frozen state.  Can be
  * called under any context.  The freezers are responsible for ensuring the
  * target tasks see the updated state.
@@ -52,41 +52,67 @@ bool freezing_slow_path(struct task_struct *p)
 }
 EXPORT_SYMBOL(freezing_slow_path);
 
+/* Recursion relies on tail-call optimization to not blow away the stack */
+static bool __frozen(struct task_struct *p)
+{
+	if (p->state == TASK_FROZEN)
+		return true;
+
+	/*
+	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
+	 */
+	if (task_is_traced(p))
+		return frozen(rcu_dereference(p->parent));
+
+	/*
+	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
+	 */
+	if (task_is_stopped(p))
+		return frozen(rcu_dereference(p->real_parent));
+
+	return false;
+}
+
+bool frozen(struct task_struct *p)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = __frozen(p);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /* Refrigerator is place where frozen processes are stored :-). */
 bool __refrigerator(bool check_kthr_stop)
 {
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
+	unsigned int state = READ_ONCE(current->state);
 	bool was_frozen = false;
-	long save = current->state;
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
+	WARN_ON_ONCE(state && !(state & TASK_NORMAL));
+
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		bool freeze;
+
+		set_current_state(TASK_FROZEN);
 
 		spin_lock_irq(&freezer_lock);
-		current->flags |= PF_FROZEN;
-		if (!freezing(current) ||
-		    (check_kthr_stop && kthread_should_stop()))
-			current->flags &= ~PF_FROZEN;
+		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
 		spin_unlock_irq(&freezer_lock);
 
-		if (!(current->flags & PF_FROZEN))
+		if (!freeze)
 			break;
+
 		was_frozen = true;
 		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 
 	pr_debug("%s left refrigerator\n", current->comm);
 
-	/*
-	 * Restore saved task state before returning.  The mb'd version
-	 * needs to be used; otherwise, it might silently break
-	 * synchronization which depends on ordered task state change.
-	 */
-	set_current_state(save);
-
 	return was_frozen;
 }
 EXPORT_SYMBOL(__refrigerator);
@@ -101,6 +127,37 @@ static void fake_signal_wake_up(struct task_struct *p)
 	}
 }
 
+static bool __freeze_task(struct task_struct *p)
+{
+	unsigned long flags;
+	unsigned int state;
+	bool frozen = false;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	state = READ_ONCE(p->state);
+	if (state & TASK_FREEZABLE) {
+		/*
+		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE,
+		 * since they can suffer spurious wakeups.
+		 */
+		WARN_ON_ONCE(!(state & TASK_NORMAL));
+
+#ifdef CONFIG_LOCKDEP
+		/*
+		 * It's dangerous to freeze with locks held; there be dragons there.
+		 */
+		if (!(state & __TASK_FREEZABLE_UNSAFE))
+			WARN_ON_ONCE(debug_locks && p->lockdep_depth);
+#endif
+
+		p->state = TASK_FROZEN;
+		frozen = true;
+	}
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return frozen;
+}
+
 /**
  * freeze_task - send a freeze request to given task
  * @p: task to send the request to
@@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
 {
 	unsigned long flags;
 
-	/*
-	 * This check can race with freezer_do_not_count, but worst case that
-	 * will result in an extra wakeup being sent to the task.  It does not
-	 * race with freezer_count(), the barriers in freezer_count() and
-	 * freezer_should_skip() ensure that either freezer_count() sees
-	 * freezing == true in try_to_freeze() and freezes, or
-	 * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
-	 * normally.
-	 */
-	if (freezer_should_skip(p))
-		return false;
-
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (!freezing(p) || frozen(p)) {
+	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
 		return false;
 	}
@@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
 	if (!(p->flags & PF_KTHREAD))
 		fake_signal_wake_up(p);
 	else
-		wake_up_state(p, TASK_INTERRUPTIBLE);
+		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
 
 	spin_unlock_irqrestore(&freezer_lock, flags);
 	return true;
@@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
 	unsigned long flags;
 
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (frozen(p))
-		wake_up_process(p);
+	WARN_ON_ONCE(freezing(p));
+	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 08008c225bec..5c80ca433fd3 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2582,7 +2582,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	 * queue_me() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 	queue_me(q, hb);
 
 	/* Arm the timer */
@@ -2600,7 +2600,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * is no timeout, or if it has yet to expire.
 		 */
 		if (!timeout || timeout->task)
-			freezable_schedule();
+			schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 }
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..33a4f2635970 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -92,8 +92,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
-	    return;
+	if (unlikely(t->state & (TASK_FREEZABLE | TASK_FROZEN)))
+		return;
 
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 12c7e1bb442f..0817e3913294 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -23,7 +23,8 @@
 
 void lock_system_sleep(void)
 {
-	current->flags |= PF_FREEZER_SKIP;
+	WARN_ON_ONCE(current->flags & PF_NOFREEZE);
+	current->flags |= PF_NOFREEZE;
 	mutex_lock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
@@ -46,7 +47,7 @@ void unlock_system_sleep(void)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	current->flags &= ~PF_FREEZER_SKIP;
+	current->flags &= ~PF_NOFREEZE;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 50cc63534486..36dee2dcfeab 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -53,8 +53,7 @@ static int try_to_freeze_tasks(bool user_only)
 			if (p == current || !freeze_task(p))
 				continue;
 
-			if (!freezer_should_skip(p))
-				todo++;
+			todo++;
 		}
 		read_unlock(&tasklist_lock);
 
@@ -99,8 +98,7 @@ static int try_to_freeze_tasks(bool user_only)
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
 			for_each_process_thread(g, p) {
-				if (p != current && !freezer_should_skip(p)
-				    && freezing(p) && !frozen(p))
+				if (p != current && freezing(p) && !frozen(p))
 					sched_show_task(p);
 			}
 			read_unlock(&tasklist_lock);
@@ -132,7 +130,7 @@ int freeze_processes(void)
 	current->flags |= PF_SUSPEND_TASK;
 
 	if (!pm_freezing)
-		atomic_inc(&system_freezing_cnt);
+		static_branch_inc(&freezer_active);
 
 	pm_wakeup_clear(true);
 	pr_info("Freezing user space processes ... ");
@@ -193,7 +191,7 @@ void thaw_processes(void)
 
 	trace_suspend_resume(TPS("thaw_processes"), 0, true);
 	if (pm_freezing)
-		atomic_dec(&system_freezing_cnt);
+		static_branch_dec(&freezer_active);
 	pm_freezing = false;
 	pm_nosig_freezing = false;
 
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554f9dad..b3d2b9ae72e6 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -139,6 +139,12 @@ void __sched wait_for_completion(struct completion *x)
 }
 EXPORT_SYMBOL(wait_for_completion);
 
+void __sched wait_for_completion_freezable(struct completion *x)
+{
+	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+}
+EXPORT_SYMBOL(wait_for_completion_freezable);
+
 /**
  * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
@@ -247,6 +253,16 @@ int __sched wait_for_completion_killable(struct completion *x)
 }
 EXPORT_SYMBOL(wait_for_completion_killable);
 
+int __sched wait_for_completion_killable_freezable(struct completion *x)
+{
+	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT,
+				 TASK_KILLABLE|TASK_FREEZABLE);
+	if (t == -ERESTARTSYS)
+		return t;
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_completion_killable_freezable);
+
 /**
  * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index adea0b1e8036..8ee0e7ccd632 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5893,7 +5893,7 @@ static void __sched notrace __schedule(bool preempt)
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
-				!(prev->flags & PF_FROZEN);
+				!(prev_state & TASK_FROZEN);
 
 			if (prev->sched_contributes_to_load)
 				rq->nr_uninterruptible++;
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..809ccad87565 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2265,7 +2265,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		read_unlock(&tasklist_lock);
 		cgroup_enter_frozen();
 		preempt_enable_no_resched();
-		freezable_schedule();
+		schedule();
 		cgroup_leave_frozen(true);
 	} else {
 		/*
@@ -2445,7 +2445,7 @@ static bool do_signal_stop(int signr)
 
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		cgroup_enter_frozen();
-		freezable_schedule();
+		schedule();
 		return true;
 	} else {
 		/*
@@ -2521,11 +2521,11 @@ static void do_freezer_trap(void)
 	 * immediately (if there is a non-fatal signal pending), and
 	 * put the task into sleep.
 	 */
-	__set_current_state(TASK_INTERRUPTIBLE);
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 	clear_thread_flag(TIF_SIGPENDING);
 	spin_unlock_irq(&current->sighand->siglock);
 	cgroup_enter_frozen();
-	freezable_schedule();
+	schedule();
 }
 
 static int ptrace_signal(int signr, kernel_siginfo_t *info)
@@ -3569,9 +3569,9 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
 
-		__set_current_state(TASK_INTERRUPTIBLE);
-		ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
-							 HRTIMER_MODE_REL);
+		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		ret = schedule_hrtimeout_range(to, tsk->timer_slack_ns,
+					       HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a66725b1d4a..a0e1f466254c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1889,11 +1889,11 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 	struct restart_block *restart;
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		hrtimer_sleeper_start_expires(t, mode);
 
 		if (likely(t->task))
-			freezable_schedule();
+			schedule();
 
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..9806779092a9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -794,8 +794,8 @@ static void khugepaged_alloc_sleep(void)
 	DEFINE_WAIT(wait);
 
 	add_wait_queue(&khugepaged_wait, &wait);
-	freezable_schedule_timeout_interruptible(
-		msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+	schedule_timeout(msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
 	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 39ed0e0afe6d..914f30bd23aa 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
@@ -324,14 +324,12 @@ static int rpc_complete_task(struct rpc_task *task)
  * to enforce taking of the wq->lock and hence avoid races with
  * rpc_complete_task().
  */
-int __rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *action)
+int rpc_wait_for_completion_task(struct rpc_task *task)
 {
-	if (action == NULL)
-		action = rpc_wait_bit_killable;
 	return out_of_line_wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
-			action, TASK_KILLABLE);
+			rpc_wait_bit_killable, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
-EXPORT_SYMBOL_GPL(__rpc_wait_for_completion_task);
+EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
 
 /*
  * Make an RPC task runnable.
@@ -928,7 +926,7 @@ static void __rpc_execute(struct rpc_task *task)
 		trace_rpc_task_sync_sleep(task, task->tk_action);
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_killable,
-				TASK_KILLABLE);
+				TASK_KILLABLE|TASK_FREEZABLE);
 		if (status < 0) {
 			/*
 			 * When a sync task receives a signal, it exits with
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5a31307ceb76..e5b83598b695 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2190,13 +2190,14 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 				  struct sk_buff *last, unsigned int last_len,
 				  bool freezable)
 {
+	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
 	DEFINE_WAIT(wait);
 
 	unix_state_lock(sk);
 
 	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(sk_sleep(sk), &wait, state);
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail != last ||
@@ -2209,10 +2210,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 
 		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		unix_state_unlock(sk);
-		if (freezable)
-			timeo = freezable_schedule_timeout(timeo);
-		else
-			timeo = schedule_timeout(timeo);
+		timeo = schedule_timeout(timeo);
 		unix_state_lock(sk);
 
 		if (sock_flag(sk, SOCK_DEAD))
