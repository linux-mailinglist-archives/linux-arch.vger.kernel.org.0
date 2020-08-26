Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29932253278
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHZO4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgHZOxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA7C061574;
        Wed, 26 Aug 2020 07:53:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so1147168pgb.4;
        Wed, 26 Aug 2020 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuGEwlNHfczwsScET5//DK/IY7Qs+PjjbY2XOsrR6EY=;
        b=sJxfh2jJmRyJwyZjRYiK59/JqRgrFpTkVZ5xgJoltk4TDoYL+GlD9+tgJIxFMS58zE
         bVZWwfb+obCUVs74Vy+38s/0c3jNR31aeAqt65bmhYQYtabBgIbEydsGfCwHbw22HIaZ
         xBjgLEgMOymilWxmlOBg6wnsNLYEaQkNJYoynGXLUEPLUNM/pUihKqkfYim77mykoZHw
         r/99g3M/GcaRxVtbvKEmtUHqBLQQegIIytdG4HCL8pOfpNjtwUfY4x9elFPCV0UbZrmn
         nLcQ8bYgj5PDwHpwAmqejHERBakNqFdh+/LDrmy2R3t0JejiqkpszFSlXK0puSMx2qq5
         EfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuGEwlNHfczwsScET5//DK/IY7Qs+PjjbY2XOsrR6EY=;
        b=GBCuwogccHH+8e3ybkyIGK/nOOUJ1Xe+qa/YTSHTh3PWKWedhn/7GHRm2kcTTHUY0y
         sxdS1T/d17gfIznZLDunLKq4IW68jqWOPwlHOnxJi/zSspmjU0Sc2uUvy8fcsrelZgkh
         E2RWZD2tpKgEsg1hx0WsjGo3MymYkP2ewhlI0oYknqMQTy+iz2G2S7KIAqgeltZ1LZi5
         x3YJ5af6A6MCFLIaZdaN2Pem+XqDDVSm9EVtZHfBC7XwW+j8UeEZDAvNQwwz8ArGRV0I
         5Jor09um04UUuTyqpNSw+o+B9shnHe2SJoX0uZX7fu7Xvl8yyAZOHrA39azLQ8rgPgcu
         p2fQ==
X-Gm-Message-State: AOAM530rlspKk3eaApx3vg8y+XiuQi302EaqO3unPj22/tOD31oVQ7JV
        G9yTB/2TrVF0xNQKPzJejYhqXf5IOK8=
X-Google-Smtp-Source: ABdhPJwnwRk8+dVeXoz0Grl/YQQOhYKHOnjDr66zdyR/sD12wD+22g0P7kpG1iTmQ2c7J7Xd74ABaw==
X-Received: by 2002:a65:6287:: with SMTP id f7mr1593741pgv.264.1598453615205;
        Wed, 26 Aug 2020 07:53:35 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v2 10/23] microblaze: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:36 +1000
Message-Id: <20200826145249.745432-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
 arch/microblaze/include/asm/processor.h      | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index a1c7dd48454c..c2c77f708455 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -33,10 +33,6 @@
    to represent all kernel pages as shared among all contexts.
  */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 # define NO_CONTEXT	256
 # define LAST_CONTEXT	255
 # define FIRST_CONTEXT	1
@@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 			struct mm_struct *mm)
 {
@@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
 
 extern void mmu_context_init(void);
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 1ff5a82b76b6..616211871a6e 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
 #  define KSTK_EIP(task)	(task_pc(task))
 #  define KSTK_ESP(task)	(task_sp(task))
 
-/* FIXME */
-#  define deactivate_mm(tsk, mm)	do { } while (0)
-
 #  define STACK_TOP	TASK_SIZE
 #  define STACK_TOP_MAX	STACK_TOP
 
-- 
2.23.0

