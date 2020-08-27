Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FF254AE7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH0Qjq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgH0Qjk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:39:40 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE1122BEB;
        Thu, 27 Aug 2020 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546379;
        bh=L/e1Ny4hhfpRjK1FA5n+uilobQaA7dHkNtzT1eO2uMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2+phYg0hi1FBbdxOE408XjzGKhtr8eWLNEny+ZQbMq012LpJ7mZ58adini3r7cH7
         gdRxAAlvoGUQekxXMfAcKbmb9Cjr+u7J3xVzA28ovKZFuu7vzszKU3crLQzOchpkB6
         +viXgHshAr1EBkm0h91WPnE+qhI06DIX79eXY8pE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 07/16] ia64: kprobes: Use generic kretprobe trampoline handler
Date:   Fri, 28 Aug 2020 01:39:36 +0900
Message-Id: <159854637638.736475.1629638760103681095.stgit@devnote2>
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
 arch/ia64/kernel/kprobes.c |   79 ++------------------------------------------
 1 file changed, 4 insertions(+), 75 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 7a7df944d798..0e725ca9c60d 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -396,83 +396,11 @@ static void kretprobe_trampoline(void)
 {
 }
 
-/*
- * At this point the target function has been tricked into
- * returning into our trampoline.  Lookup the associated instance
- * and then:
- *    - call the handler function
- *    - cleanup by marking the instance as unused
- *    - long jump back to the original return address
- */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =
-		((struct fnptr *)kretprobe_trampoline)->ip;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more than one return
-	 * return probe was registered for a target function.
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
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	regs->cr_iip = orig_ret_address;
-
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		if (ri->rp && ri->rp->handler)
-			ri->rp->handler(ri, regs);
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
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
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->cr_iip = __kretprobe_trampoline_handler(regs,
+				(unsigned long)kretprobe_trampoline,
+				NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
@@ -485,6 +413,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->b0;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->b0 = ((struct fnptr *)kretprobe_trampoline)->ip;

