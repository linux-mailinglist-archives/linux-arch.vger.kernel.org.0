Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638DA254AD9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgH0Qi5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgH0Qi5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:38:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D342177B;
        Thu, 27 Aug 2020 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546336;
        bh=9Irw1T+WoacOLgUQZ9tgTmiTchNK9xM2KQJrv7RPSuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zQ7e68SMRk9SffPPc+A3sQBb6NCVOsO+7nmMTZd6C1Egqrnn6WeF46e7umABAbMY
         Mt8pGQmqOh0X9uxXcQskgvLlIdZ4RkT5nPLHibSYoStZ+KZUBE98ref/Vif4b5rG8S
         7LKPjc3HKoKzV0Gv4kuHSR/kUvoFySqOB6Su/EZI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 02/16] x86/kprobes: Use generic kretprobe trampoline handler
Date:   Fri, 28 Aug 2020 01:38:52 +0900
Message-Id: <159854633260.736475.6150536825710984256.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159854631442.736475.5062989489155389472.stgit@devnote2>
References: <159854631442.736475.5062989489155389472.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |  109 +---------------------------------------
 1 file changed, 4 insertions(+), 105 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fdadc37d72af..7c6473a12cee 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -767,124 +767,23 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
+
 /*
  * Called from kretprobe_trampoline
  */
 __used __visible void *trampoline_handler(struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-	void *frame_pointer;
-	bool skipped = false;
-
-	/*
-	 * Set a dummy kprobe for avoiding kretprobe recursion.
-	 * Since kretprobe never run in kprobe handler, kprobe must not
-	 * be running at this point.
-	 */
-	kprobe_busy_begin();
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
 	regs->cs = __KERNEL_CS;
 #ifdef CONFIG_X86_32
 	regs->cs |= get_kernel_rpl();
 	regs->gs = 0;
 #endif
-	/* We use pt_regs->sp for return address holder. */
-	frame_pointer = &regs->sp;
-	regs->ip = trampoline_address;
+	regs->ip = (unsigned long)&kretprobe_trampoline;
 	regs->orig_ax = ~0UL;
 
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
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (skipped)
-			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
-				ri->rp->kp.addr);
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	correct_ret_addr = ri->ret_addr;
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-		if (ri->fp != frame_pointer)
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, &kprobe_busy);
-		}
-
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_hash_unlock(current, &flags);
-
-	kprobe_busy_end();
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-	return (void *)orig_ret_address;
+	return (void *)kretprobe_trampoline_handler(regs,
+			(unsigned long)&kretprobe_trampoline, &regs->sp);
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 

