Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 297D8164838
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBSPP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:15:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgBSPOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Cu9fMoStLdoopmELsQh0sghgcGowEYfFRTmFriwC31I=; b=GvBJXNl/nmV4ynPyvKXmgBHRyz
        3gkHPPYcMQ7D/wEzHRA2TY+riSrz9HomXkLwAoORLhuUcHgttQsHlVX9BXOu05Am9Gs1kB8DNMx7Z
        7GhtNJ952oMtpwlfjOQKuI8IhcuvvLte/9+S/5yPovzOFDZLpgeZhvApL5/w+EbbwNB1/7DDfCdFy
        kZWkkTA3BP/yYE95aICanZzvvzTQpPRIWKAAosMo0RTSLWpbdFkBIQWUfIVojJJZX4zLxy5viKaEr
        /FHPFhgrNI/Nyo3te1mOLXzQDU1jPFE9KJIlJ+FtccKY0MZYL/3i0nvLyRuUFzgsuzUNQcuIPf0yw
        doN8qB+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R39-0007fL-1J; Wed, 19 Feb 2020 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0758D307842;
        Wed, 19 Feb 2020 16:12:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9D36E2B4D7B86; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.241364074@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 15/22] x86/int3: Ensure that poke_int3_handler() is not traced
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

In order to ensure poke_int3_handler() is completely self contained --
we call this while we're modifying other text, imagine the fun of
hitting another INT3 -- ensure that everything it uses is not traced.

The primary means here is to force inlining; bsearch() is notrace
because all of lib/ is.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ptrace.h        |    2 +-
 arch/x86/include/asm/text-patching.h |   11 +++++++----
 arch/x86/kernel/alternative.c        |   11 +++++++----
 3 files changed, 15 insertions(+), 9 deletions(-)

Index: linux-2.6/arch/x86/include/asm/ptrace.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/ptrace.h
+++ linux-2.6/arch/x86/include/asm/ptrace.h
@@ -123,7 +123,7 @@ static inline void regs_set_return_value
  * On x86_64, vm86 mode is mercifully nonexistent, and we don't need
  * the extra check.
  */
-static inline int user_mode(struct pt_regs *regs)
+static __always_inline int user_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_32
 	return ((regs->cs & SEGMENT_RPL_MASK) | (regs->flags & X86_VM_MASK)) >= USER_RPL;
Index: linux-2.6/arch/x86/include/asm/text-patching.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/text-patching.h
+++ linux-2.6/arch/x86/include/asm/text-patching.h
@@ -64,7 +64,7 @@ extern void text_poke_finish(void);
 
 #define DISP32_SIZE		4
 
-static inline int text_opcode_size(u8 opcode)
+static __always_inline int text_opcode_size(u8 opcode)
 {
 	int size = 0;
 
@@ -118,12 +118,14 @@ extern __ro_after_init struct mm_struct
 extern __ro_after_init unsigned long poking_addr;
 
 #ifndef CONFIG_UML_X86
-static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+static __always_inline
+void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
 }
 
-static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
+static __always_inline
+void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
 	 * The int3 handler in entry_64.S adds a gap between the
@@ -138,7 +140,8 @@ static inline void int3_emulate_push(str
 	*(unsigned long *)regs->sp = val;
 }
 
-static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
+static __always_inline
+void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
Index: linux-2.6/arch/x86/kernel/alternative.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/alternative.c
+++ linux-2.6/arch/x86/kernel/alternative.c
@@ -956,7 +956,8 @@ struct bp_patching_desc {
 
 static struct bp_patching_desc *bp_desc;
 
-static inline struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
+static __always_inline
+struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
 	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
 
@@ -966,13 +967,13 @@ static inline struct bp_patching_desc *t
 	return desc;
 }
 
-static inline void put_desc(struct bp_patching_desc *desc)
+static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
 	atomic_dec(&desc->refs);
 }
 
-static inline void *text_poke_addr(struct text_poke_loc *tp)
+static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
 {
 	return _stext + tp->rel_addr;
 }


