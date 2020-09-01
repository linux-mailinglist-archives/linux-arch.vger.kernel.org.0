Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FA259112
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgIAOnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgIAOQY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A023C06125F;
        Tue,  1 Sep 2020 07:16:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np15so703531pjb.0;
        Tue, 01 Sep 2020 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvhzgkhZO1kqoSQJjNzOqYAXx9WauCb1i9WMlKWlKe8=;
        b=EcXZ93WE2aWXzV48ZN7Escs+fQSd6CU/Wkoa2qVWkkzksQSYNoBrygJbDdbC3+0mFm
         DOos39pn1mYuslZY1BZQjmDfM60TESM9RQgwh98KFByz9InAAzqdWYXR13ILXuM8fxne
         BuOHcaAbNCCzX1jk1OSUa+t4A5smR68EiGTfYXbiQ5al2NSyNPSGnu1eHlPGGyqcr9Tn
         YutzC7BU5MjT25I8KkGsYu3ibgteh5r4Bina0QoZcuJqZ8N+oET50Ai109ekvayNy3Mk
         kr4RrCSf1K40XFImfSg/4yE+MC+pGZk9lCy2G/2ZMn57DP93xPu+ku/pZpZ1LCEZyIJr
         W29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvhzgkhZO1kqoSQJjNzOqYAXx9WauCb1i9WMlKWlKe8=;
        b=O6OMTWbCO01W/UqLQOjjlPeD7592K7najpsyH80SkU4xafZWRwJhx/ocXmIuAiP4sp
         lKXWVsh6AYoH5kxRB4jrqbFj9rmyWv73U126zD9Jj3iJIccGXGRLCy+6cak3m10G4ZAL
         0WGOfNRjRrCrfvLAactaX9e2HbcgSUt+uINMqse6zM23lgAvXSDHvIGwPM0so/c59w/t
         ZJntDf9B40wcDdKTr4nlDqsLdaXwhGixW21mmCyRUOAM7c44C0PX+uiy4S0nhEvp19ST
         92vjn26NAtvcRfU2t2jLqPTyJBC1ib6SD9rOVQPy4Wbp9TTniAe6puMbjrCqtxQIJk5L
         zQgg==
X-Gm-Message-State: AOAM530B7wLuvwv8BbeMxbdSAX3S/MNFHjlC//65UOcNc7RC644nvvqO
        kRH0lr/47PCPTvDAxYDqYAQ+Arb91Io=
X-Google-Smtp-Source: ABdhPJxsgG44bWbTWPiAdffudfRe3VG6mhCW8Ffx7ERK3273FVgKG+24orA/GkxdBRoUGT226R4DlQ==
X-Received: by 2002:a17:902:b714:: with SMTP id d20mr1587452pls.103.1598969783374;
        Tue, 01 Sep 2020 07:16:23 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:25 +1000
Message-Id: <20200901141539.1757549-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linux-m68k@lists.linux-m68k.org
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/m68k/include/asm/mmu_context.h | 37 +++++++----------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index 993fd7e37069..d12d8a9032f6 100644
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
@@ -83,6 +80,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 	struct mm_struct *mm)
 {
@@ -90,8 +88,6 @@ static inline void activate_mm(struct mm_struct *active_mm,
 	set_context(mm->context, mm->pgd);
 }
 
-#define deactivate_mm(tsk, mm) do { } while (0)
-
 #define prepare_arch_switch(next) load_ksp_mmu(next)
 
 static inline void load_ksp_mmu(struct task_struct *task)
@@ -176,6 +172,7 @@ extern unsigned long get_free_context(struct mm_struct *mm);
 extern void clear_context(unsigned long context);
 
 /* set the context for a new task to unmapped */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -210,8 +207,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	activate_context(tsk->mm);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -224,6 +220,7 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -231,8 +228,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)		do { } while(0)
-
 static inline void switch_mm_0230(struct mm_struct *mm)
 {
 	unsigned long crp[2] = {
@@ -300,8 +295,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, str
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -315,24 +309,11 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 
 #endif
 
-#else /* !CONFIG_MMU */
-
-static inline int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
-{
-}
+#include <asm-generic/mmu_context.h>
 
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

