Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CB2548FD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgH0PS3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 11:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0Lfe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 07:35:34 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F78320738;
        Thu, 27 Aug 2020 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598528133;
        bh=BQJgGx0WZxmBAOL4TvjzTRBHVFKglf3uZbHr3G4N01w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWlBajFQU/x1YISr4rnZGrBesn7WDcSpzDexI2Ckd3qe2iGPPVjnE9X/5HDlaxM0m
         InhPOl4T/IjoNHqOp2Ls8CKNE7LeI+O/vaxSQcSvkrfoRMiGGE8drNREa3AqigQ7XZ
         6/AmhwBtCoDCLU7JEBb9VZh6MbhrBaZbKQWGxw1g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 01/15] kprobes: Add generic kretprobe trampoline handler
Date:   Thu, 27 Aug 2020 20:35:29 +0900
Message-Id: <159852812960.707944.11813912369089948512.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159852811819.707944.12798182250041968537.stgit@devnote2>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
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
 include/linux/kprobes.h |   32 +++++++++++++--
 kernel/kprobes.c        |  101 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..46a7afcf5ec0 100644
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
+				unsigned long trampoline_address,
+				void *frame_pointer);
+
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+				unsigned long trampoline_address,
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
index 287b263c9cb9..cbd2ad1af7b7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1927,6 +1927,107 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 }
 
 #ifdef CONFIG_KRETPROBES
+
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					unsigned long trampoline_address,
+					void *frame_pointer)
+{
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags, orig_ret_address = 0;
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
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+
+	correct_ret_addr = ri->ret_addr;
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+		if (ri->fp != frame_pointer)
+			continue;
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (ri->rp && ri->rp->handler) {
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			ri->ret_addr = correct_ret_addr;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, &kprobe_busy);
+		}
+
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
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
+	return orig_ret_address;
+}
+NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
+
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.

