Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66C6488495
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiAHQo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiAHQoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05EC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC7E60DD7
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4C8C36AED;
        Sat,  8 Jan 2022 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660263;
        bh=Ix0zIvWH9riMicQK8q6DeOk5TUbR/qLOVVFcIcVQ7C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auhasTA/47YoAeVi8R3e+QTXB01K8YsMLaA59SJ4dOZ+OaBIuznl4w5vUDhWLgVgd
         nsbcRscEmwFJ79KqOn6yfwoCuOHEZlzFhXChKiZeBbe8MmiTX9B1oE3pm9v1YxtY3+
         9z+fr8Q/bL6dMsZuyYWCd4b4Ra+QLFuWY60jotzHt7SgsS2Rfogbp7ysJM1fZ+zgDs
         QYO8jxwQtH0zVozrfDwwMie+4OEFtg02UUwn8wCAyY9dyICu63kPwCBKqbQHkj3Q9K
         DS4jfc3F0BqNZecvV3KoEVKhGNwNyFtsjMr7v27SdHqXoW5tXauL6Dy/JQdJt+axRX
         EW0Pjg36QKZAQ==
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
        Andy Lutomirski <luto@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/23] powerpc/membarrier: Remove special barrier on mm switch
Date:   Sat,  8 Jan 2022 08:43:51 -0800
Message-Id: <e1664cf686034204b8dd5dc1d2bf18e4058b00fd.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc did the following on some, but not all, paths through
switch_mm_irqs_off():

       /*
        * Only need the full barrier when switching between processes.
        * Barrier when switching from kernel to userspace is not
        * required here, given that it is implied by mmdrop(). Barrier
        * when switching from userspace to kernel is not needed after
        * store to rq->curr.
        */
       if (likely(!(atomic_read(&next->membarrier_state) &
                    (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
                     MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
               return;

This is puzzling: if !prev, then one might expect that we are switching
from kernel to user, not user to kernel, which is inconsistent with the
comment.  But this is all nonsense, because the one and only caller would
never have prev == NULL and would, in fact, OOPS if prev == NULL.

In any event, this code is unnecessary, since the new generic
membarrier_finish_switch_mm() provides the same barrier without arch help.

arch/powerpc/include/asm/membarrier.h remains as an empty header,
because a later patch in this series will add code to it.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/powerpc/include/asm/membarrier.h | 24 ------------------------
 arch/powerpc/mm/mmu_context.c         |  1 -
 2 files changed, 25 deletions(-)

diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
index de7f79157918..b90766e95bd1 100644
--- a/arch/powerpc/include/asm/membarrier.h
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -1,28 +1,4 @@
 #ifndef _ASM_POWERPC_MEMBARRIER_H
 #define _ASM_POWERPC_MEMBARRIER_H
 
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-					     struct mm_struct *next,
-					     struct task_struct *tsk)
-{
-	/*
-	 * Only need the full barrier when switching between processes.
-	 * Barrier when switching from kernel to userspace is not
-	 * required here, given that it is implied by mmdrop(). Barrier
-	 * when switching from userspace to kernel is not needed after
-	 * store to rq->curr.
-	 */
-	if (IS_ENABLED(CONFIG_SMP) &&
-	    likely(!(atomic_read(&next->membarrier_state) &
-		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
-		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
-		return;
-
-	/*
-	 * The membarrier system call requires a full memory barrier
-	 * after storing to rq->curr, before going back to user-space.
-	 */
-	smp_mb();
-}
-
 #endif /* _ASM_POWERPC_MEMBARRIER_H */
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 74246536b832..5f2daa6b0497 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -84,7 +84,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		asm volatile ("dssall");
 
 	if (!new_on_cpu)
-		membarrier_arch_switch_mm(prev, next, tsk);
 
 	/*
 	 * The actual HW switching method differs between the various
-- 
2.33.1

