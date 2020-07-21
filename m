Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327C227E40
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgGULIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgGULIv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:51 -0400
Message-Id: <20200721110809.531305010@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TW2YREFZRpmpV7lTAtkkgutVDumUXCXPLDpmUk0C+O8=;
        b=VFkJN/zzpCbS1wdxZOSwOXRAicZIJJ6asrWMRGbA/dFg2FyaKUYRaoqL9ELuu4Kdzf/0rw
        rgA/j0jGdtH+FdEYAuEumx/4VypzRXh0tdNt2MRUO27XjfSzOAyJzBi1mqDFAweKivMi3a
        oHbcMnuxI5ATqGWnwP6pjELK6MjXcup0SJ78H8RqAa2cfT4re4S2MzPbualLHASdl4vR49
        JEO/rJEm0U3qhuYSUQwcV+huFcddiV69/gVLBOqFXCQx4CXU+tOJCKuHQNYbbGEUhsKHpJ
        fJs4r03aHvPai7+WT2MVlwIRSMtkA3lPalntZQJuc50BPRvqeqcAR2dXKk2bqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TW2YREFZRpmpV7lTAtkkgutVDumUXCXPLDpmUk0C+O8=;
        b=D82q6ZR1OJNVxeUXQgOsX9COtRcP2XFMqDYLAQfddyw49SigpAtHKnQ/EV5s0i3xkCABM6
        4dKmrq9xZ09D7ZDg==
Date:   Tue, 21 Jul 2020 12:57:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 12/15] x86/entry: Cleanup idtentry_entry/exit_user
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cleanup the temporary defines and use irqentry_ instead of idtentry_.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |    4 ----
 arch/x86/kernel/cpu/mce/core.c  |    4 ++--
 arch/x86/kernel/traps.c         |   18 +++++++++---------
 3 files changed, 11 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,10 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-/* Temporary define */
-#define idtentry_enter_user	irqentry_enter_from_user_mode
-#define idtentry_exit_user	irqentry_exit_to_user_mode
-
 typedef struct idtentry_state {
 	bool exit_rcu;
 } idtentry_state_t;
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1927,11 +1927,11 @@ static __always_inline void exc_machine_
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -638,18 +638,18 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
-	 * can trigger INT3, hence poke_int3_handler() must be done
-	 * before. If the entry came from kernel mode, then use nmi_enter()
-	 * because the INT3 could have been hit in any context including
-	 * NMI.
+	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
+	 * and therefore can trigger INT3, hence poke_int3_handler() must
+	 * be done before. If the entry came from kernel mode, then use
+	 * nmi_enter() because the INT3 could have been hit in any context
+	 * including NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter_user(regs);
+		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit_user(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else {
 		nmi_enter();
 		instrumentation_begin();
@@ -901,12 +901,12 @@ static __always_inline void exc_debug_us
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64


