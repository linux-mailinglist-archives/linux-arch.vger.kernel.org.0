Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4228122EC87
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgG0MtA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgG0Ms7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 08:48:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D71C061794;
        Mon, 27 Jul 2020 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Lp/5v08SyWXAamPuAUqdz1ZhLZFu/l4VoMBD8cBUeVs=; b=VsfekhRsmI3HDR4Iwxer3bGlBW
        DKdptTONCfY3KRGq3sXFq3KyAuBC9bKCa/hChvF6AjBMdpAlYLYFZ88YHzikineaZR9iU/rqgrulo
        7C8JJQVLf7s6wAPh5z6+4jG4V8m7msCfjID6Pg82Uc1f9gl99qPNC+wpE24gP0XIFwxTsmLverVqY
        xapDU5m5c3L/IppYbnKX/4DfY8orRy7MaJUJz1SgVCUMzwfxfnz/QMvwcgTIzdXb21ZFm104QZg4z
        N0J5hwjaDPgP/TmU/OagfLN8+xKvObg/h7MNogAcu8f0PXBkZzKJdO4hyoJXXABY4mak5pHPZKI8M
        FmEoA02Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02Yn-00084B-7N; Mon, 27 Jul 2020 12:48:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5BA7301EE3;
        Mon, 27 Jul 2020 14:48:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8462229DBC080; Mon, 27 Jul 2020 14:48:52 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:48:52 +0200
From:   peterz@infradead.org
To:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, x86@kernel.org,
        linux-sh@vger.kernel.org, borntraeger@de.ibm.com,
        jcmvbkbc@gmail.com
Subject: [PATCH] lockdep: Fix TRACE_IRQFLAGS vs NMIs
Message-ID: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Prior to commit 859d069ee1dd ("lockdep: Prepare for NMI IRQ state
tracking") IRQ state tracking was disabled in NMIs due to nmi_enter()
doing lockdep_off() -- with the obvious requirement that NMI entry
call nmi_enter() before trace_hardirqs_off().

[ afaict, PowerPC and SH violate this order on their NMI entry ]

However, that commit explicitly changed lockdep_hardirqs_*() to ignore
lockdep_off() and breaks every architecture that has irq-tracing in
it's NMI entry that hasn't been fixed up (x86 being the only fixed one
at this point).

The reason for this change is that by ignoring lockdep_off() we can:

  - get rid of 'current->lockdep_recursion' in lockdep_assert_irqs*()
    which was going to to give header-recursion issues with the
    seqlock rework.

  - allow these lockdep_assert_*() macros to function in NMI context.

Restore the previous state of things and allow an architecture to
opt-in to the NMI IRQ tracking support, however instead of relying on
lockdep_off(), rely on in_nmi(), both are part of nmi_enter() and so
over-all entry ordering doesn't need to change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig.debug   |    3 +++
 kernel/locking/lockdep.c |    8 +++++++-
 lib/Kconfig.debug        |    6 ++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -3,6 +3,9 @@
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
+config TRACE_IRQFLAGS_NMI_SUPPORT
+	def_bool y
+
 config EARLY_PRINTK_USB
 	bool
 
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3712,6 +3712,9 @@ void noinstr lockdep_hardirqs_on(unsigne
 	 * and not rely on hardware state like normal interrupts.
 	 */
 	if (unlikely(in_nmi())) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+
 		/*
 		 * Skip:
 		 *  - recursion check, because NMI can hit lockdep;
@@ -3773,7 +3776,10 @@ void noinstr lockdep_hardirqs_off(unsign
 	 * they will restore the software state. This ensures the software
 	 * state is consistent inside NMIs as well.
 	 */
-	if (unlikely(!in_nmi() && (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)))
+	if (in_nmi()) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
 		return;
 
 	/*
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1325,11 +1325,17 @@ config WW_MUTEX_SELFTEST
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
+	depends on TRACE_IRQFLAGS_SUPPORT
 	bool
 	help
 	  Enables hooks to interrupt enabling and disabling for
 	  either tracing or lock debugging.
 
+config TRACE_IRQFLAGS_NMI
+	def_bool y
+	depends on TRACE_IRQFLAGS
+	depends on TRACE_IRQFLAGS_NMI_SUPPORT
+
 config STACKTRACE
 	bool "Stack backtrace support"
 	depends on STACKTRACE_SUPPORT
