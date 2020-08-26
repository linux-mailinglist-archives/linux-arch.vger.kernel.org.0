Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAC253246
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZOyC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgHZOx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99098C061574;
        Wed, 26 Aug 2020 07:53:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kx11so973748pjb.5;
        Wed, 26 Aug 2020 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZpeavpM6FR0EH3kfJJE/Au2m2iIw9NIl2DBgHhhejM=;
        b=tV4+5Nx+mWlMy1oPzbYssmbGFGn5MHDir+9Ml+ngC5YXRaOzyAwOFaifKm1R8UaWLX
         WQkXZvfbvY3oB5ULl79mFnabYoRV5BVHIVLrPO7hSistjiLvksufno1oOheZpuNe7odh
         cPO43oxRGgxo+TNxe1CNAUffQQJbpZlOvD1bN7nsgaLANe3l/5uKXIeq538FdXpyrHPR
         OgSaag90wBeVfRqyZUYj6CDGbu1+vItm3CEXZ02Jo8biOWyVnUPQhdZ1V6goCeTzxSSL
         TdSWKrdJAB4gR9cj8GvLOhpfeXcZelfyOXPY1BKqy3ngWA/gWgmLXh5kB6C1C5rA8jzc
         qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZpeavpM6FR0EH3kfJJE/Au2m2iIw9NIl2DBgHhhejM=;
        b=PfFYnwnVkSFalSfcfS4lf6ga9+tQKKcJFzJMF9o2fM5NLdmE40fJ315orPGJqLWHP1
         ZjjT45ehkGV07kEo5Ah5JzBCHU3yKDhuqHa2XaKyiyF6uLgjFkndRrXWS+qyPMNV76Ym
         1ZyMeV1hH6UXdsxiO8OLJ1JfyWc6mBcZN0lwESZGO7umBzNq0uKfdgSU1GKfAjW4X3XK
         0zHCpxlAmp1fd6j2q2zGA7aFduNl+NPRpXTLsKuWFusPOBjOG9xuzxux0Z1lB0q41S/l
         O+4VyybODA6HGPnjKaPO9B3CT5hThGe3b+ISaqQQBXpGTCh7ix3ZboZl8BMbK2y0/DK1
         ax4g==
X-Gm-Message-State: AOAM531CXW3dp5kME99JjFxKj0pAIP38PBkE2SNs0mXlxqu8KdSWl8C+
        SGpxu6DtmyVcCflULgVYfASbhi7ncvA=
X-Google-Smtp-Source: ABdhPJx2B9QoNopM3vjtHv2uBEnKqWYo0WOtGbIQ2+KMIlZyPXpfHeAM0oiNKIprYdNp4bvVxSnUYw==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr12417938plt.307.1598453637947;
        Wed, 26 Aug 2020 07:53:57 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:57 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/23] powerpc: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:42 +1000
Message-Id: <20200826145249.745432-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7f3658a97384..bc22e247ab55 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -14,7 +14,9 @@
 /*
  * Most if the context management is out of line
  */
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
@@ -235,27 +237,15 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	switch_mm(prev, next, current);
-}
-
-/* We don't currently use enter_lazy_tlb() for anything */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
-#endif
 }
+#endif
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
@@ -298,5 +288,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
-- 
2.23.0

