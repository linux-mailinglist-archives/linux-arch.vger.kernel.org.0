Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6316483C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgBSPPi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:15:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBSPO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mocOxZQUeqTQQ8yUjNc0DjmC3mFU9HxodacHaxasgBg=; b=GaQZ2+heDUJP0fGQR2vqWg7Xrk
        z3cN44YljnueYMO9GiZ6R0YMafompFYV7GECXJsoXxIThvpBV3t0CIAYYT8ur+SsPshSalYXEX4+N
        JnrdfQMRzQvkymXieISEV6qcb1RoUgVMQF6NPInatRFaorwkJGPsU3KwbvPV+3Z1NB10gkx7gFYx5
        qgxGuP+zkDMcvyWarnqd8alHF3QCXZlvGOT/Fp6e1NX5SS0Kd3UUUEwoEG4paUld3Er9533wrYCNs
        8ofM25Z8uQ9QyHwmS+NYCgsGwGh0EELMmy3ggAh6y5jh2GsaV/E9Owcjy+zGqgQMatsjd+js81DBb
        JPZaqFaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R39-000110-6b; Wed, 19 Feb 2020 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F093E3077E6;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 873D12B17062B; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.945913022@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 10/22] x86,tracing: Add comments to do_nmi()
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a few comments to do_nmi() as a result of the audit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/nmi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -529,11 +529,14 @@ do_nmi(struct pt_regs *regs, long error_
 	 * continue to use the NMI stack.
 	 */
 	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
+		debug_stack_set_zero(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 1);
 	}
 #endif
 
+	/*
+	 * It is important that no tracing happens before nmi_enter()!
+	 */
 	nmi_enter();
 
 	inc_irq_stat(__nmi_count);
@@ -542,10 +545,13 @@ do_nmi(struct pt_regs *regs, long error_
 		default_do_nmi(regs);
 
 	nmi_exit();
+	/*
+	 * No tracing after nmi_exit()!
+	 */
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
+		debug_stack_reset(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 0);
 	}
 #endif


