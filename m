Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6425328E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHZOxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgHZOxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BC0C061756;
        Wed, 26 Aug 2020 07:53:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p15so1005002pli.6;
        Wed, 26 Aug 2020 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCbHJAKt6s3Rg7aETluYBz2dgq5UZfILUQ6bXeRl1rk=;
        b=JFLQL9pF17QewiL9TU4uewxOTLOFRNMQOli4TMrEuETfwo/6esVbfyU6Ahe1MfaHkH
         cTd+2///YrMYsvPAmRjXJ1duj4WyJw0/PWFbevsAci3/nVXGUIHmbh4FChbxTwo7doiQ
         d5n4jvE9I/mcTol6e2hEfq6S9Uze1e2gMjvlMdFxpfDHlHmwo89kKUeQTw3UYIakmkOk
         YYs6+LfR725QpB4O9TTDVK96Zdctt/B0/6f9XemqLXdUPGPwf1G7lma7psuLf2IbTjqE
         siGafEgsR9TJ8VpG6eXtUXONVzZQ2x6/1GkrxSEz45dLKEhKlYhfUSTPRbw3jJZ5OvNs
         rXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCbHJAKt6s3Rg7aETluYBz2dgq5UZfILUQ6bXeRl1rk=;
        b=J2As71WoKOjsvholk/qFJAhm3UyvkjvnnxVpS6BrADTQjPt+A6UE9hxCngQSf7lT+G
         ORU7Aux5Gk4Im7LeuQENF7xfa9NKhoWsSjn+RigUuvB6p9/URO5nvSKJy/B1i13VCqZS
         lRd6nBh2OUBOGgTZ1pQsWu2iH2m5wQUt4astdYw6iDrCmOF2KaoOEhMJwUHZ5hgZGqRK
         x0JuxNTwYFeN8+mhzulHWNGzkpUX/jTPlHqzBAAULEcCvrqVd9qygMfGrUkV2yOh4tzU
         E3eCrkZLI23vXA2m0lSKdOUOk42bi7w75TJg+dvvdtpLWwvYtdcnd+JCwuwYKrdYfrNL
         D3BA==
X-Gm-Message-State: AOAM533SWUJunBj7YEU49RiVG//lsaGv/p+jxsylWPjOXGZ/prJlfNma
        SdVe0qZ8BARiY+rw9btfAE1Mhpr+HKU=
X-Google-Smtp-Source: ABdhPJz1B2LT8vTgec8GC+tIrYzicFVFqQk7kgNC8WGWbvfQf4pVrR0CYZjevi8n5mGkopGMi9zsug==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr6072843pjh.221.1598453581516;
        Wed, 26 Aug 2020 07:53:01 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:01 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/23] asm-generic: add generic MMU versions of mmu context functions
Date:   Thu, 27 Aug 2020 00:52:27 +1000
Message-Id: <20200826145249.745432-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

