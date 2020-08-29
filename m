Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9A2567A8
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgH2NBJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgH2NAJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:00:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35A0207BB;
        Sat, 29 Aug 2020 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706007;
        bh=n7kOG/tjgYad4J+bPulurawDy3ip1raaRalhCp8OV9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsEAc7407Lbn26iA2RPOkLRXU4OKRPvfplfRm2+/PPABLYwSd2BhhYqyBnd2WgXi3
         XncHuMviQb/pbf6xRbrR7NQi0qZZgpc5Va5y6ALv2TOJqnH52M2sbxCJLU2IQtKxAM
         KfXwpdwGKkKPVwkXfW25+npPBVQoEdXckUXKNhEA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 01/21] kprobes: Add generic kretprobe trampoline handler
Date:   Sat, 29 Aug 2020 22:00:01 +0900
Message-Id: <159870600138.1229682.3424065380448088833.stgit@devnote2>
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

Add a generic kretprobe trampoline handler for unifying
the all cloned /arch/* kretprobe trampoline handlers.

The generic kretprobe trampoline handler is based on the
x86 implementation, because it is the latest implementation.
It has frame pointer checking, kprobe_busy_begin/end and
return address fixup for user handlers.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
   - Restore actual current_kprobe instead of kprobe_busy.
 Changes in v4:
   - Remove orig_ret_address
   - Change the type of trampoline_address to void *
---
 include/linux/kprobes.h |   32 +++++++++++++--
 kernel/kprobes.c        |   98 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..c6a913e608b7 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -187,10 +187,38 @@ static inline int kprobes_built_in(void)
 	return 1;
 }
 
+extern struct kprobe kprobe_busy;
+void kprobe_busy_begin(void);
+void kprobe_busy_end(void);
+
 #ifdef CONFIG_KRETPROBES
 extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
+
+/* If the trampoline handler called from a kprobe, use this version */
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+				void *trampoline_address,
+				void *frame_pointer);
+
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+				void *trampoline_address,
+				void *frame_pointer)
+{
+	unsigned long ret;
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never runs in kprobe handler, any kprobe must not
+	 * be running at this point.
+	 */
+	kprobe_busy_begin();
+	ret = __kretprobe_trampoline_handler(regs, trampoline_address, frame_pointer);
+	kprobe_busy_end();
+
+	return ret;
+}
+
 #else /* CONFIG_KRETPROBES */
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
@@ -354,10 +382,6 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
-extern struct kprobe kprobe_busy;
-void kprobe_busy_begin(void);
-void kprobe_busy_end(void);
-
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..a0afaa79024e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1927,6 +1927,104 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 }
 
 #ifdef CONFIG_KRETPROBES
+
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *trampoline_address,
+					     void *frame_pointer)
+{
+	struct kretprobe_instance *ri = NULL, *last = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags;
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	bool skipped = false;
+
+	INIT_HLIST_HEAD(&empty_rp);
+	kretprobe_hash_lock(current, &head, &flags);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because multiple functions in the call path have
+	 * return probes installed on them, and/or more than one
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always pushed into the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *	 function, the (chronologically) first instance's ret_addr
+	 *	 will be the real return address, and all the rest will
+	 *	 point to kretprobe_trampoline.
+	 */
+	hlist_for_each_entry(ri, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+		/*
+		 * Return probes must be pushed on this hash list correct
+		 * order (same as return order) so that it can be popped
+		 * correctly. However, if we find it is pushed it incorrect
+		 * order, this means we find a function which should not be
+		 * probed, because the wrong order entry is pushed on the
+		 * path of processing other kretprobe itself.
+		 */
+		if (ri->fp != frame_pointer) {
+			if (!skipped)
+				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
+			skipped = true;
+			continue;
+		}
+
+		correct_ret_addr = ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
+
+		if (correct_ret_addr != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, (unsigned long)correct_ret_addr,
+			     (unsigned long)trampoline_address);
+	last = ri;
+
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+		if (ri->fp != frame_pointer)
+			continue;
+
+		if (ri->rp && ri->rp->handler) {
+			struct kprobe *prev = kprobe_running();
+
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			ri->ret_addr = correct_ret_addr;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, prev);
+		}
+
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (ri == last)
+			break;
+	}
+
+	kretprobe_hash_unlock(current, &flags);
+
+	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
+		hlist_del(&ri->hlist);
+		kfree(ri);
+	}
+
+	return (unsigned long)correct_ret_addr;
+}
+NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
+
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.

