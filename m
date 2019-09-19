Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5628B7DC7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbfISPKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50069 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390943AbfISPJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:52 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy42-0006oN-8x; Thu, 19 Sep 2019 17:09:46 +0200
Message-Id: <20190919150809.145400160@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 07/15] arm64/syscall: Remove obscure flag check
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The syscall handling code has an obscure check of pending work which does a
shortcut before returning to user space. It calls into the exit work code
when the flags at entry time required an entry into the slowpath. That does
not make sense because the underlying work functionality will reevaluate
the flags anyway and not do anything.

Replace that by a straight forward test for work flags. Preparatory change
for switching to the generic syscall exit work handling code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/kernel/syscall.c |   32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -93,8 +93,6 @@ static void cortex_a76_erratum_1463225_s
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
-	unsigned long flags = current_thread_info()->flags;
-
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
 	/* Set default error number */
@@ -105,33 +103,15 @@ static void el0_svc_common(struct pt_reg
 	user_exit();
 
 	scno = syscall_enter_from_usermode(regs, scno);
-	if (scno == NO_SYSCALL)
-		goto trace_exit;
-
-	invoke_syscall(regs, scno, sc_nr, syscall_table);
+	if (scno != NO_SYSCALL)
+		invoke_syscall(regs, scno, sc_nr, syscall_table);
 
-	/*
-	 * The tracing status may have changed under our feet, so we have to
-	 * check again. However, if we were tracing entry, then we always trace
-	 * exit regardless, as the old entry assembly did.
-	 */
-	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		local_daif_mask();
-		flags = current_thread_info()->flags;
-		if (!has_syscall_work(flags)) {
-			/*
-			 * We're off to userspace, where interrupts are
-			 * always enabled after we restore the flags from
-			 * the SPSR.
-			 */
-			trace_hardirqs_on();
-			return;
-		}
+	local_daif_mask();
+	if (has_syscall_work(current_thread_info()->flags) ||
+	    IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
 		local_daif_restore(DAIF_PROCCTX);
+		syscall_trace_exit(regs);
 	}
-
-trace_exit:
-	syscall_trace_exit(regs);
 }
 
 static inline void sve_user_discard(void)


