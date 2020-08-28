Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC24255A29
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgH1MbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgH1MbA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:31:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D244120848;
        Fri, 28 Aug 2020 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617854;
        bh=5lzSgZ2xdAht4OeIc7gBPbt2PKptF7RGvnsQijVexP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3DvgiRQPYZsSKf6OCcIgrLkK11PrC5Vfnf//RYDE1AvvwexJLbOwcdBkYNf5szY1
         mFhs3yUE1lbUQYBRbhYQhdxaBlbRtP/T+DmxZRxguSuNYBJYB4i9MiiZEGl1L1nWT3
         jxht0KlAQ5TVY3ajmG7AWOzqmaqSG76H1PpGCVGg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 23/23] kprobes: Replace rp->free_instance with freelist
Date:   Fri, 28 Aug 2020 21:30:49 +0900
Message-Id: <159861784965.992023.10483111122152811370.stgit@devnote2>
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

Gets rid of rp->lock, and as a result kretprobes are now fully
lockless.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Changes
  - [MH] expel the llist from anon union in kretprobe_instance
---
 include/linux/kprobes.h |    8 +++----
 kernel/kprobes.c        |   56 ++++++++++++++++++++---------------------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index d7cdae2d8f2e..aa330bfefefd 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
 #include <linux/refcount.h>
+#include <linux/freelist.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -157,17 +158,16 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
+	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
-	raw_spinlock_t lock;
 };
 
 struct kretprobe_instance {
 	union {
-		struct llist_node llist;
-		struct hlist_node hlist;
+		struct freelist_node freelist;
 		struct rcu_head rcu;
 	};
+	struct llist_node llist;
 	struct kretprobe_holder *rph;
 	kprobe_opcode_t *ret_addr;
 	void *fp;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 95390eb130f4..56cd865877fa 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1228,11 +1228,8 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 
-	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
-		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
+		freelist_add(&ri->freelist, &rp->freelist);
 	} else
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
 }
@@ -1292,11 +1289,14 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_node *next;
+	struct freelist_node *node;
 	int count = 0;
 
-	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
-		hlist_del(&ri->hlist);
+	node = rp->freelist.head;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, freelist);
+		node = node->next;
+
 		kfree(ri);
 		count++;
 	}
@@ -1925,32 +1925,26 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long flags = 0;
 	struct kretprobe_instance *ri;
+	struct freelist_node *fn;
 
-	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	raw_spin_lock_irqsave(&rp->lock, flags);
-	if (!hlist_empty(&rp->free_instances)) {
-		ri = hlist_entry(rp->free_instances.first,
-				struct kretprobe_instance, hlist);
-		hlist_del(&ri->hlist);
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-
-		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			raw_spin_lock_irqsave(&rp->lock, flags);
-			hlist_add_head(&ri->hlist, &rp->free_instances);
-			raw_spin_unlock_irqrestore(&rp->lock, flags);
-			return 0;
-		}
-
-		arch_prepare_kretprobe(ri, regs);
+	fn = freelist_try_get(&rp->freelist);
+	if (!fn) {
+		rp->nmissed++;
+		return 0;
+	}
 
-		__llist_add(&ri->llist, &current->kretprobe_instances);
+	ri = container_of(fn, struct kretprobe_instance, freelist);
 
-	} else {
-		rp->nmissed++;
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
+	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
+		freelist_add(&ri->freelist, &rp->freelist);
+		return 0;
 	}
+
+	arch_prepare_kretprobe(ri, regs);
+
+	__llist_add(&ri->llist, &current->kretprobe_instances);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
@@ -2007,8 +2001,7 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	raw_spin_lock_init(&rp->lock);
-	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->freelist.head = NULL;
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	rp->rph->rp = rp;
 	for (i = 0; i < rp->maxactive; i++) {
@@ -2020,8 +2013,7 @@ int register_kretprobe(struct kretprobe *rp)
 			return -ENOMEM;
 		}
 		inst->rph = rp->rph;
-		INIT_HLIST_NODE(&inst->hlist);
-		hlist_add_head(&inst->hlist, &rp->free_instances);
+		freelist_add(&inst->freelist, &rp->freelist);
 	}
 	refcount_set(&rp->rph->ref, i);
 

