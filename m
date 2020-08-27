Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCB254A96
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0QVf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgH0QVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD4C06121B;
        Thu, 27 Aug 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GgRoIsnTQQXi2TCqXFS9fJ4kvAnkTuxT30YeDpib5K8=; b=AcSmB9mOiX3KsGvL3S9DVSH9w1
        XJsBUy3h2oIhJF3srnJAeqEukdr4u7C4oT6XrrqEFSU1BqZR7ClL8G+sAojPP+3LL1v6C9HNcoWFk
        fZWX6LqqL7Ef79a6NTgmGCfvhwH1jtZLdJGlcattMRuwip1V7xoD5lDx+gq4yUJPgbOgF0D6qnwUe
        P2tnU3SGNtQBV75ToBPsKdrx9FLlppd0R+s9kltQem6AqxPWSVhjtg1hOyw8UTNKuVAfHCXe2w6Fd
        /bvYZjb8DB3RiIX8MlIVi21eWJuI1HB8MBhoX7SRcJvm2xZWt9aDw6qCwRvuJfY3uVGVKQakzADEA
        oLFTL1gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0001WU-CH; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34FFA30791E;
        Thu, 27 Aug 2020 18:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 89A632C2868F9; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.594247581@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with freelist
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Gets rid of rp->lock, and as a result kretprobes are now fully
lockless.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/kprobes.h |   11 ++++++--
 kernel/kprobes.c        |   63 +++++++++++++++++++-----------------------------
 2 files changed, 34 insertions(+), 40 deletions(-)

--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -27,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
+#include <linux/freelist.h>
 #include <asm/kprobes.h>
 
 #ifdef CONFIG_KPROBES
@@ -151,14 +152,18 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct hlist_head free_instances;
-	raw_spinlock_t lock;
+	struct freelist_head freelist;
 };
 
 struct kretprobe_instance {
 	union {
+		/*
+		 * Dodgy as heck, this relies on not clobbering freelist::refs.
+		 * llist: only clobbers freelist::next.
+		 * rcu: clobbers both, but only after rp::freelist is gone.
+		 */
+		struct freelist_node freelist;
 		struct llist_node llist;
-		struct hlist_node hlist;
 		struct rcu_head rcu;
 	};
 	struct kretprobe *rp;
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1219,12 +1219,8 @@ static void recycle_rp_inst(struct kretp
 	struct kretprobe *rp = ri->rp;
 
 	/* remove rp inst off the rprobe_inst_table */
-	hlist_del(&ri->hlist);
-	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
-		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
+		freelist_add(&ri->freelist, &rp->freelist);
 	} else {
 		kfree_rcu(ri, rcu);
 	}
@@ -1286,10 +1282,13 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
-	struct hlist_node *next;
+	struct freelist_node *node;
+
+	node = rp->freelist.head;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, freelist);
+		node = node->next;
 
-	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
-		hlist_del(&ri->hlist);
 		kfree(ri);
 	}
 }
@@ -1986,36 +1985,28 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_h
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long hash, flags = 0;
 	struct kretprobe_instance *ri;
+	struct freelist_node *fn;
 
-	/* TODO: consider to only swap the RA after the last pre_handler fired */
-	hash = hash_ptr(current, KPROBE_HASH_BITS);
-	raw_spin_lock_irqsave(&rp->lock, flags);
-	if (!hlist_empty(&rp->free_instances)) {
-		ri = hlist_entry(rp->free_instances.first,
-				struct kretprobe_instance, hlist);
-		hlist_del(&ri->hlist);
-		raw_spin_unlock_irqrestore(&rp->lock, flags);
-
-		ri->rp = rp;
-		ri->task = current;
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
+	ri->rp = rp;
+	ri->task = current;
 
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
@@ -2072,8 +2063,7 @@ int register_kretprobe(struct kretprobe
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	raw_spin_lock_init(&rp->lock);
-	INIT_HLIST_HEAD(&rp->free_instances);
+	rp->freelist.head = NULL;
 	for (i = 0; i < rp->maxactive; i++) {
 		inst = kmalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
@@ -2081,8 +2071,7 @@ int register_kretprobe(struct kretprobe
 			free_rp_inst(rp);
 			return -ENOMEM;
 		}
-		INIT_HLIST_NODE(&inst->hlist);
-		hlist_add_head(&inst->hlist, &rp->free_instances);
+		freelist_add(&inst->freelist, &rp->freelist);
 	}
 
 	rp->nmissed = 0;


