Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5294884A4
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiAHQom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiAHQoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F25C061401
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBBDB60DFE
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057E2C36AF5;
        Sat,  8 Jan 2022 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660276;
        bh=4O5nnTjv81SB19Td4mAJDL0i8hlOmRdkCRWMKeHBKAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnQbS/8LDy7d4rBBPC1BeLgidoaa4RtK6uxKnx4yRs+qg7nT673dGWG923bTUnbgu
         CKLbe0NsOO4c7xL1BQs2xd7jQmQaBsQVaH1Rn0gkGZZksdInj7FKmM2GnZA5IkKASn
         KZWlFjYI+xzq9mzvwbAvpRy4OBAv+7xXSB988sz6TRqW25dcR0O5L6wCw15mQM8EBn
         KRPduVbOwWJ9KilaMRZ3jeMkvsdFquIkcOvIupgtz2QzMYFleWwpQ0ImjkV6IIrJB2
         44XNQ8quVWQdliW7Y2Ld9o9sD2bALVt1bDziiFN7x8gsf9r0KdWrTqesM/M67AnVOm
         rIomDSz8xJKZg==
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
Subject: [PATCH 17/23] x86/mm: Make use/unuse_temporary_mm() non-static
Date:   Sat,  8 Jan 2022 08:44:02 -0800
Message-Id: <d1205bc7e165e249c52b7fe8cb1254f06e8a0e2a.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This prepares them for use outside of the alternative machinery.
The code is unchanged.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/mmu_context.h |  7 ++++
 arch/x86/kernel/alternative.c      | 65 +-----------------------------
 arch/x86/mm/tlb.c                  | 60 +++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..2ca4fc4a8a0a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -220,4 +220,11 @@ unsigned long __get_current_cr3_fast(void);
 
 #include <asm-generic/mmu_context.h>
 
+typedef struct {
+	struct mm_struct *mm;
+} temp_mm_state_t;
+
+extern temp_mm_state_t use_temporary_mm(struct mm_struct *mm);
+extern void unuse_temporary_mm(temp_mm_state_t prev_state);
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b47cd22b2eb1..af4c37e177ff 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
+#include <asm/mmu_context.h>
 
 int __read_mostly alternatives_patched;
 
@@ -706,70 +707,6 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	}
 }
 
-typedef struct {
-	struct mm_struct *mm;
-} temp_mm_state_t;
-
-/*
- * Using a temporary mm allows to set temporary mappings that are not accessible
- * by other CPUs. Such mappings are needed to perform sensitive memory writes
- * that override the kernel memory protections (e.g., W^X), without exposing the
- * temporary page-table mappings that are required for these write operations to
- * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
- *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
- */
-static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
-{
-	temp_mm_state_t temp_state;
-
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
-	 * with a stale address space WITHOUT being in lazy mode after
-	 * restoring the previous mm.
-	 */
-	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
-		leave_mm(smp_processor_id());
-
-	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	switch_mm_irqs_off(NULL, mm, current);
-
-	/*
-	 * If breakpoints are enabled, disable them while the temporary mm is
-	 * used. Userspace might set up watchpoints on addresses that are used
-	 * in the temporary mm, which would lead to wrong signals being sent or
-	 * crashes.
-	 *
-	 * Note that breakpoints are not disabled selectively, which also causes
-	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
-	 * undesirable, but still seems reasonable as the code that runs in the
-	 * temporary mm should be short.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_disable();
-
-	return temp_state;
-}
-
-static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
-{
-	lockdep_assert_irqs_disabled();
-	switch_mm_irqs_off(NULL, prev_state.mm, current);
-
-	/*
-	 * Restore the breakpoints if they were disabled before the temporary mm
-	 * was loaded.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_restore();
-}
-
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 74b7a615bc15..4e371f30e2ab 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -702,6 +702,66 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
 }
 
+/*
+ * Using a temporary mm allows to set temporary mappings that are not accessible
+ * by other CPUs. Such mappings are needed to perform sensitive memory writes
+ * that override the kernel memory protections (e.g., W^X), without exposing the
+ * temporary page-table mappings that are required for these write operations to
+ * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
+ * mapping is torn down.
+ *
+ * Context: The temporary mm needs to be used exclusively by a single core. To
+ *          harden security IRQs must be disabled while the temporary mm is
+ *          loaded, thereby preventing interrupt handler bugs from overriding
+ *          the kernel memory protection.
+ */
+temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
+{
+	temp_mm_state_t temp_state;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
+		leave_mm(smp_processor_id());
+
+	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
+	return temp_state;
+}
+
+void unuse_temporary_mm(temp_mm_state_t prev_state)
+{
+	lockdep_assert_irqs_disabled();
+	switch_mm_irqs_off(NULL, prev_state.mm, current);
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
+}
+
 /*
  * Call this when reinitializing a CPU.  It fixes the following potential
  * problems:
-- 
2.33.1

