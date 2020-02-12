Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02415A52B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBLJoB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:44:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59452 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgBLJoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HdUKWfX4HpXaIQLUXWQWHKnnpih/LrElkhlwPym/L2Y=; b=I4vXAUw9vSIXbRHqgQKHw9eTXc
        XzrzSGQDMctfNR5wx3O9uNvwkU5ZwLdexavrW1/kTtltD4Ii5YBY5MsYmSQ6jOYl1BkoPyzv/EZPL
        wctX8vPLP0HSqQuI4zsWNeXAJlFridKsYQg4J/21keqA4nZETGWX5ghQtGDB+0C3UVb1vNevRg7WU
        1oVmuO8wrV+Uz9wdMdbsguJGtmOfA4pChszsjt6XDogf3hevcyH4ZnjCq+NorZh8aaW9qfKNcUyTN
        +mquc54tKyma/1KzRhPQbaGLR6b4zXHl14HPVvZJ8fmPTSTepYFfmE4RhMsYqqdmCCIAxJDilTkrI
        fcN4otlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYG-0006Ar-Q2; Wed, 12 Feb 2020 09:43:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F3773077F2;
        Wed, 12 Feb 2020 10:41:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 59DA72B9154EB; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212094107.894657838@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)() notrace
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Because do_nmi() must not call into tracing outside of
nmi_enter()/nmi_exit(), these functions must be notrace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/common.c |    4 ++--
 arch/x86/kernel/nmi.c        |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1690,14 +1690,14 @@ void syscall_init(void)
 DEFINE_PER_CPU(int, debug_stack_usage);
 DEFINE_PER_CPU(u32, debug_idt_ctr);
 
-void debug_stack_set_zero(void)
+void notrace debug_stack_set_zero(void)
 {
 	this_cpu_inc(debug_idt_ctr);
 	load_current_idt();
 }
 NOKPROBE_SYMBOL(debug_stack_set_zero);
 
-void debug_stack_reset(void)
+void notrace debug_stack_reset(void)
 {
 	if (WARN_ON(!this_cpu_read(debug_idt_ctr)))
 		return;
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -534,6 +534,9 @@ do_nmi(struct pt_regs *regs, long error_
 	}
 #endif
 
+	/*
+	 * It is important that no tracing happens before nmi_enter()!
+	 */
 	nmi_enter();
 
 	inc_irq_stat(__nmi_count);
@@ -542,6 +545,9 @@ do_nmi(struct pt_regs *regs, long error_
 		default_do_nmi(regs);
 
 	nmi_exit();
+	/*
+	 * No tracing after nmi_exit()!
+	 */
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {


