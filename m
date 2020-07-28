Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75401230045
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgG1Dfi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgG1Dfh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06103C061794;
        Mon, 27 Jul 2020 20:35:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t1so25792plq.0;
        Mon, 27 Jul 2020 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejVWa9IRIyyHORgldOpUlCO0QqVKUsW+6Dc4qu3Phn0=;
        b=Jt7EXzePYmlX76Oyhuuvk2E2TsOmB6At6s21TV4q+GvtXPNZT1DEHyypIHTynq9As+
         BkCRwn3e9r+e25+V4IgqR2Uofh8gO/spVncQhb1HNmHUUN0HmusWt17LCGpw+B5T72KT
         q4fN8fdFdQDbGw5hhw7WzFzq/rw4eJ50OpVHwFckZU0pQtBT64prbgjVZpnlp+CT8IG3
         S5W9tZ9lFzoc7O/pTxoYOnNdME9dlMzufWavyl6jHEBXisfnkTvTFcbYo/J5/nAWqdMq
         MGKG8JdZbx1MKdBr8/piTey0D0P/s2WUUKA7S68NDBG7LgEKCWHqAQC1ilETstx17N9k
         5dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejVWa9IRIyyHORgldOpUlCO0QqVKUsW+6Dc4qu3Phn0=;
        b=GrepvxGUpDzSibrbnj184UCS9g0x5reGdX1qyBmhMD64wf3FQrSvsQkjxmDr4SrZTS
         mxQ6Hz20dhBRtIHbk8lxLfRFDzFvPRohU0ySJCzqTv1PVwb2n6Ko83DFe+hpLwjWQfp1
         QZ5m4lNt4dA2i40ZREq3Au2t4ECJuF/+xVFjH0pm+zA/qWpyMpvhrRVB3mPU4MRA/wYC
         A77xK8lCnzDlPOl8dL+piMs1ybJTGMK1PgXuJ/tLpeqj52FZPchqCiW7ncxW3DBpFRHz
         LN+rJAKGn4sosbrYdTLpja6r/dk1TBRa88jE4Q9kdXkmZQwMZvrzwMxttNaP+cWDLaI1
         S+zw==
X-Gm-Message-State: AOAM531vtnrZ3kGmrgTbMptH60VtmhO64eHxkBbr3179mATXhGgjnCc/
        bhBDCBGza6pM0q/GYs5CR/5YvcAN
X-Google-Smtp-Source: ABdhPJw4hwasq8wvkQnu1HWMVzyIJWE/5FO/nlXv0/l00rns0GpQTf9lkr4MhczGycWKUCPmxjmRrA==
X-Received: by 2002:a17:90a:eb01:: with SMTP id j1mr2323875pjz.29.1595907336390;
        Mon, 27 Jul 2020 20:35:36 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 20/24] sparc: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:01 +1000
Message-Id: <20200728033405.78469-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/include/asm/mmu_context_32.h | 10 ++++------
 arch/sparc/include/asm/mmu_context_64.h | 10 +++++-----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 7ddcb8badf70..509043f81560 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -6,13 +6,10 @@
 
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* Initialize a new mmu context.  This is invoked when a new
  * address space instance (unique or shared) is instantiated.
  */
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
 /* Destroy a dead context.  This occurs when mmput drops the
@@ -20,17 +17,18 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
  */
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 /* Switch the current MM context. */
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk);
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /* Activate a new MM instance for the current task. */
 #define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL)
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_MMU_CONTEXT_H) */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 312fcee8df2b..7a8380c63aab 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -16,17 +16,16 @@
 #include <asm-generic/mm_hooks.h>
 #include <asm/percpu.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 extern spinlock_t ctx_alloc_lock;
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
 
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
+
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 void __tsb_context_switch(unsigned long pgd_pa,
@@ -136,7 +135,6 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(active_mm, mm) switch_mm(active_mm, mm, NULL)
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
@@ -187,6 +185,8 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
-- 
2.23.0

