Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C784884A6
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiAHQon (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAHQoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F7C061746
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C027C60DD0
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5CDC36AE0;
        Sat,  8 Jan 2022 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660277;
        bh=4/phD45ccBwKpoEpuFHVuaC4/6+F9ASvK+hhO/SU8Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXxmmXTBkFoFc6QR/NgokKjHl/kD2AA7EmiuQeyFtV6de+D5/klMZnZR18SFCwNat
         nlYbn+f/Tj+XDTl9Kc/6FfiMbDc0dBF52mcyPFq0Y+WWUDSHsabaUQAlKtbjXoc7yK
         xsNL10IiLydVRUmGKmf7kx6c7EOS7Sgrenl5SStfYcVnvAxxBUcI91U0xxjRgFJitT
         DsBmXeKzpJVHu/fSNV+EV4FM2LYmnjvFRJDhm+ly7uXb5284aUJdaXoalZOMVpE8ER
         jSwt8bkjFo1QGts8nHMiMNpb3hb4t3eOkaCRIAFVqVEColWw53avbh4E7vzularl3k
         hGh9mVafpDgIA==
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
Subject: [PATCH 18/23] x86/mm: Allow temporary mms when IRQs are on
Date:   Sat,  8 Jan 2022 08:44:03 -0800
Message-Id: <a8a92ce490b57447ef56898c55133473e481896e.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

EFI runtime services should use temporary mms, but EFI runtime services
want IRQs on.  Preemption must still be disabled in a temporary mm context.

At some point, the entirely temporary mm mechanism should be moved out of
arch code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/tlb.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4e371f30e2ab..36ce9dffb963 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -708,18 +708,23 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
  * that override the kernel memory protections (e.g., W^X), without exposing the
  * temporary page-table mappings that are required for these write operations to
  * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
+ * mapping is torn down.  Temporary mms can also be used for EFI runtime service
+ * calls or similar functionality.
  *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
+ * It is illegal to schedule while using a temporary mm -- the context switch
+ * code is unaware of the temporary mm and does not know how to context switch.
+ * Use a real (non-temporary) mm in a kernel thread if you need to sleep.
+ *
+ * Note: For sensitive memory writes, the temporary mm needs to be used
+ *       exclusively by a single core, and IRQs should be disabled while the
+ *       temporary mm is loaded, thereby preventing interrupt handler bugs from
+ *       overriding the kernel memory protection.
  */
 temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 {
 	temp_mm_state_t temp_state;
 
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
@@ -751,7 +756,7 @@ temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 
 void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
 	/*
-- 
2.33.1

