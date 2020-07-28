Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB2230014
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG1DeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgG1DeX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F7C061794;
        Mon, 27 Jul 2020 20:34:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so1918376pfx.13;
        Mon, 27 Jul 2020 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNMTof0l4PGDKx//U8EznfVdFXT8uQz00c6nfwI09vU=;
        b=NV3oI/fpcjeCk/yITe9+HjWezuyDgzgaUD0PzTurnuwFwx7ZZcjU1n5WBCt3cBz1yA
         /f/82czN6VwzEt1HY8TmOyDa6KuWsdcoNlKPpj72h1aCV5iteqFYQffo9xbG6U3FEtIu
         YFlI3SfPlb/iq54tNkxzCOBz3gSnq4ldojcvwtrN60Cl47ikp5Y0+lvEkVgWuUAsWzgd
         JStEqQUjt0KZOtRP+v2Zd6tE4oF1v3b1JM3ZX9o3TUerw7KZoMNL6Kx389bNtbbadz4e
         mQhhAUXjDnCFuA65uJrbzgjIruO3CBsLzVQmgzOfQuhVqbtwctpqJ3P0ibrYud5BtsNa
         xq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNMTof0l4PGDKx//U8EznfVdFXT8uQz00c6nfwI09vU=;
        b=TQLuexx59hibzfCh6KNltqBSnAG9ODt+dJvRBk9h0U2zoFKPq2u7BaeiSUp62Gm41z
         QUfWU6AcTqe0YaNLLK98nX5wJDdoWcNLaKIQZqVbb16dMJbLRCvkt9JwBXt46DJM9yzn
         eUtNX6YUj3JD0GYzq0flCFpW9EeHg36qObhmKJfKGOaW3zQP9g8vEgpvLG34BIvECgDr
         mxJDpO011uWt6KHUIaBmSjuZn023VuL6EPB9HaNiIfydHCxxNDOHrTwd/EnXZcJMF/Z6
         Q9UNA3tK60p1gN68YuYhEGoYO1nWbdxJyaOZd45XKNpJG3oH9NOmsa8/pwwoys9BPYlI
         XZFw==
X-Gm-Message-State: AOAM533OR9Y7jDdGGQGxzzv/v1pNno+qvZ+1BONOctNbtNTAKlAVlQ9S
        7f7WK6ZEPJKqOCOEHjtUghrTjXCg
X-Google-Smtp-Source: ABdhPJzIZmb4//zhUgm7WVIq97uNgmKXR8dZct8TvjC0WASMhdoxkkDt8mfIQM/060jVkAhMYMuACA==
X-Received: by 2002:aa7:9575:: with SMTP id x21mr22514854pfq.140.1595907262508;
        Mon, 27 Jul 2020 20:34:22 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/24] asm-generic: add generic versions of mmu context functions
Date:   Tue, 28 Jul 2020 13:33:42 +1000
Message-Id: <20200728033405.78469-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Many of these are no-ops on many architectures, so extend mmu_context.h
to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/microblaze/include/asm/mmu_context.h |  2 +-
 arch/sh/include/asm/mmu_context.h         |  2 +-
 include/asm-generic/mmu_context.h         | 57 +++++++++++++++++------
 include/asm-generic/nommu_context.h       | 19 ++++++++
 4 files changed, 64 insertions(+), 16 deletions(-)
 create mode 100644 include/asm-generic/nommu_context.h

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
index 48e67d544d53..9470d17c71c2 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -134,7 +134,7 @@ static inline void switch_mm(struct mm_struct *prev,
 #define set_TTB(pgd)			do { } while (0)
 #define get_TTB()			(0)
 
-#include <asm-generic/mmu_context.h>
+#include <asm-generic/nommu_context.h>
 
 #endif /* CONFIG_MMU */
 
diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 6be9106fb6fb..86cea80a50df 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -3,44 +3,73 @@
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
index 000000000000..72b8d8b1d81e
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
+
+#include <asm-generic/mm_hooks.h>
+#include <asm-generic/mmu_context.h>
+
+static inline void switch_mm(struct mm_struct *prev,
+			struct mm_struct *next,
+			struct task_struct *tsk)
+{
+}
+
+#endif /* __ASM_GENERIC_NOMMU_H */
-- 
2.23.0

