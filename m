Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3A255A2F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgH1Mbv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbgH1MaO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:30:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B712220872;
        Fri, 28 Aug 2020 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617812;
        bh=D7kmI7ZqTiZ6ts/bhw+rSgPI/TFOm4SmI1FYF7OXSzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPXWvagnei3C2N6IKY1VP7QhAF7c4tIiFf5AYeRAnxKhdDdTvLTDswRjictbVoxYf
         Bz7qVPSMPGp8IyhuFPPqXRe1m1Pr2SBa+kEwTGUt/vPTavIu0oT5FVa5KjAOa73aNs
         +fEMsZdNqVYtj10OpD87B8mBVZSFBrSbky/SQyUw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Date:   Fri, 28 Aug 2020 21:30:06 +0900
Message-Id: <159861780638.992023.16486601398173945135.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159861759775.992023.12553306821235086809.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The kretprobe hash is mostly superfluous, replace it with a per-task
variable.

This gets rid of the task hash and it's related locking.

The whole invalidate_rp_inst() is tedious and could go away once we
drop rp specific ri size.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
  Changes:
    - [MH] ported on Masami's latest version
    - [MH] remove unneeded last node checking and unused variables
    - [MH] Fix to remove unneeded hlist_del from recycle_rp_inst()
---
 include/linux/kprobes.h |    1 
 include/linux/sched.h   |    4 +
 kernel/fork.c           |    4 +
 kernel/kprobes.c        |  232 ++++++++++++++++++-----------------------------
 4 files changed, 100 insertions(+), 141 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9c880c8a4e80..a30cccb07f21 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -157,6 +157,7 @@ struct kretprobe {
 
 struct kretprobe_instance {
 	union {
+		struct llist_node llist;
 		struct hlist_node hlist;
 		struct rcu_head rcu;
 	};
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..0f2532f052a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1315,6 +1315,10 @@ struct task_struct {
 	struct callback_head		mce_kill_me;
 #endif
 
+#ifdef CONFIG_KRETPROBES
+	struct llist_head               kretprobe_instances;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..2ff5cceb0732 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2161,6 +2161,10 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 
+#ifdef CONFIG_KRETPROBES
+	p->kretprobe_instances.first = NULL;
+#endif
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted the the new process's css_set can be changed
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d0b4b7e89fa6..5904ce656ab7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -53,7 +53,6 @@ static int kprobes_initialized;
  * - RCU hlist traversal under disabling preempt (breakpoint handlers)
  */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
-static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
 /* NOTE: change this value only with kprobe_mutex held */
 static bool kprobes_all_disarmed;
@@ -61,9 +60,6 @@ static bool kprobes_all_disarmed;
 /* This protects kprobe_table and optimizing_list */
 static DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
-static struct {
-	raw_spinlock_t lock ____cacheline_aligned_in_smp;
-} kretprobe_table_locks[KPROBE_TABLE_SIZE];
 
 kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 					unsigned int __unused)
@@ -71,11 +67,6 @@ kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
 }
 
-static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
-{
-	return &(kretprobe_table_locks[hash].lock);
-}
-
 /* Blacklist -- list of struct kprobe_blacklist_entry */
 static LIST_HEAD(kprobe_blacklist);
 
@@ -1227,8 +1218,6 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = ri->rp;
 
-	/* remove rp inst off the rprobe_inst_table */
-	hlist_del(&ri->hlist);
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
 		raw_spin_lock(&rp->lock);
@@ -1239,49 +1228,6 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-static void kretprobe_hash_lock(struct task_struct *tsk,
-			 struct hlist_head **head, unsigned long *flags)
-__acquires(hlist_lock)
-{
-	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
-
-	*head = &kretprobe_inst_table[hash];
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_hash_lock);
-
-static void kretprobe_table_lock(unsigned long hash,
-				 unsigned long *flags)
-__acquires(hlist_lock)
-{
-	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_table_lock);
-
-static void kretprobe_hash_unlock(struct task_struct *tsk,
-			   unsigned long *flags)
-__releases(hlist_lock)
-{
-	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
-	raw_spinlock_t *hlist_lock;
-
-	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_hash_unlock);
-
-static void kretprobe_table_unlock(unsigned long hash,
-				   unsigned long *flags)
-__releases(hlist_lock)
-{
-	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
-}
-NOKPROBE_SYMBOL(kretprobe_table_unlock);
-
 static struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
 };
@@ -1311,24 +1257,23 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head *head;
-	struct hlist_node *tmp;
-	unsigned long hash, flags = 0;
+	struct llist_node *node;
 
+	/* Early boot, not yet initialized. */
 	if (unlikely(!kprobes_initialized))
-		/* Early boot.  kretprobe_table_locks not yet initialized. */
 		return;
 
 	kprobe_busy_begin();
 
-	hash = hash_ptr(tk, KPROBE_HASH_BITS);
-	head = &kretprobe_inst_table[hash];
-	kretprobe_table_lock(hash, &flags);
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task == tk)
-			recycle_rp_inst(ri);
+	node = current->kretprobe_instances.first;
+	current->kretprobe_instances.first = NULL;
+
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		recycle_rp_inst(ri);
 	}
-	kretprobe_table_unlock(hash, &flags);
 
 	kprobe_busy_end();
 }
@@ -1345,24 +1290,70 @@ static inline void free_rp_inst(struct kretprobe *rp)
 	}
 }
 
-static void cleanup_rp_inst(struct kretprobe *rp)
+/* XXX all of this only exists because we have rp specific ri's */
+
+static bool __invalidate_rp_inst(struct task_struct *t, void *rp)
 {
-	unsigned long flags, hash;
+	struct llist_node *node = t->kretprobe_instances.first;
 	struct kretprobe_instance *ri;
-	struct hlist_node *next;
-	struct hlist_head *head;
+
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		if (ri->rp == rp)
+			ri->rp = NULL;
+	}
+
+	return true;
+}
+
+struct invl_rp_ipi {
+	struct task_struct *task;
+	void *rp;
+	bool done;
+};
+
+static void __invalidate_rp_ipi(void *arg)
+{
+	struct invl_rp_ipi *iri = arg;
+
+	if (iri->task == current)
+		iri->done = __invalidate_rp_inst(iri->task, iri->rp);
+}
+
+static void invalidate_rp_inst(struct task_struct *t, struct kretprobe *rp)
+{
+	struct invl_rp_ipi iri = {
+		.task = t,
+		.rp = rp,
+		.done = false
+	};
+
+	for (;;) {
+		if (try_invoke_on_locked_down_task(t, __invalidate_rp_inst, rp))
+			return;
+
+		smp_call_function_single(task_cpu(t), __invalidate_rp_ipi, &iri, 1);
+		if (iri.done)
+			return;
+	}
+}
+
+static void cleanup_rp_inst(struct kretprobe *rp)
+{
+	struct task_struct *p, *t;
 
 	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
 	kprobe_busy_begin();
-	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
-		kretprobe_table_lock(hash, &flags);
-		head = &kretprobe_inst_table[hash];
-		hlist_for_each_entry_safe(ri, next, head, hlist) {
-			if (ri->rp == rp)
-				ri->rp = NULL;
-		}
-		kretprobe_table_unlock(hash, &flags);
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if (!t->kretprobe_instances.first)
+			continue;
+
+		invalidate_rp_inst(t, rp);
 	}
+	rcu_read_unlock();
 	kprobe_busy_end();
 
 	free_rp_inst(rp);
@@ -1928,70 +1919,39 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *trampoline_address,
 					     void *frame_pointer)
 {
-	struct kretprobe_instance *ri = NULL, *last = NULL;
-	struct hlist_head *head;
-	struct hlist_node *tmp;
-	unsigned long flags;
 	kprobe_opcode_t *correct_ret_addr = NULL;
-	bool skipped = false;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node;
 
-	kretprobe_hash_lock(current, &head, &flags);
+	first = node = current->kretprobe_instances.first;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
 
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * return probes installed on them, and/or more than one
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always pushed into the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *	 function, the (chronologically) first instance's ret_addr
-	 *	 will be the real return address, and all the rest will
-	 *	 point to kretprobe_trampoline.
-	 */
-	hlist_for_each_entry(ri, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		/*
-		 * Return probes must be pushed on this hash list correct
-		 * order (same as return order) so that it can be popped
-		 * correctly. However, if we find it is pushed it incorrect
-		 * order, this means we find a function which should not be
-		 * probed, because the wrong order entry is pushed on the
-		 * path of processing other kretprobe itself.
-		 */
-		if (ri->fp != frame_pointer) {
-			if (!skipped)
-				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
-			skipped = true;
-			continue;
-		}
+		BUG_ON(ri->fp != frame_pointer);
 
 		correct_ret_addr = ri->ret_addr;
-		if (skipped)
-			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
-				ri->rp->kp.addr);
-
-		if (correct_ret_addr != trampoline_address)
+		if (correct_ret_addr != trampoline_address) {
 			/*
 			 * This is the real return address. Any other
 			 * instances associated with this task are for
 			 * other calls deeper on the call stack
 			 */
 			break;
+		}
+
+		node = node->next;
 	}
 
 	BUG_ON(!correct_ret_addr || (correct_ret_addr == trampoline_address));
-	last = ri;
 
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		if (ri->fp != frame_pointer)
-			continue;
+	/* Unlink all nodes for this frame. */
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
+
+	/* Run them..  */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		node = first->next;
 
 		if (ri->rp && ri->rp->handler) {
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
@@ -2002,12 +1962,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 
 		recycle_rp_inst(ri);
 
-		if (ri == last)
-			break;
+		first = node;
 	}
 
-	kretprobe_hash_unlock(current, &flags);
-
 	return (unsigned long)correct_ret_addr;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
@@ -2019,11 +1976,10 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long hash, flags = 0;
+	unsigned long flags = 0;
 	struct kretprobe_instance *ri;
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	hash = hash_ptr(current, KPROBE_HASH_BITS);
 	raw_spin_lock_irqsave(&rp->lock, flags);
 	if (!hlist_empty(&rp->free_instances)) {
 		ri = hlist_entry(rp->free_instances.first,
@@ -2043,11 +1999,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 		arch_prepare_kretprobe(ri, regs);
 
-		/* XXX(hch): why is there no hlist_move_head? */
-		INIT_HLIST_NODE(&ri->hlist);
-		kretprobe_table_lock(hash, &flags);
-		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
-		kretprobe_table_unlock(hash, &flags);
+		__llist_add(&ri->llist, &current->kretprobe_instances);
+
 	} else {
 		rp->nmissed++;
 		raw_spin_unlock_irqrestore(&rp->lock, flags);
@@ -2532,11 +2485,8 @@ static int __init init_kprobes(void)
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
-	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);
-		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
-		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
-	}
 
 	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
 					__stop_kprobe_blacklist);

