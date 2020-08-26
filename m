Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE66825327B
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHZO4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHZOx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14285C061574;
        Wed, 26 Aug 2020 07:53:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so1006369pjv.0;
        Wed, 26 Aug 2020 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qg+y9mENI5s/3Hp67w0VaPORZ5hguo4wpnU/9+nxop0=;
        b=tsB9NPIEI2EV4l5chpZ1VShXia7MBk6qDAmAUpkG9ydb8tuPVcG7JMZoeW+T3Dm2iS
         e40Z2DodY0kzrfIXcRQurr+mSfPL1M/qXx7wA4be0OVqeI3IQaidHUMGOwP10prR0EPY
         qoFo6VNRBvU7kRfqumOH9/pppYWEM9JTk+Ll0/MwYzIZHhzT9FhJSBa/tCKl0ZA4Robn
         BgZQ9bVnjbQVXNaQMmO2ezalhPNHWabMU0XVtcgr+WD4L48+QRPBjc5TlsNohUZd/9nd
         BfpNS60rOmiEIrOzyFvqQaD6ph5N6Zptier4k2fdQwL2IxdVsSaIKQiLZw9tz4lOnRxj
         Nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qg+y9mENI5s/3Hp67w0VaPORZ5hguo4wpnU/9+nxop0=;
        b=Xd+uMf+HUnu7pXTwnN0JBStoXyvfN3+wjM7c4m1O2qpieP0YcK55FmZrwFUmO1Nhml
         R6ZGfkUxXjcT9QPX0GH9Ddk/ZgOzaDtgG1gM5kK1mUNmPRDDkyw+Xb+G2MxM/70At/St
         UQ0sMFzve8j9VK2KpLLtzg3ukVFZ8y68ri9yEypMfrimvv5EfrKYz8L9tJssk2AWZ6Du
         1AtWTLzdEIheZi83tLJJPjQBO3VSGIXOKiXvE3bSosA/N1B5uOxNhDc2Se1MBamjMhxc
         06OgydwUC8JRhRfqv77JVbX4Nq0ygqVogs6WfXzW/KDUWBg8Ws6ZD8Ok/ir6/qftfS4x
         ClNg==
X-Gm-Message-State: AOAM533Y/pyLjlwnhdmFPYxytPTREL+jDSPJCt7krqEWiQQ7G7G8Y24Z
        D18XJWzWliQFTkUAyKz9mVsxVcCbwdA=
X-Google-Smtp-Source: ABdhPJzXkvb6xSDZr6SiieiLkOWMoxXqqyGTyYFG5Tva+Dhu45xbd/y2npDHNcyNJHrmj3G3xfZp9Q==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr12355577pll.258.1598453608407;
        Wed, 26 Aug 2020 07:53:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH v2 08/23] ia64: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:34 +1000
Message-Id: <20200826145249.745432-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/ia64/include/asm/mmu_context.h | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
index 2da0e2eb036b..87a0d5bc11ef 100644
--- a/arch/ia64/include/asm/mmu_context.h
+++ b/arch/ia64/include/asm/mmu_context.h
@@ -49,11 +49,6 @@ DECLARE_PER_CPU(u8, ia64_need_tlb_flush);
 extern void mmu_context_init (void);
 extern void wrap_mmu_context (struct mm_struct *mm);
 
-static inline void
-enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * When the context counter wraps around all TLBs need to be flushed because
  * an old context number might have been reused. This is signalled by the
@@ -116,6 +111,7 @@ get_mmu_context (struct mm_struct *mm)
  * Initialize context number to some sane value.  MM is guaranteed to be a
  * brand-new address-space, so no TLB flushing is needed, ever.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context (struct task_struct *p, struct mm_struct *mm)
 {
@@ -123,12 +119,6 @@ init_new_context (struct task_struct *p, struct mm_struct *mm)
 	return 0;
 }
 
-static inline void
-destroy_context (struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
 static inline void
 reload_context (nv_mm_context_t context)
 {
@@ -178,11 +168,10 @@ activate_context (struct mm_struct *mm)
 	} while (unlikely(context != mm->context));
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /*
  * Switch from address space PREV to address space NEXT.
  */
+#define activate_mm activate_mm
 static inline void
 activate_mm (struct mm_struct *prev, struct mm_struct *next)
 {
@@ -196,5 +185,7 @@ activate_mm (struct mm_struct *prev, struct mm_struct *next)
 
 #define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_mm)
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
-- 
2.23.0

