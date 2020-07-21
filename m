Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F0227E35
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgGULIo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbgGULIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9CDC061794;
        Tue, 21 Jul 2020 04:08:42 -0700 (PDT)
Message-Id: <20200721110808.889765456@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BIblg0GvIzHOdzEAdRS9LO1K9FW06VcbJ687eytc7nU=;
        b=WtJsFn/6dUUDuHDoecrwXQUtqkqhjMdJt72qtYarcr6RrHzROukeGf56reCuQQUE1qAm/R
        iOfEKnTMnO8WV+ekQExCJt8SWQcMPG3Ztvq6kQIgb7dJUjPUNoP6cqHV27LdVkh7Q6enH8
        IdWWrxNeeIO/JePmWzLla1i622X6/kXroHhELIc1qSRyzcZhBvqgIjN/BLzi3hq9giI4vn
        JnzSf4uHIA0dwkSSKxtQO5TmImunYfIsRyIK96uIM9h10w7LGwIVqlQKey0jVHTMLbE8gO
        QPt/X98kym1uNBca8d7KvF82vi07sXklxu9ewHSfA3I5yKy/kbUGs4R+kVwasQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BIblg0GvIzHOdzEAdRS9LO1K9FW06VcbJ687eytc7nU=;
        b=ir8573MpWDS0nQj1ym4ooLH2eTMBO6h1epOla8UuGn2MB9fOkdGbmaTAoL9VqDjcTxD+9J
        Urp2Agv2nHHDSNCg==
Date:   Tue, 21 Jul 2020 12:57:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 06/15] x86/entry: Consolidate check_user_regs()
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The user register sanity check is sprinkled all over the place. Move it
into enter_from_user_mode().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/common.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -82,10 +82,11 @@ static noinstr void check_user_regs(stru
  * 2) Invoke context tracking if enabled to reactivate RCU
  * 3) Trace interrupts off state
  */
-static noinstr void enter_from_user_mode(void)
+static noinstr void enter_from_user_mode(struct pt_regs *regs)
 {
 	enum ctx_state state = ct_state();
 
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	user_exit_irqoff();
 
@@ -95,8 +96,9 @@ static noinstr void enter_from_user_mode
 	instrumentation_end();
 }
 #else
-static __always_inline void enter_from_user_mode(void)
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 {
+	check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
@@ -369,9 +371,7 @@ static void __syscall_return_slowpath(st
 {
 	struct thread_info *ti;
 
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -434,9 +434,7 @@ static void do_syscall_32_irqs_on(struct
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -487,8 +485,6 @@ static bool __do_fast_syscall_32(struct
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
-	check_user_regs(regs);
-
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
@@ -496,7 +492,7 @@ static bool __do_fast_syscall_32(struct
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	local_irq_enable();
@@ -599,8 +595,7 @@ idtentry_state_t noinstr idtentry_enter(
 	};
 
 	if (user_mode(regs)) {
-		check_user_regs(regs);
-		enter_from_user_mode();
+		enter_from_user_mode(regs);
 		return ret;
 	}
 
@@ -733,8 +728,7 @@ void noinstr idtentry_exit(struct pt_reg
  */
 void noinstr idtentry_enter_user(struct pt_regs *regs)
 {
-	check_user_regs(regs);
-	enter_from_user_mode();
+	enter_from_user_mode(regs);
 }
 
 /**


