Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D38253048
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgHZNs5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 09:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgHZNsa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 09:48:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAE420707;
        Wed, 26 Aug 2020 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449708;
        bh=UJ+ocn3BaOJ19OKLX01EL0EppLq2nJgJ2qMjz+Qu7lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brX+PGsTbiQnrRXc65q5p57iZC5ACJ7ABfPLxghFk0Nm6IVcIIs62gwKdIxo1l0OQ
         q8/UKMCAzAvP5GM2Z1G97tq0LaYMck1VXwYeEOx9IXxGNQzgLaGJoUk6kYjhgehQQq
         0bfXBzpTgsuCckMK1Phr+Avl/tiOU2Ode9kj8oK0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 13/14] sparc: kprobes: Use generic kretprobe trampoline handler
Date:   Wed, 26 Aug 2020 22:48:24 +0900
Message-Id: <159844970401.510284.14364618717570527245.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159844957216.510284.17683703701627367133.stgit@devnote2>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
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
 arch/sparc/kernel/kprobes.c |   52 +++----------------------------------------
 1 file changed, 4 insertions(+), 48 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index dfbca2470536..cd34aeaa3ebb 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -453,6 +453,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)(regs->u_regs[UREG_RETPC] + 8);
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->u_regs[UREG_RETPC] =
@@ -465,58 +466,13 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
+	unsigned long orig_ret_address = 0;
 
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
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+	orig_ret_address = __kretprobe_trampoline_handler(regs,
+			(unsigned long)&kretprobe_trampoline, NULL);
 	regs->tpc = orig_ret_address;
 	regs->tnpc = orig_ret_address + 4;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler

