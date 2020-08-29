Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28982567AA
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH2NBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgH2NA7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:00:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204AF20CC7;
        Sat, 29 Aug 2020 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706052;
        bh=GT7QIE1OL2IEp8IqUl23H8/1NDehpfu08ti38E+0+vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxkLIcQpcGaOnQEAu0KGJnB7jKhtrJhzkbD+IRznkoftnGEWgT625Pc2g2BepttfM
         9RG9JiPBlsVE3nEMSJB+C2pgSxSERX/SPHspEzpbC99gG4kFYLbOpvkfMMSYFGqm0t
         4jSqY+YfPM9/8+YcolBGiCsY8Hd5u+1TnLCXej1I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 05/21] arc: kprobes: Use generic kretprobe trampoline handler
Date:   Sat, 29 Aug 2020 22:00:46 +0900
Message-Id: <159870604671.1229682.13639386820521358456.stgit@devnote2>
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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arc/kernel/kprobes.c |   54 ++-------------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 7d3efe83cba7..cabef45f11df 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -388,6 +388,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 {
 
 	ri->ret_addr = (kprobe_opcode_t *) regs->blink;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->blink = (unsigned long)&kretprobe_trampoline;
@@ -396,58 +397,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 					      struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
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
-		if (ri->rp && ri->rp->handler)
-			ri->rp->handler(ri, regs);
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address) {
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-		}
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-	regs->ret = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	regs->ret = __kretprobe_trampoline_handler(regs, &kretprobe_trampoline, NULL);
 
 	/* By returning a non zero value, we are telling the kprobe handler
 	 * that we don't want the post_handler to run

