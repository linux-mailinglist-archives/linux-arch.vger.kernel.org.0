Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A117230029
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG1Dey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgG1Dey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A0BC0619D2;
        Mon, 27 Jul 2020 20:34:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j20so10175486pfe.5;
        Mon, 27 Jul 2020 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H36cGMxHQ8BRm6wAF0579NyVmdPCO4iD8RgcvZW00go=;
        b=ZbpL9/1Ay/N9a5W5SHzbKHeCmcXXyhgdUM1zeQaWohbRyeJkrKXcxd+Tgh12sMDZuI
         moTVnVoeT0/WcuXz1Fvqm1fRKZ+6EcG1BRkppL38LtfukqCrGWniBKUagXbrHNvgddXB
         5O7KUvItxpvNqrX1BlhQS6QBB3JPYVEKPpGLHbMD41QJfY3m5dZKzO1TVAOcP7xndLSM
         gjCrZJbmiFAfk89S9O2q6cjg9orGY1gODQZB+bAECk//GJCoe8Upi3yPoNJ3jZELQLVV
         G12fEtcevoV4SOnILf2SpvUvHxG4Q7n6zc9fdsD+bRtSmamMlj02wT10XENLMTGLDmUf
         vwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H36cGMxHQ8BRm6wAF0579NyVmdPCO4iD8RgcvZW00go=;
        b=dNYyCZUHqhaDJZBhXHC1sSk6HFlM1OxasA0UDqXF6laqBU9giJCdiWLzOrg4UGWd5K
         iLzJZMXikAa6SBKH0bEmuZyJ22H0NDEe0IoGM1uHm3VvI2MllL6cnGr6m98/LWqjr7GR
         pIfmWoPVsH7pfkv5E25F0ST1sPe+COw0AWj58ZepGQsJzzGyd78MY4f3FKe2QNB4YEf3
         pKl4RIRG/P8wHnc46hSqGDVxwBbSPXW6I5rF/KBpljAKflj/Z28cgDQsV+EYNdrbIwFh
         B+RcLNvSur93rTWJdQuNxfoxO3NBp7z6XnV+Poy4cQ481zP/PW6DGrtT3TMSRWI3jcQK
         NuHg==
X-Gm-Message-State: AOAM531D2zZX7m3CguUa9FPkmdUsY74X+GxiJBzAcDzNEk0PH3HTye+i
        83ur5J3NscpXvd5mhu//g9dRWP8F
X-Google-Smtp-Source: ABdhPJzJR5NRXF3FPFa4PxoySWuPRzG3iBzf77Gh7wQNEZ7DHgBwvAi63TXh9kJn8Ls/uFAlU1Z9vw==
X-Received: by 2002:aa7:9ac6:: with SMTP id x6mr22895541pfp.326.1595907293192;
        Mon, 27 Jul 2020 20:34:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:52 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 09/24] m68k: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:50 +1000
Message-Id: <20200728033405.78469-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/m68k/include/asm/mmu_context.h | 47 +++++------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index cac9f289d1f6..56ae27322178 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -5,10 +5,6 @@
 #include <asm-generic/mm_hooks.h>
 #include <linux/mm_types.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 #ifdef CONFIG_MMU
 
 #if defined(CONFIG_COLDFIRE)
@@ -58,6 +54,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	set_context(tsk->mm->context, next->pgd);
 }
 
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *active_mm,
-	struct mm_struct *mm)
-{
-	get_mmu_context(mm);
-	set_context(mm->context, mm->pgd);
-}
-
-#define deactivate_mm(tsk, mm) do { } while (0)
-
 #define prepare_arch_switch(next) load_ksp_mmu(next)
 
 static inline void load_ksp_mmu(struct task_struct *task)
@@ -176,6 +160,7 @@ extern unsigned long get_free_context(struct mm_struct *mm);
 extern void clear_context(unsigned long context);
 
 /* set the context for a new task to unmapped */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -210,8 +195,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	activate_context(tsk->mm);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -224,6 +208,7 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -231,8 +216,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)		do { } while(0)
-
 static inline void switch_mm_0230(struct mm_struct *mm)
 {
 	unsigned long crp[2] = {
@@ -300,8 +283,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, str
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -315,24 +297,11 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 
 #endif
 
-#else /* !CONFIG_MMU */
+#include <asm-generic/mmu_context.h>
 
-static inline int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
-{
-}
-
-#define destroy_context(mm)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#else /* !CONFIG_MMU */
 
-static inline void activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
-{
-}
+#include <asm-generic/nommu_context.h>
 
 #endif /* CONFIG_MMU */
 #endif /* __M68K_MMU_CONTEXT_H */
-- 
2.23.0

