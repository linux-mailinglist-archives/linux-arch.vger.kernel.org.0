Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF502567C9
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgH2NKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgH2NBi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:01:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA84207DA;
        Sat, 29 Aug 2020 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706090;
        bh=+uNo48BjojUUyd8SWiNvCMQph4V515E9sHAisfn+ZNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrezCN/yWqyxPPHms0S3VFf1ARkK3I32OKiRc8tDxq4B+/DLLsnxiGQEqBsThMgs5
         qNpCdWgKRv3xj7SHfFwgrYfwkt09M0d7eRAfIlmWzdVUf/75inS2a7wfNP4cf/9ihJ
         Ii3DDIs4S6CV8kpWYKd0DSjFcFwilll+nGKPvn5c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 08/21] mips: kprobes: Use generic kretprobe trampoline handler
Date:   Sat, 29 Aug 2020 22:01:19 +0900
Message-Id: <159870607968.1229682.12100697467108845587.stgit@devnote2>
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
 arch/mips/kernel/kprobes.c |   54 ++------------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index d043c2f897fc..54dfba8fa77c 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -477,6 +477,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->regs[31];
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->regs[31] = (unsigned long)kretprobe_trampoline;
@@ -488,57 +489,8 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 static int __kprobes trampoline_probe_handler(struct kprobe *p,
 						struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)kretprobe_trampoline;
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
-	 *	 function, the first instance's ret_addr will point to the
-	 *	 real return address, and all the rest will point to
-	 *	 kretprobe_trampoline
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
-	instruction_pointer(regs) = orig_ret_address;
-
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
+	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs,
+						kretprobe_trampoline, NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler

