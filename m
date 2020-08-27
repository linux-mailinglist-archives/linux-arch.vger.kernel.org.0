Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C6254A8F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgH0QVf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgH0QVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED6C061232;
        Thu, 27 Aug 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TKUTpgaYeFSVFlZdxt1lx7PxLZWFqnGdPsP/GEA9Nv4=; b=ch65GBXjGlzVap8XaWbx4eQlhL
        sSND1j/17jkTY5HTrEd7DNnn7lod5sjlAUCm0bxQCdgM7sJFDgyW3exYdfagJP5q162SuJVvLyRSZ
        254WlCq6yy9M3Iyh1DSYrUlR0it5I0P9cPwyI3oGlWgVH/TdPhjVkGsKN+V1vmqbznSZ2THTv5q47
        y7kxUzSvSDo/XCQX5v2zPCRQMKqYLwB8zWBpA5XHWdWT0qSvaH6cXHgTO45W8kydabW0sdcfK3tKE
        gRRLsa5Y/C5KgBRaH0Le3OB8o7+Q1ylwB4lkyHmaOS0XQkqc3sVCq0TaxHhvLQs2mEWz94HkikjJW
        Y9dubbSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0001WT-CN; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34658307865;
        Thu, 27 Aug 2020 18:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 864DA2C2868F8; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.535381269@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 6/7] freelist: Lock less freelist
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Cc: cameron@moodycamel.com
Cc: oleg@redhat.com
Cc: will@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/freelist.h |  129 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

--- /dev/null
+++ b/include/linux/freelist.h
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+#ifndef FREELIST_H
+#define FREELIST_H
+
+#include <linux/atomic.h>
+
+/*
+ * Copyright: cameron@moodycamel.com
+ *
+ * A simple CAS-based lock-free free list. Not the fastest thing in the world
+ * under heavy contention, but simple and correct (assuming nodes are never
+ * freed until after the free list is destroyed), and fairly speedy under low
+ * contention.
+ *
+ * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ */
+
+struct freelist_node {
+	atomic_t		refs;
+	struct freelist_node	*next;
+};
+
+struct freelist_head {
+	struct freelist_node	*head;
+};
+
+#define REFS_ON_FREELIST 0x80000000
+#define REFS_MASK	 0x7FFFFFFF
+
+static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * Since the refcount is zero, and nobody can increase it once it's
+	 * zero (except us, and we run only one copy of this method per node at
+	 * a time, i.e. the single thread case), then we know we can safely
+	 * change the next pointer of the node; however, once the refcount is
+	 * back above zero, then other threads could increase it (happens under
+	 * heavy contention, when the refcount goes to zero in between a load
+	 * and a refcount increment of a node in try_get, then back up to
+	 * something non-zero, then the refcount increment is done by the other
+	 * thread) -- so if the CAS to add the node to the actual list fails,
+	 * decrese the refcount and leave the add operation to the next thread
+	 * who puts the refcount back to zero (which could be us, hence the
+	 * loop).
+	 */
+	struct freelist_node *head = READ_ONCE(list->head);
+
+	for (;;) {
+		WRITE_ONCE(node->next, head);
+		atomic_set_release(&node->refs, 1);
+
+		if (!try_cmpxchg_release(&list->head, &head, node)) {
+			/*
+			 * Hmm, the add failed, but we can only try again when
+			 * the refcount goes back to zero.
+			 */
+			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
+				continue;
+		}
+		return;
+	}
+}
+
+static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * We know that the should-be-on-freelist bit is 0 at this point, so
+	 * it's safe to set it using a fetch_add.
+	 */
+	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
+		/*
+		 * Oh look! We were the last ones referencing this node, and we
+		 * know we want to add it to the free list, so let's do it!
+		 */
+		__freelist_add(node, list);
+	}
+}
+
+static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
+{
+	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
+	unsigned int refs;
+
+	while (head) {
+		prev = head;
+		refs = atomic_read(&head->refs);
+		if ((refs & REFS_MASK) == 0 ||
+		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
+			head = smp_load_acquire(&list->head);
+			continue;
+		}
+
+		/*
+		 * Good, reference count has been incremented (it wasn't at
+		 * zero), which means we can read the next and not worry about
+		 * it changing between now and the time we do the CAS.
+		 */
+		next = READ_ONCE(head->next);
+		if (try_cmpxchg_acquire(&list->head, &head, next)) {
+			/*
+			 * Yay, got the node. This means it was on the list,
+			 * which means should-be-on-freelist must be false no
+			 * matter the refcount (because nobody else knows it's
+			 * been taken off yet, it can't have been put back on).
+			 */
+			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
+
+			/*
+			 * Decrease refcount twice, once for our ref, and once
+			 * for the list's ref.
+			 */
+			atomic_fetch_add(-2, &head->refs);
+
+			return head;
+		}
+
+		/*
+		 * OK, the head must have changed on us, but we still need to decrement
+		 * the refcount we increased.
+		 */
+		refs = atomic_fetch_add(-1, &prev->refs);
+		if (refs == REFS_ON_FREELIST + 1)
+			__freelist_add(prev, list);
+	}
+
+	return NULL;
+}
+
+#endif /* FREELIST_H */


