Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13B25912C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIAOrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgIAOPx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:15:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A2C06125E;
        Tue,  1 Sep 2020 07:15:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so859908pfb.6;
        Tue, 01 Sep 2020 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DD+NHkNz//cJ/l/7deT3g02opc5NfKv/2SZ3eKZT8h0=;
        b=G7S8DAAC/HQ1g+FV88jEIa/Jmk+mIymnXDOsHhmBoiLY8bdSi4j2s0Jioaz2HEhh/A
         jPJhu+mTn4+GpDygwJBvQ+QDADiHp3MOo0oTNtF7u3pJlTs0SjcxDlS+rASyy7mg8C2N
         InXYMk+m6ySJbdDz4mlBXc1sLQEQrlV8YggBPYQ0i61u6I7EXeJnDxQuumHtfkukhj/X
         nPP4kT3CvJ5vl/YPsPwwNRR8dMCA9WoqjXFdHdFJSM7bffPKpNxDsWoAu0iVqCvnwY/W
         NJiRVAvbWkjBODv8vQ+ADt2F/38EfuTi6zTWvnpDtn0QZ+/ek4fgOG8p6Omys8nVs9Jz
         C/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DD+NHkNz//cJ/l/7deT3g02opc5NfKv/2SZ3eKZT8h0=;
        b=ay37tXr3Jhw4d+6R/v6zqTEFdcUJOveGuJetOPXkVmEYGt9Tj81Wx2pimO2nlhMLrb
         fNk1D2l3rJqTvSpb5uSIWyWtNpAVJRSgfiLZQ9cOhHyVM45yPlW6Z3h2rdfQt2U8GD4k
         pkoHChxczIPnQEBW+JPDQs/ozXveTaVgRwxhtcG3lbw9ELUfH3FT3TZrn4SxxNpaO6Ha
         SVYx7D+prGNv+u/qXVmCJTUUzqn466FWJYpZGh9+qRIiQL6HG0BkSZDAC5+jKX0YThFe
         VS11zA3T1OXI1sORRiI8d99WVvDTmxgk19RtBQi5I1oSzkFHGS0W1ScCTkfTLfibfO5b
         mSlw==
X-Gm-Message-State: AOAM532C7DBY4EEmpuNqnkBD63/DXlTR8px9tQXRnIbtEv9u2vVLttOP
        /UHBm8bfyBvjALRtPB0R2/5X7KPgehc=
X-Google-Smtp-Source: ABdhPJyjxjgc9+p9Eqs93m0oRM6EvqZHzcjtwlF7foeZidiL83luX6Sa0saoCyXVuknBGZtaORfSLQ==
X-Received: by 2002:aa7:9d8b:: with SMTP id f11mr2036814pfq.5.1598969752061;
        Tue, 01 Sep 2020 07:15:52 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:15:51 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 01/23] asm-generic: add generic MMU versions of mmu context functions
Date:   Wed,  2 Sep 2020 00:15:17 +1000
Message-Id: <20200901141539.1757549-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Many of these are no-ops on many architectures, so extend mmu_context.h
to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h

Cc: linux-arch@vger.kernel.org
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/c6x/include/asm/mmu_context.h        |  6 +++
 arch/microblaze/include/asm/mmu_context.h |  2 +-
 arch/sh/include/asm/mmu_context.h         |  2 +-
 include/asm-generic/mmu_context.h         | 58 +++++++++++++++++------
 include/asm-generic/nommu_context.h       | 19 ++++++++
 5 files changed, 71 insertions(+), 16 deletions(-)
 create mode 100644 arch/c6x/include/asm/mmu_context.h
 create mode 100644 include/asm-generic/nommu_context.h

diff --git a/arch/c6x/include/asm/mmu_context.h b/arch/c6x/include/asm/mmu_context.h
new file mode 100644
index 000000000000..d2659d0a3297
--- /dev/null
+++ b/arch/c6x/include/asm/mmu_context.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_C6X_MMU_CONTEXT_H
+#define _ASM_C6X_MMU_CONTEXT_H
+
+#include <asm-generic/nommu_context.h>
+
+#endif /* _ASM_C6X_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/mmu_context.h b/arch/microblaze/include/asm/mmu_context.h
index f74f9da07fdc..34004efb3def 100644
--- a/arch/microblaze/include/asm/mmu_context.h
+++ b/arch/microblaze/include/asm/mmu_context.h
@@ -2,5 +2,5 @@
 #ifdef CONFIG_MMU
 # include <asm/mmu_context_mm.h>
 #else
-# include <asm-generic/mmu_context.h>
+# include <asm-generic/nommu_context.h>
 #endif
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index f664e51e8a15..461b1304580b 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -133,7 +133,7 @@ static inline void switch_mm(struct mm_struct *prev,
 #define set_TTB(pgd)			do { } while (0)
 #define get_TTB()			(0)
 
-#include <asm-generic/mmu_context.h>
+#include <asm-generic/nommu_context.h>
 
 #endif /* CONFIG_MMU */
 
diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 6be9106fb6fb..91727065bacb 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -3,44 +3,74 @@
 #define __ASM_GENERIC_MMU_CONTEXT_H
 
 /*
- * Generic hooks for NOMMU architectures, which do not need to do
- * anything special here.
+ * Generic hooks to implement no-op functionality.
  */
 
-#include <asm-generic/mm_hooks.h>
-
 struct task_struct;
 struct mm_struct;
 
+/*
+ * enter_lazy_tlb - Called when "tsk" is about to enter lazy TLB mode.
+ *
+ * @mm:  the currently active mm context which is becoming lazy
+ * @tsk: task which is entering lazy tlb
+ *
+ * tsk->mm will be NULL
+ */
+#ifndef enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 			struct task_struct *tsk)
 {
 }
+#endif
 
+/**
+ * init_new_context - Initialize context of a new mm_struct.
+ * @tsk: task struct for the mm
+ * @mm:  the new mm struct
+ * @return: 0 on success, -errno on failure
+ */
+#ifndef init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 			struct mm_struct *mm)
 {
 	return 0;
 }
+#endif
 
+/**
+ * destroy_context - Undo init_new_context when the mm is going away
+ * @mm: old mm struct
+ */
+#ifndef destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 }
+#endif
 
-static inline void deactivate_mm(struct task_struct *task,
-			struct mm_struct *mm)
-{
-}
-
-static inline void switch_mm(struct mm_struct *prev,
-			struct mm_struct *next,
-			struct task_struct *tsk)
+/**
+ * activate_mm - called after exec switches the current task to a new mm, to switch to it
+ * @prev_mm: previous mm of this task
+ * @next_mm: new mm
+ */
+#ifndef activate_mm
+static inline void activate_mm(struct mm_struct *prev_mm,
+			       struct mm_struct *next_mm)
 {
+	switch_mm(prev_mm, next_mm, current);
 }
+#endif
 
-static inline void activate_mm(struct mm_struct *prev_mm,
-			       struct mm_struct *next_mm)
+/**
+ * dectivate_mm - called when an mm is released after exit or exec switches away from it
+ * @tsk: the task
+ * @mm:  the old mm
+ */
+#ifndef deactivate_mm
+static inline void deactivate_mm(struct task_struct *tsk,
+			struct mm_struct *mm)
 {
 }
+#endif
 
 #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
diff --git a/include/asm-generic/nommu_context.h b/include/asm-generic/nommu_context.h
new file mode 100644
index 000000000000..4f916f9e16cd
--- /dev/null
+++ b/include/asm-generic/nommu_context.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_NOMMU_H
+#define __ASM_GENERIC_NOMMU_H
+
+/*
+ * Generic hooks for NOMMU architectures, which do not need to do
+ * anything special here.
+ */
+#include <asm-generic/mm_hooks.h>
+
+static inline void switch_mm(struct mm_struct *prev,
+			struct mm_struct *next,
+			struct task_struct *tsk)
+{
+}
+
+#include <asm-generic/mmu_context.h>
+
+#endif /* __ASM_GENERIC_NOMMU_H */
-- 
2.23.0

