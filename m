Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4216482E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSPPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:15:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBSPOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=K1Y0rcrBsp5T2iA0N2BonRM4YMrHeI8WBpuGfA6Q3NQ=; b=wz7BzR0kPQ/YMVxRNZnbuPCH8s
        S04h3DUgMsNiRsfnT05LppbZUiRe7t89ahIqI/tIB2hyjIVDNEvkOJUgGZXVl+/TLbNlQklEj17QE
        Kvzpg5PKd7ce5KjuPJ9DOJT3JctxEM+nbQ4d0wgZAXRiHMxfIsRj9lMnpGWA3oZi7yXJL5Qip7ZXY
        z4WYb9iGxfiuFVY05lPBl3At7m4LRfty/fSjnc88FH21nF2UzQajFcYmQ0zxaVUZr4eE7EPPRwdxw
        Y5bjXFYZbs6J++AULjg+1pyMLWnF/GCPtARyC5epFolsSXd1x0XqcPuoEHvZqGz+5alIbl/tqQzGQ
        dEcX2iKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R37-0007fB-E8; Wed, 19 Feb 2020 15:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4785B30704D;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 73A19299B2E9B; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.604459293@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hitting the tracer or a kprobes from #DF is 'interesting', lets avoid
that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c   |    3 ++-
 arch/x86/lib/memcpy_32.c  |    7 ++++++-
 arch/x86/lib/memmove_64.S |    5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -271,7 +271,8 @@ dotraplinkage void do_double_fault(struc
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for nmi_enter() here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't call out to anything
+	 * except memmove() and that is notrace/NOKPROBE.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
 }
 EXPORT_SYMBOL(memset);
 
-__visible void *memmove(void *dest, const void *src, size_t n)
+__visible notrace void *memmove(void *dest, const void *src, size_t n)
 {
 	int d0,d1,d2,d3,d4,d5;
 	char *ret = dest;
@@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
 
 }
 EXPORT_SYMBOL(memmove);
+/*
+ * The double fault handler uses memmove(), do not mess with it or risk a
+ * tripple fault.
+ */
+NOKPROBE_SYMBOL(memmove);
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,3 +212,8 @@ SYM_FUNC_END(__memmove)
 SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
+/*
+ * The double fault handler uses memmove(), do not mess with it or risk a
+ * tripple fault.
+ */
+_ASM_NOKPROBE(__memmove)


