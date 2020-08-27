Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11E3254ADA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH0QjI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0QjF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:39:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE4222CAF;
        Thu, 27 Aug 2020 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546344;
        bh=a53s03/cPo3kGGIvcEKsX4Gu6pujg3VH4StzRxGCLLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oupgSttW/OKDJ1JAWWQ6nR1CS6vzGAgyqRbjoHpFwOVshkcQKuat65vY2Qm3Pj7Np
         Zrl2qswx31oYaSWys8upTY/u/+RKIoViuV7u7hPLzEX8D4qyT/1A+MbRhnX9F7PtxE
         TGK7HuLYu7C9iuWjNxxOufrlerumtrtwFE6ed/KE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 03/16] arm: kprobes: Use generic kretprobe trampoline handler
Date:   Fri, 28 Aug 2020 01:39:01 +0900
Message-Id: <159854634148.736475.14725979991727128705.stgit@devnote2>
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

Use the generic kretprobe trampoline handler. Use regs->ARM_fp
for framepointer verification.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Fix to cast frame_pointer type to void *.
---
 arch/arm/probes/kprobes/core.c |   79 ++--------------------------------------
 1 file changed, 4 insertions(+), 75 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index feefa2055eba..292d18975348 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -413,87 +413,16 @@ void __naked __kprobes kretprobe_trampoline(void)
 /* Called from kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
-	kprobe_opcode_t *correct_ret_addr = NULL;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because multiple functions in the call path have
-	 * a return probe installed on them, and/or more than one return
-	 * probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always inserted at the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *       function, the first instance's ret_addr will point to the
-	 *       real return address, and all the rest will point to
-	 *       kretprobe_trampoline
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
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
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
-			ri->ret_addr = correct_ret_addr;
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
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
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
-	return (void *)orig_ret_address;
+	return (void *)kretprobe_trampoline_handler(regs,
+				(unsigned long)&kretprobe_trampoline,
+				(void *)regs->ARM_fp);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
+	ri->fp = (void *)regs->ARM_fp;
 
 	/* Replace the return addr with trampoline addr. */
 	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;

