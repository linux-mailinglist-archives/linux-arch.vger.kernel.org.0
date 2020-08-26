Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CED253049
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgHZNs5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 09:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgHZNsT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 09:48:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F58221E2;
        Wed, 26 Aug 2020 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449698;
        bh=NDgTujQf40aEc0EizGnGw4M8AkJqzxUV0D0lyCYMSxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj2migLj8ctFEej7wbf04OZXN9CCrXAHTsbK6ReojfcMRUjBouRSEE7OBU5GwKNtJ
         N6OCdfXjK5AaP6Gtv+8+XNTuq7rYQxcETBQ57ZXl+CuGVVCtuaA54uVbxdY2PuFOAe
         vCnSqKywx6HpI9eVIPkKn+losPjPdK+QMF1oX8SM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 12/14] sh: kprobes: Use generic kretprobe trampoline handler
Date:   Wed, 26 Aug 2020 22:48:14 +0900
Message-Id: <159844969375.510284.14762268483841116550.stgit@devnote2>
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
 arch/sh/kernel/kprobes.c |   59 +++-------------------------------------------
 1 file changed, 4 insertions(+), 55 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 318296f48f1a..118927ab63af 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -204,6 +204,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->pr;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->pr = (unsigned long)kretprobe_trampoline;
@@ -302,62 +303,10 @@ static void __used kretprobe_trampoline_holder(void)
  */
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
+	regs->pc = __kretprobe_trampoline_handler(regs,
+			(unsigned long)&kretprobe_trampoline, NULL);
 
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more then one return
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
-		if (ri->rp && ri->rp->handler) {
-			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
-		}
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
-
-	regs->pc = orig_ret_address;
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
-	return orig_ret_address;
+	return 1;
 }
 
 static int __kprobes post_kprobe_handler(struct pt_regs *regs)

