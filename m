Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98425325A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHZOyR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgHZOyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733FC061574;
        Wed, 26 Aug 2020 07:54:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so1007249plt.3;
        Wed, 26 Aug 2020 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejVWa9IRIyyHORgldOpUlCO0QqVKUsW+6Dc4qu3Phn0=;
        b=XctVkfwPbzGaK7VRZL/4atAP0TrD6yIr3b8N2BYQysAvG8Evv8vLIeE6wz4aaKAC/+
         dCAhy3KAzDaKCwAlQEs74i6Dued0wLVAeqaZbvf7zr1QqFZ9jE4mqivQXj9GbmE0qacI
         D6fc03sz5hTua9fLgGFAQ0nZq88zel22ju6hK3pBOpS454ABHuqePzYSjrOciQqHjIR+
         Omv9QRuZDuIoOxu0Q7HhhjGUUsIMKy06oD3vJ9xXW8L9Zr6bDkttwxxROFdMXxmX5e+O
         dCThA7KfzOzcdeY+hZq1XOdjCHTPxdOcg41xGTaYfNu7hToOV7/G1pKX153nuQzpfbC1
         DY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejVWa9IRIyyHORgldOpUlCO0QqVKUsW+6Dc4qu3Phn0=;
        b=ZH5rY+WMyXZvAqHEH3sudOu5yMgNM6XyG0nGR3OX4IgPR8aV3QB6SL9WjOd/+QDpSP
         eLIKwf99JNIFHyb4Knf4HV/zcbEP1FUXnPG0KVDjlYQPVzXgtMYrT7stIETIufSrjY3+
         GPbeUKflRVGBQxDu4dyNYwACxfZYzxN9Ia+3paYSz8d7CGLK8JXmLofYPzetKfO0Y+MG
         Og1UdFRHDeD3PQ4cdmZmwU3dsJJOf/lHUzO+oZ9S2pLTvNoIKOliC0VjcvIFhna9o1xz
         iC/vIE6J4sFvZIv1u5Tq/z1V3W2kc1Fy54zQxxgVUzgXsXTc9spZfrILN8zxpu+/VzUc
         5UDA==
X-Gm-Message-State: AOAM533tlc1r5Ly8TyKqSLYDEcU1X8ikmdaqmYuHX9PyPy10QJm9RD0z
        CKaRPCZnZ3KVjrS6+aNjOgEud7x7zd0=
X-Google-Smtp-Source: ABdhPJyBgv/WEt2SrS3kDrcVAYUSyhmTQdBkkzA+ev3h62om/fVzWgc43FoGxDMbX9eroQbEAoI4fQ==
X-Received: by 2002:a17:90a:6881:: with SMTP id a1mr6346313pjd.208.1598453654312;
        Wed, 26 Aug 2020 07:54:14 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:13 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v2 20/23] sparc: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:46 +1000
Message-Id: <20200826145249.745432-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

