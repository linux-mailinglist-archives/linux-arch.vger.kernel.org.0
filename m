Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD584379CC
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhJVP0n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhJVP0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA9C061764;
        Fri, 22 Oct 2021 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0sqm599iUOuyUxpuca33mERj0JV1ICuNGPw1IIrP6Gw=; b=lCBtLkcoi2LhYGTgqH7xpLKr9k
        4y9ordfdNfms4F0dA2ujdwmapfnGNdS1qHBGsaZTva9dA7tgnq7MqKLN89Ir5EP2+DZRsr9el0axw
        ouxm1RP/p1IcMAy5j8POE6ZsJGUkTWbW7NI4n04Rq3vPf/QD9gxpQWFBd5k/B55pxA8MX1cTUkz7w
        RAEWaZ6jqYEfjtIm2a/aE21U78ub1LgK1urXVHeUHS893n4G3WLQ9D8+5jx3ms53QzNe94gN9fimk
        1s4Qz2UiQ7V2sLZX+4Gr6c/ctyJ74MZiiJqmnXy037E9btr/CZazxsr1Jct1oJu5d5PJ8IdHHJXol
        MHC3SIJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOF-00BbM9-1G; Fri, 22 Oct 2021 15:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 776B7300BD9;
        Fri, 22 Oct 2021 17:23:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7465B2C0CA180; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.419533274@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 5/7] powerpc, arm64: Mark __switch_to() as __sched
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Unlike most of the other architectures, PowerPC and ARM64 have
__switch_to() as a C function which remains on the stack. Their
respective __get_wchan() skips one stack frame unconditionally,
without testing is_sched_functions().

Mark them __sched such that we can forgo that special case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/process.c   |    4 ++--
 arch/powerpc/kernel/process.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -490,8 +490,8 @@ void update_sctlr_el1(u64 sctlr)
 /*
  * Thread switching.
  */
-__notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
-				struct task_struct *next)
+__notrace_funcgraph __sched
+struct task_struct *__switch_to(struct task_struct *prev, struct task_struct *next)
 {
 	struct task_struct *last;
 
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1201,8 +1201,8 @@ static inline void restore_sprs(struct t
 
 }
 
-struct task_struct *__switch_to(struct task_struct *prev,
-	struct task_struct *new)
+__sched struct task_struct *__switch_to(struct task_struct *prev,
+					struct task_struct *new)
 {
 	struct thread_struct *new_thread, *old_thread;
 	struct task_struct *last;


