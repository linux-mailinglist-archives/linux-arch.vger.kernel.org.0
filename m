Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A222590D1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgIAOje (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgIAORm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789CC06121A;
        Tue,  1 Sep 2020 07:17:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j11so594120plk.9;
        Tue, 01 Sep 2020 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=logZjoG5Aka5uBmK80AuCdh5o6UuSDKs79nfaNTTOaw=;
        b=HQu5Fv4C4UoSmrbjuziOapFF10KA+RQNesnat24CDhKtp+EaxHPoL0yaABBLA4VseX
         WaGqI8GcgcXCoIDq3vY4fY1Tr/76AO3buT3pnHIj/lLEG73T2kwzVJtocvLsVUK2H91d
         Y7162dEqcfij+2mP32Ljy4N36bqL372dR/9rzzVuK5U2E0QOUIpOe+CyTkM4SD6u+X6/
         2OUaHe9MCdh/nvcKwlIoSCxuZHpgspfPTirZPdD1RjiFJLh7aHhWtwxnes3A8PcdSsbf
         uyWUmDMHGoiYM0j5QcJn7PIaMHP0BdPA+wGfOkFex1Gb/6I6VKURNeCtSJNonR0uqvbo
         j8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=logZjoG5Aka5uBmK80AuCdh5o6UuSDKs79nfaNTTOaw=;
        b=VOCizEKBwqiYmJdr8wVdw/2xl7NC5PJUVGxBtrclmoQDfqxEKTRboZP2Q9J6UDSLoj
         vTeOVVkZeZXPeDUDLt1cWVrq3G7+e0Aya77FdItAdLwyfPVKtbZVdC8KnmFplbg14ko/
         e5XsVxVJVHMdAblcHTMP2R3WBItCBcmbwISGTVYn/1xr5VlK9o8NPX5AJou2VOPzXymI
         lUGbbXh2KR8VdjLPrd5LaA7Jc6vg4Au44Mmko01m5OX2Ef9HBX9anEqHhnA43yxXPzja
         U09eqJSevm/nVmFw2uiXJBWXE2Zm7xs8SwBbAlFLvAqj75Q836imTAOyN/B8SHSK3+Dl
         I26g==
X-Gm-Message-State: AOAM533JZDQBgckWhmJibzMkcCfID2J2XfkzoLQ0BloeNtGsz+JRhGlh
        TGsBzd0H2tDiGCnbBRXDDdDqeh0OPTo=
X-Google-Smtp-Source: ABdhPJzQTGwzDyOFh9C1LgX+8EX+CeYkOkzlMY/Z9U1HiGXP7P3RibIekHepWjyHD++l0OigZGr5aQ==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr1622424plr.58.1598969827058;
        Tue, 01 Sep 2020 07:17:07 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:17:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v3 20/23] sparc: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:36 +1000
Message-Id: <20200901141539.1757549-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

