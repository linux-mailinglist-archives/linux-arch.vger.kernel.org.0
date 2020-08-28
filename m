Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18AD255A2B
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgH1Mbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgH1Map (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:30:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CD9208CA;
        Fri, 28 Aug 2020 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617844;
        bh=+Q2qs+5oSv+DDSatfvwe0sYEk5sx3ecNkoK1/NfZIcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gybdkboo0nskR4nxTpS3xfKAb7IgticLu1ih7OFemobMBTGWQY/pwuR34101XhM44
         LYe0Aluzg8baqQwj+Fd/hkXi/mBqLBUDR4Uni7psMApHrxSqUI/EaPwYojMRQAh7ZN
         LnUFpsFyl7k9vxjmuITRiYSB09wI2rT8uGNOrSLc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 22/23] freelist: Lock less freelist
Date:   Fri, 28 Aug 2020 21:30:39 +0900
Message-Id: <159861783901.992023.12163347531003713154.stgit@devnote2>
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

Cc: cameron@moodycamel.com
Cc: oleg@redhat.com
Cc: will@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/freelist.h |  129 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 include/linux/freelist.h

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
new file mode 100644
index 000000000000..fc1842b96469
--- /dev/null
+++ b/include/linux/freelist.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
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

