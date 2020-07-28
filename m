Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96661230034
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgG1DfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgG1DfH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D8C061794;
        Mon, 27 Jul 2020 20:35:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so1376256plk.13;
        Mon, 27 Jul 2020 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ/aO+zurNWmpqKHI4M9C4MJyyXJq3JocP1DjUq4gbg=;
        b=kt3a7DcCE2OYOZGqgxog9VS3yxsHpUCtaORYop80F/jti3DEhy2oQQTgTbv82uTF7N
         xbMy5O15+dE0gYE5VRK61ptgd0R7KhE9ZKgBWnb5c6pmv4ahqQPVLKJzDpGGakypQdLX
         89jCphB7fzgC28R1M7cfG5m2IvMZJwbXT49a0TiDARpVwt0ym4Ad0Rm2ntSFKmPQ8Eel
         GnOijbc0LAx8HVuZoORV9Kq8hQ96CkumFJdcnuxAicDHMtPjppLB8sordXVwoSz3YKND
         hkqC1QPNsA0tM1j+79ttQsnMzw2g5+SJPTnPI3LVZJAvnTAwR01pNZ+GbQ4TJUHr+OIy
         d9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ/aO+zurNWmpqKHI4M9C4MJyyXJq3JocP1DjUq4gbg=;
        b=qtngq8onXoeVy6k/BPUIMWWcXQmTLB/Xp/XyKTFox6WXCCa13NQdql5pTERjyuNl7D
         e6yFKtKnbmPE/d2+E4JZvlWNyoAWbiVxxiJM8hqB/WftHNvK/ULRGHBTV1GV8ptp7lbc
         tLIcjh+be1Wnblmjo5bZRKZozm/x9UB8leLNkj9wdoiwvZEWKBnBZ+uPdTIkhclWWBYb
         wsuKb7NeTXE7/OBYRVPdpdeEN+E4KnDWe4y3jfiEvpa5wTnuoDZdNbsuXd5f6Q0j4Crd
         HV0+jXUmkp96DJj2x09GggdCbqwCVJzv2WLAyhr+RNfEAe76u/NWOpFiRPnINtjq4lJb
         WXlw==
X-Gm-Message-State: AOAM531l3t8xlmmMlbRuAWPhSs0uKFeQr34+2kS/l33yrvE9L2R9mzeU
        NXKmxIJBENh451AUECdDxLEP9ekb
X-Google-Smtp-Source: ABdhPJy6usEQ2VKD5ybwcbdeNYJvLxnt1A9ODzbNYWx50o5LQWfVKGaEFhJrpjeIx+Pr443bgEgg4g==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr2214096pjw.233.1595907307262;
        Mon, 27 Jul 2020 20:35:07 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 13/24] nios2: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:54 +1000
Message-Id: <20200728033405.78469-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nios2/include/asm/mmu_context.h | 21 ++++-----------------
 arch/nios2/mm/mmu_context.c          |  1 +
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/nios2/include/asm/mmu_context.h b/arch/nios2/include/asm/mmu_context.h
index 78ab3dacf579..4f99ed09b5a7 100644
--- a/arch/nios2/include/asm/mmu_context.h
+++ b/arch/nios2/include/asm/mmu_context.h
@@ -26,16 +26,13 @@ extern unsigned long get_pid_from_context(mm_context_t *ctx);
  */
 extern pgd_t *pgd_current;
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * Initialize the context related info for a new mm_struct instance.
  *
  * Set all new contexts to 0, that way the generation will never match
  * the currently running generation when this context is switched in.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 					struct mm_struct *mm)
 {
@@ -43,26 +40,16 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		struct task_struct *tsk);
 
-static inline void deactivate_mm(struct task_struct *tsk,
-				struct mm_struct *mm)
-{
-}
-
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_NIOS2_MMU_CONTEXT_H */
diff --git a/arch/nios2/mm/mmu_context.c b/arch/nios2/mm/mmu_context.c
index 45d6b9c58d67..d77aa542deb2 100644
--- a/arch/nios2/mm/mmu_context.c
+++ b/arch/nios2/mm/mmu_context.c
@@ -103,6 +103,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	next->context = get_new_context();
-- 
2.23.0

