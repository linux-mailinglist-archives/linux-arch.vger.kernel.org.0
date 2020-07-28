Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33323003C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgG1DfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgG1DfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED8FC0619D2;
        Mon, 27 Jul 2020 20:35:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so10708588pjq.5;
        Mon, 27 Jul 2020 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WECce0LBXYVjXbrlpo11bHUpze9GJI1lVnSDe0W+y+4=;
        b=LR4TT1gn/htVF8c/22u1u+36l6MbOY8omKK1QrfKFh7EpljJaFABhwWa9g2ldtcZqp
         HWOYXXLyiVVdT7tvogFpfVRRJ5NlpM5E/1VlbSLLohpKtL5qu+Eb+GFwFshEelFxMS+4
         756Ga65My7y8NdfBf/I+FUmwNY1tMNDdcArxacDOeyD4ipsFlFdBMoHjZabadWx7Cb+G
         AFIG8FjoYXAjBqVBSu/3Lq30DcpDkkHu29sCZ8oj+ICdNqnoBYxgyyZJPFiR5ClFTrX9
         qdlvfZMYbV93inruHyenWeSb9Ews0pMS5keHZ17XGcfc6GHkP7AcYQsXFdUkcPG4A1zC
         TPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WECce0LBXYVjXbrlpo11bHUpze9GJI1lVnSDe0W+y+4=;
        b=n4AxAV2PE6ivpIh+spvE+7wpokWMt6x4ryaBwnpzWRUHN0bnUHp+XFl7sV60nC0tiB
         1W0VreuUcpPNqL9cqgXGvBS6tuL5F8GSdTCbOOZhzLdOS9fnBdGcsDrhTTfz0b3+f8hs
         uOjfMAaSZBsXYxe9bOaLZ2ZiJu1Nf6tE2MB+xwnSHS2MyzKuZ1+qDjlht/1bmP1qx4NK
         ws9gMdbzJObNN5u/J+31H37mW+BKM1KrGXhEIZrUVBetv4zOXpdqBCWUtLealx2PYC4M
         3C5yGb7FIXP3641NmauRyffwpJAQ6hlOIls9B7TEsiWHgLxhfoU1r9uNudB44VHkIAOG
         U+sw==
X-Gm-Message-State: AOAM5307lcbkA2OvfxcIMXBYNLDCUehry+D3aTP6ZAChAWmHWdC+Jx3V
        /QlowVcd4Q02k6OdakPbVwO5QQf4
X-Google-Smtp-Source: ABdhPJzuslCQp+8HbB3cDYhA5hqXaz9y/HEvXL86aufZSOGtcy8wjOcm865BoW4An1+Ax+pq2VZyIg==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr19664485pls.209.1595907319521;
        Mon, 27 Jul 2020 20:35:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/24] powerpc: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:57 +1000
Message-Id: <20200728033405.78469-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
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
index 1a474f6b1992..242bd987247b 100644
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
@@ -237,27 +239,15 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
 
@@ -300,5 +290,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
-- 
2.23.0

