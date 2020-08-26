Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD509253276
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHZOxg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgHZOxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAEBC061756;
        Wed, 26 Aug 2020 07:53:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so1007011plb.12;
        Wed, 26 Aug 2020 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iI/2kk53gpQ9Rn/t0izdpZaGmK63P9KDTKwfGTyE5K8=;
        b=ivH/yedoVnRQZaiOBDE/q7i/+LlZQz4//Ac22EjXgDSh5z78UsF2b3rYcAwUTE0VWw
         O3akOdfpfDZPuTGaKWobUg/CtUCnIsUjZftQct3FOb1jPRlUQiNj8Fv+ayC2WGX+PO8a
         /9s+V/UtihMnFt2SYw1P9GmmaSFbh6cIMV4SiwgDzxT77fX3hxPs3DulQ2yS3Lax/rmT
         UUjOnKVv80yVYX48yH/r8Tek/OFxlP6Uka0D+brPaZFXo+5qiKdS6/iqg/yaUG6Lirw7
         +rj1zbW6R6r+NiEzsswvBgZahXYbQKL5Bcp2cARCgQbVcP55dthWgJ0T/81aUNEM+sK1
         +MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iI/2kk53gpQ9Rn/t0izdpZaGmK63P9KDTKwfGTyE5K8=;
        b=irwP0BoUJ78VwKPHzpKmVvj2TYqDtrTvlPVO/OLau83wxqrsLtl9Gt6W4EtlcAWFv2
         1zc8+hlsfLGBmA6UEsCA+nyInh9k+qravco3qo077CdL+DTPaWmds+g6F1Njho9E+t3X
         HKhJjZaSX5DOxqPcNRY2lQNbhHcnyiIdd7z1SbRsLroqtcP+scjnyPVVp4s5RH2ODi/N
         Ll9HKc4j2D79yX5vYSXCrxltn5DgEVGrughERFXiqIm4U9eBfvLm8lCbKwvFwlVsqRVl
         Mvei3x59oPro8Es0QdPhArVq2uDNqPIWdRHCbcOicqSDpRNQrnvT0uNzqMB50sww4ncg
         kyeg==
X-Gm-Message-State: AOAM531TuibKJSP2herhaKYXNVE8YfvwdWauCrIg7zsaHA09TCR9Fbb3
        fPF1a0gjhWlI5i1GdfHgC9EOzslIgF0=
X-Google-Smtp-Source: ABdhPJwc2cHai12HbnvF2E57CKh2UaXXeM4qGHmYIx+dAfw9+5a/wogaP6zNkYnmdj+Nj5MlwPj4Xg==
X-Received: by 2002:a17:902:a617:: with SMTP id u23mr11640565plq.188.1598453611955;
        Wed, 26 Aug 2020 07:53:31 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:31 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:35 +1000
Message-Id: <20200826145249.745432-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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
index 993fd7e37069..012e92204c1b 100644
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
 #include <asm/cacheflush.h>
 
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

