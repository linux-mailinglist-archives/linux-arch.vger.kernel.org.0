Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC40C4884AA
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiAHQov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiAHQoo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168DFC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F95660DE0
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D57C36AEF;
        Sat,  8 Jan 2022 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660283;
        bh=rnfvKmSwxDEuaHgQLviIQQxu942uDTnNhvFW9UzBS8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGG3iDU+MfqwGuvm1AXjkHOjyllQSLOpyeMjNdbpiDjnW2l8GwkOIGmkf6T29512x
         XAw0F9yMYlhgkh+Xp0WhfbduiIxBlZoScpEG8jLUthHHszmoB/BRMVQOKTfu/XAlJ/
         jgI0Rxu3sv+cXUUHg3jPUd3OFykmRsXTXuWMCbQI7h3DiqN892JePsXipLMjMLRPyC
         RKFjA6Qj5XGfOlbro7ioOg+TOsHoVsXM4YNWWGHPtlA6RhSybgbMowqXkI1RAGx5k/
         QJk/OW3LSpV+6FsXsqvf4KcwRuaxy6rA7DW4pDIn60kg2YEOj+I9VEQ+bEOF+5ooOT
         u7+Rd30vzj9rQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 23/23] x86/mm: Opt in to IRQs-off activate_mm()
Date:   Sat,  8 Jan 2022 08:44:08 -0800
Message-Id: <69c7d711f240cfec23e6024e940d31af2990db36.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We gain nothing by having the core code enable IRQs right before calling
activate_mm() only for us to turn them right back off again in switch_mm().

This will save a few cycles, so execve() should be blazingly fast with this
patch applied!

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/include/asm/mmu_context.h | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5060c38bf560..908a596619f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
+	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2ca4fc4a8a0a..f028f1b68bc0 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -132,10 +132,10 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			       struct task_struct *tsk);
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-#define activate_mm(prev, next)			\
-do {						\
-	paravirt_activate_mm((prev), (next));	\
-	switch_mm((prev), (next), NULL);	\
+#define activate_mm(prev, next)				\
+do {							\
+	paravirt_activate_mm((prev), (next));		\
+	switch_mm_irqs_off((prev), (next), NULL);	\
 } while (0);
 
 #ifdef CONFIG_X86_32
-- 
2.33.1

