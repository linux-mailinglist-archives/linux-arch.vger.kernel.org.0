Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643CA2567C1
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgH2NGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgH2NDb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:03:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16A5208A9;
        Sat, 29 Aug 2020 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706209;
        bh=OVF67VfyRqN/asmdbE1JwX6LJm1kVhn8aKan+czXHIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTDcNB3EMCI71AKkVoJ4S/0NG0phGY935eCw73t/GLAM0KX22weAU+f1fISigKbbj
         /I/lO0thJpcs/6xAs9M8H8Boa5rJTaZgJGCURGa+SCEd+j6uakcX7uD/PH+Q5nySNW
         Pvx1DqyPKGAIJPezruNr9XyLHieHN2YdE3ittMw8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 18/21] kprobes: Remove kretprobe hash
Date:   Sat, 29 Aug 2020 22:03:24 +0900
Message-Id: <159870620431.1229682.16325792502413731312.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159870598914.1229682.15230803449082078353.stgit@devnote2>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
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


Note that this may change the kprobes module-exported API for kretprobe
handlers. If any out-of-tree kretprobe user uses ri->rp, use
get_kretprobe(ri) instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v5:
    - Fix not to flush current task's kretprobe_instance
    - Remove task scan by merging kretprobe_holder patch
    - Use READ_ONCE() and rcu_locked check instead of smp_r/wmb()
    - Make the failure case in __kretprobe_trampoline_handler() clearer
---
 include/linux/kprobes.h     |   19 +++
 include/linux/sched.h       |    4 +
 kernel/fork.c               |    4 +
 kernel/kprobes.c            |  236 +++++++++++++------------------------------
 kernel/trace/trace_kprobe.c |    3 -
 5 files changed, 97 insertions(+), 169 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9c880c8a4e80..f8f87a13345a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
+#include <linux/refcount.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -144,6 +145,11 @@ static inline int kprobe_ftrace(struct kprobe *p)
  * ignored, due to maxactive being too low.
  *
  */
+struct kretprobe_holder {
+	struct kretprobe	*rp;
+	refcount_t		ref;
+};
+
 struct kretprobe {
 	struct kprobe kp;
 	kretprobe_handler_t handler;
@@ -152,17 +158,18 @@ struct kretprobe {
 	int nmissed;
 	size_t data_size;
 	struct hlist_head free_instances;
+	struct kretprobe_holder *rph;
 	raw_spinlock_t lock;
 };
 
 struct kretprobe_instance {
 	union {
+		struct llist_node llist;
 		struct hlist_node hlist;
 		struct rcu_head rcu;
 	};
-	struct kretprobe *rp;
+	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
-	struct task_struct *task;
 	void *fp;
 	char data[];
 };
@@ -221,6 +228,14 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 	return ret;
 }
 
+static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+		"Kretprobe is accessed from instance under preemptive context");
+
+	return READ_ONCE(ri->rph->rp);
+}
+
 #else /* CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
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
index 732a70163584..bc65603fce00 100644
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
 
@@ -1223,65 +1214,30 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 
+static void free_rp_inst_rcu(struct rcu_head *head)
+{
+	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+
+	if (refcount_dec_and_test(&ri->rph->ref))
+		kfree(ri->rph);
+	kfree(ri);
+}
+NOKPROBE_SYMBOL(free_rp_inst_rcu);
+
 static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
-	struct kretprobe *rp = ri->rp;
+	struct kretprobe *rp = get_kretprobe(ri);
 
-	/* remove rp inst off the rprobe_inst_table */
-	hlist_del(&ri->hlist);
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
 		raw_spin_lock(&rp->lock);
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
 	} else
-		kfree_rcu(ri, rcu);
+		call_rcu(&ri->rcu, free_rp_inst_rcu);
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
@@ -1311,24 +1267,21 @@ void kprobe_busy_end(void)
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
+	node = __llist_del_all(&tk->kretprobe_instances);
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		recycle_rp_inst(ri);
 	}
-	kretprobe_table_unlock(hash, &flags);
 
 	kprobe_busy_end();
 }
@@ -1338,36 +1291,19 @@ static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
 	struct hlist_node *next;
+	int count = 0;
 
 	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
+		count++;
 	}
-}
-
-static void cleanup_rp_inst(struct kretprobe *rp)
-{
-	unsigned long flags, hash;
-	struct kretprobe_instance *ri;
-	struct hlist_node *next;
-	struct hlist_head *head;
 
-	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
-	kprobe_busy_begin();
-	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
-		kretprobe_table_lock(hash, &flags);
-		head = &kretprobe_inst_table[hash];
-		hlist_for_each_entry_safe(ri, next, head, hlist) {
-			if (ri->rp == rp)
-				ri->rp = NULL;
-		}
-		kretprobe_table_unlock(hash, &flags);
+	if (refcount_sub_and_test(count, &rp->rph->ref)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
 	}
-	kprobe_busy_end();
-
-	free_rp_inst(rp);
 }
-NOKPROBE_SYMBOL(cleanup_rp_inst);
 
 /* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
@@ -1928,88 +1864,56 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
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
+	struct kretprobe *rp;
 
-	kretprobe_hash_lock(current, &head, &flags);
+	/* Find all nodes for this frame. */
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
 
-		correct_ret_addr = ri->ret_addr;
-		if (skipped)
-			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
-				ri->rp->kp.addr);
-
-		if (correct_ret_addr != trampoline_address)
+		if (ri->ret_addr != trampoline_address) {
+			correct_ret_addr = ri->ret_addr;
 			/*
 			 * This is the real return address. Any other
 			 * instances associated with this task are for
 			 * other calls deeper on the call stack
 			 */
-			break;
+			goto found;
+		}
+
+		node = node->next;
 	}
+	pr_err("Oops! Kretprobe fails to find correct return address.\n");
+	BUG_ON(1);
 
-	BUG_ON(!correct_ret_addr || (correct_ret_addr == trampoline_address));
-	last = ri;
+found:
+	/* Unlink all nodes for this frame. */
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
 
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		if (ri->fp != frame_pointer)
-			continue;
+	/* Run them..  */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		first = first->next;
 
-		if (ri->rp && ri->rp->handler) {
+		rp = get_kretprobe(ri);
+		if (rp && rp->handler) {
 			struct kprobe *prev = kprobe_running();
 
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			__this_cpu_write(current_kprobe, &rp->kp);
 			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
+			rp->handler(ri, regs);
 			__this_cpu_write(current_kprobe, prev);
 		}
 
 		recycle_rp_inst(ri);
-
-		if (ri == last)
-			break;
 	}
 
-	kretprobe_hash_unlock(current, &flags);
-
 	return (unsigned long)correct_ret_addr;
 }
 NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
@@ -2021,11 +1925,10 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
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
@@ -2033,9 +1936,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 		hlist_del(&ri->hlist);
 		raw_spin_unlock_irqrestore(&rp->lock, flags);
 
-		ri->rp = rp;
-		ri->task = current;
-
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
 			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
@@ -2045,11 +1945,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
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
@@ -2112,16 +2009,24 @@ int register_kretprobe(struct kretprobe *rp)
 	}
 	raw_spin_lock_init(&rp->lock);
 	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
+	if (!rp->rph)
+		return -ENOMEM;
+
+	rp->rph->rp = rp;
 	for (i = 0; i < rp->maxactive; i++) {
-		inst = kmalloc(sizeof(struct kretprobe_instance) +
+		inst = kzalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
 		if (inst == NULL) {
+			refcount_set(&rp->rph->ref, i);
 			free_rp_inst(rp);
 			return -ENOMEM;
 		}
+		inst->rph = rp->rph;
 		INIT_HLIST_NODE(&inst->hlist);
 		hlist_add_head(&inst->hlist, &rp->free_instances);
 	}
+	refcount_set(&rp->rph->ref, i);
 
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
@@ -2163,16 +2068,18 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	if (num <= 0)
 		return;
 	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
+		rps[i]->rph->rp = NULL;
+	}
 	mutex_unlock(&kprobe_mutex);
 
 	synchronize_rcu();
 	for (i = 0; i < num; i++) {
 		if (rps[i]->kp.addr) {
 			__unregister_kprobe_bottom(&rps[i]->kp);
-			cleanup_rp_inst(rps[i]);
+			free_rp_inst(rps[i]);
 		}
 	}
 }
@@ -2534,11 +2441,8 @@ static int __init init_kprobes(void)
 
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
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..07baf6f6cecc 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1714,7 +1714,8 @@ NOKPROBE_SYMBOL(kprobe_dispatcher);
 static int
 kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
-	struct trace_kprobe *tk = container_of(ri->rp, struct trace_kprobe, rp);
+	struct kretprobe *rp = get_kretprobe(ri);
+	struct trace_kprobe *tk = container_of(rp, struct trace_kprobe, rp);
 
 	raw_cpu_inc(*tk->nhit);
 

