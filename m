Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D413254A97
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0QV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgH0QVe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6630C061264;
        Thu, 27 Aug 2020 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xShAjRSFX4gTNPnTyut+wXOcY50KHO2ij46JyYKWl7s=; b=s+acmN68NlsJ7VJZFnu8bEhulc
        7TSh3iarzVawjmmVbis4wLeopRIzWIspPmUV0SxMmyAApDKu1arSDq6hXLHce1ruS5xjlI11DZ92x
        YWrT/99jIa+gvIewUZJwJQJkCR7Y1ChZbz8dQipLkIbUUwGoovvqkOzxBYIuAjj5+/jAtHIWndxWc
        +iYXsUq8Hlp3B7BKru7rjQJ1zW02aB4ZbdAIMKGLW0K1rv8Wa5NncmSXByNXBajZMnZccnnR1OXJM
        IR0gCTqw3AzvBUI3wj9Dw82q5gMar8GX0MEQruQ8SjuM/bQMNTcPVFtgUEs3v33svNRkG8zXhZQXm
        xlZzuSGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0003xn-B0; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B11823003E5;
        Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 79FFE2C2868F5; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.359432340@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kretprobe hash is mostly superfluous, replace it with a per-task
variable.

This gets rid of the task hash and it's related locking.

The whole invalidate_rp_inst() is tedious and could go away once we
drop rp specific ri size.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/kprobes.h |    5 -
 include/linux/sched.h   |    4 
 kernel/fork.c           |    4 
 kernel/kprobes.c        |  239 +++++++++++++++++++-----------------------------
 4 files changed, 110 insertions(+), 142 deletions(-)

--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -156,7 +156,10 @@ struct kretprobe {
 };
 
 struct kretprobe_instance {
-	struct hlist_node hlist;
+	union {
+		struct llist_node llist;
+		struct hlist_node hlist;
+	};
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
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
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2161,6 +2161,10 @@ static __latent_entropy struct task_stru
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 
+#ifdef CONFIG_KRETPROBES
+	p->kretprobe_instances.first = NULL;
+#endif
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted the the new process's css_set can be changed
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
@@ -71,11 +67,6 @@ kprobe_opcode_t * __weak kprobe_lookup_n
 	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
 }
 
-static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
-{
-	return &(kretprobe_table_locks[hash].lock);
-}
-
 /* Blacklist -- list of struct kprobe_blacklist_entry */
 static LIST_HEAD(kprobe_blacklist);
 
@@ -1241,49 +1232,6 @@ void recycle_rp_inst(struct kretprobe_in
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-void kretprobe_hash_lock(struct task_struct *tsk,
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
-void kretprobe_hash_unlock(struct task_struct *tsk,
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
 struct kprobe kprobe_busy = {
 	.addr = (void *) get_kprobe,
 };
@@ -1313,25 +1261,28 @@ void kprobe_busy_end(void)
 void kprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_head *head, empty_rp;
+	struct hlist_head empty_rp;
+	struct llist_node *node;
 	struct hlist_node *tmp;
-	unsigned long hash, flags = 0;
 
+	/* Early boot, not yet initialized. */
 	if (unlikely(!kprobes_initialized))
-		/* Early boot.  kretprobe_table_locks not yet initialized. */
 		return;
 
+	INIT_HLIST_HEAD(&empty_rp);
+
 	kprobe_busy_begin();
 
-	INIT_HLIST_HEAD(&empty_rp);
-	hash = hash_ptr(tk, KPROBE_HASH_BITS);
-	head = &kretprobe_inst_table[hash];
-	kretprobe_table_lock(hash, &flags);
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task == tk)
-			recycle_rp_inst(ri, &empty_rp);
+	node = current->kretprobe_instances.first;
+	current->kretprobe_instances.first = NULL;
+
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		node = node->next;
+
+		recycle_rp_inst(ri, &empty_rp);
 	}
-	kretprobe_table_unlock(hash, &flags);
+
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
@@ -1352,24 +1303,70 @@ static inline void free_rp_inst(struct k
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
@@ -1935,71 +1932,45 @@ unsigned long __kretprobe_trampoline_han
 					unsigned long trampoline_address,
 					void *frame_pointer)
 {
+	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
+	unsigned long orig_ret_address = 0;
+	struct llist_node *first, *node;
+	struct hlist_head empty_rp;
 	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-	bool skipped = false;
 
 	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
 
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
+	first = node = current->kretprobe_instances.first;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
 
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (skipped)
-			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
-				ri->rp->kp.addr);
+		BUG_ON(ri->fp != frame_pointer);
 
-		if (orig_ret_address != trampoline_address)
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (orig_ret_address != trampoline_address) {
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
 
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
 	correct_ret_addr = ri->ret_addr;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		if (ri->fp != frame_pointer)
-			continue;
+
+	/* Unlink all nodes for this frame. */
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
+
+	/* Run them..  */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		node = first->next;
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
@@ -2011,17 +1982,9 @@ unsigned long __kretprobe_trampoline_han
 
 		recycle_rp_inst(ri, &empty_rp);
 
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
+		first = node;
 	}
 
-	kretprobe_hash_unlock(current, &flags);
-
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
@@ -2062,11 +2025,8 @@ static int pre_handler_kretprobe(struct
 
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
@@ -2551,11 +2511,8 @@ static int __init init_kprobes(void)
 
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


