Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B54884A8
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiAHQop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiAHQon (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A80C061401
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8681060DD0
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E3FC36AED;
        Sat,  8 Jan 2022 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660282;
        bh=vHQAtfJ1+OgjeriZePikcaC9D/iAK/oYRR/naawsr2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aACd1MXlpkQJQQcnnNNlV12g06l4RWnDcLP8nKrsMAbq33gFkGpGx/qLyCU2Y+301
         4mLpwCwOq8IV9o3P+SqaG8R306edy1pe9BXs8dlAvDoLvXh81DM9sIyHyFp6OZMLVO
         3M2F8QA3Ez+S15ZocfYALEDWw8vlKNsQesnBHqGK+6yfSuhT/CWtgWWMMF6mZECaaU
         TrzQBxV1v0XCTMhj5bAZhXSohc12CCoo7ntkh0gYVqZTBFtMqEdyo600w4JT1sP1el
         aje6L7XWI/jygOh1JR92JrtYEqdH1V2FxPXaLMj5jM0kPBn3c87iH6UY4R33oe/a9H
         CFkWflxotEV6g==
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
Subject: [PATCH 22/23] x86/mm: Optimize for_each_possible_lazymm_cpu()
Date:   Sat,  8 Jan 2022 08:44:07 -0800
Message-Id: <13849aa0218e0f32ac16b82950c682395a8fb5c7.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that x86 does not switch away from a lazy mm behind the scheduler's
back and thus clear a CPU from mm_cpumask() that the scheduler thinks is
lazy, x86 can use mm_cpumask() to optimize for_each_possible_lazymm_cpu().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/mmu.h | 4 ++++
 arch/x86/mm/tlb.c          | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 03ba71420ff3..da55f768e68c 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -63,5 +63,9 @@ typedef struct {
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
+/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using mm */
+#define for_each_possible_lazymm_cpu(cpu, mm) \
+	for_each_cpu((cpu), mm_cpumask((mm)))
+
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 225b407812c7..04eb43e96e23 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -706,7 +706,9 @@ temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
 	 * with a stale address space WITHOUT being in lazy mode after
-	 * restoring the previous mm.
+	 * restoring the previous mm.  Additionally, once we switch mms,
+	 * for_each_possible_lazymm_cpu() will no longer report this CPU,
+	 * so a lazymm pin wouldn't work.
 	 */
 	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
 		unlazy_mm_irqs_off();
-- 
2.33.1

