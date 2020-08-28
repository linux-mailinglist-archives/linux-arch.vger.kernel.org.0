Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E147255A2C
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgH1Mbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbgH1MaY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:30:24 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924912078A;
        Fri, 28 Aug 2020 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617822;
        bh=Kth7oA9/z7aIeMliiNAXh5jGQoUt0y1tn6bQxaHhE/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+uNOPI/9fJWrLt+H3un1AytrLKfC84EZlMLEg6siKjV1i1Y1z6nLknHQZLc92DmN
         S7xbbz5cg2Fl2KF/ajJZTMQT9JO/AoPPuVl/RziZFlSrrWk+yGlR5AzjmsKOYt/6xV
         MyBytatlz2722CIQTcOJ0MdHmdeumpTzL6xSIGzU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 20/23] [RFC] kprobes: Remove task scan for updating kretprobe_instance
Date:   Fri, 28 Aug 2020 21:30:17 +0900
Message-Id: <159861781740.992023.4956784710984854658.stgit@devnote2>
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

Remove task scan for updating kretprobe_instance->rp when unregistering
kretprobe. Instead, this introduces the kretprobe_holder which is a
kretprobe pointer holder with refcount. When we unregister the kretprobe,
we update the pointer value in the holder which means this kretprobe
is already removed. When the used kretprobe instance hits when the target
function return, it will decrement the holder's refcount and if it is
the last one, it will free the holder.

Note that this may change the kprobes module-exported API for kretprobe
handlers. If someone use out-of-tree kretprobe, they have to update
the kretprobe handler to use get_kretprobe(ri) for accessing kretprobe
data structure instead of ri->rp. Also, now we remove ri->task.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h     |   17 ++++++
 kernel/kprobes.c            |  113 +++++++++++++------------------------------
 kernel/trace/trace_kprobe.c |    3 +
 3 files changed, 51 insertions(+), 82 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index a30cccb07f21..d7cdae2d8f2e 100644
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
@@ -152,6 +158,7 @@ struct kretprobe {
 	int nmissed;
 	size_t data_size;
 	struct hlist_head free_instances;
+	struct kretprobe_holder *rph;
 	raw_spinlock_t lock;
 };
 
@@ -161,9 +168,8 @@ struct kretprobe_instance {
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
@@ -222,6 +228,13 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 	return ret;
 }
 
+static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
+{
+	/* rph->rp can be updated by unregister_kretprobe() on other cpu */
+	smp_rmb();
+	return ri->rph->rp;
+}
+
 #else /* CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5904ce656ab7..95390eb130f4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1214,9 +1214,19 @@ void kprobes_inc_nmissed_count(struct kprobe *p)
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
 
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
@@ -1224,7 +1234,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 		hlist_add_head(&ri->hlist, &rp->free_instances);
 		raw_spin_unlock(&rp->lock);
 	} else
-		kfree_rcu(ri, rcu);
+		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1283,83 +1293,20 @@ static inline void free_rp_inst(struct kretprobe *rp)
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
-/* XXX all of this only exists because we have rp specific ri's */
-
-static bool __invalidate_rp_inst(struct task_struct *t, void *rp)
-{
-	struct llist_node *node = t->kretprobe_instances.first;
-	struct kretprobe_instance *ri;
-
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, llist);
-		node = node->next;
 
-		if (ri->rp == rp)
-			ri->rp = NULL;
+	if (refcount_sub_and_test(count, &rp->rph->ref)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
 	}
-
-	return true;
 }
 
-struct invl_rp_ipi {
-	struct task_struct *task;
-	void *rp;
-	bool done;
-};
-
-static void __invalidate_rp_ipi(void *arg)
-{
-	struct invl_rp_ipi *iri = arg;
-
-	if (iri->task == current)
-		iri->done = __invalidate_rp_inst(iri->task, iri->rp);
-}
-
-static void invalidate_rp_inst(struct task_struct *t, struct kretprobe *rp)
-{
-	struct invl_rp_ipi iri = {
-		.task = t,
-		.rp = rp,
-		.done = false
-	};
-
-	for (;;) {
-		if (try_invoke_on_locked_down_task(t, __invalidate_rp_inst, rp))
-			return;
-
-		smp_call_function_single(task_cpu(t), __invalidate_rp_ipi, &iri, 1);
-		if (iri.done)
-			return;
-	}
-}
-
-static void cleanup_rp_inst(struct kretprobe *rp)
-{
-	struct task_struct *p, *t;
-
-	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
-	kprobe_busy_begin();
-	rcu_read_lock();
-	for_each_process_thread(p, t) {
-		if (!t->kretprobe_instances.first)
-			continue;
-
-		invalidate_rp_inst(t, rp);
-	}
-	rcu_read_unlock();
-	kprobe_busy_end();
-
-	free_rp_inst(rp);
-}
-NOKPROBE_SYMBOL(cleanup_rp_inst);
-
 /* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
@@ -1922,6 +1869,7 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
 	struct llist_node *first, *node;
+	struct kretprobe *rp;
 
 	first = node = current->kretprobe_instances.first;
 	while (node) {
@@ -1951,12 +1899,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 	/* Run them..  */
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
+		rp = get_kretprobe(ri);
 		node = first->next;
 
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
+		if (rp && rp->handler) {
+			__this_cpu_write(current_kprobe, &rp->kp);
 			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
+			rp->handler(ri, regs);
 			__this_cpu_write(current_kprobe, &kprobe_busy);
 		}
 
@@ -1987,9 +1936,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 		hlist_del(&ri->hlist);
 		raw_spin_unlock_irqrestore(&rp->lock, flags);
 
-		ri->rp = rp;
-		ri->task = current;
-
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
 			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
@@ -2063,16 +2009,21 @@ int register_kretprobe(struct kretprobe *rp)
 	}
 	raw_spin_lock_init(&rp->lock);
 	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
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
@@ -2114,16 +2065,20 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	if (num <= 0)
 		return;
 	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
+		rps[i]->rph->rp = NULL;
+	}
+	/* Ensure the rph->rp updated after this */
+	smp_wmb();
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
 

