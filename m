Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39623003D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgG1DfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgG1DfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABE4C0619D2;
        Mon, 27 Jul 2020 20:35:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 74so1919384pfx.13;
        Mon, 27 Jul 2020 20:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qyDAiHf1mT4LwA7F2omwzQoVQ8iMHIatldNjXE0mQY=;
        b=f/Nr2b2I4ELY5hyYHRUh6KooDJAlp3MrLw/PlVdYtLw3CE1D9kZNLsNeTow4Ki4oWD
         UESIefuHP+6SCTPWw58PicUJqIO3L9dsXl1jIzmj9TiQGxEILaVEG7R2kOJBICiqHTix
         u75FgNTYAb21zm+Uw+Hfc/xghYm25Cyz+k8pml9ggMf3IQgse97CR9xKTnOzC27ELrdY
         d7ZqqozQfMo2SzG++C3CTwVzxRwkHqKzIaL4KxDjPma2BftsER8+IWR6aoBEayc5H2i1
         aRKLa6KhnKJMFNBHZewP7jZc9OR3yUynufcskhFJ3rNgmZ08TTj1LAuB71sT3Gm+blgD
         FqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qyDAiHf1mT4LwA7F2omwzQoVQ8iMHIatldNjXE0mQY=;
        b=WwEcn6FnqQUv3NYRv5B1uKnxK2dLWKVNHE9Zn1wvHM3SX69ldj7ZbojB2bVf7oOn5/
         +x4xaov/xIW0C+iG5Gfzu1ky8hORLWmRXmcZXWh3PNVtAdmuCJakiRoapsoQyUYVskhY
         5zmeJBWyjf2Q6SEiSfH05JLF5VYPuQiXX8PHyL/xAZLe1grJx/wvFmGdQ1LWKlYiz2al
         daUDQRyjd3DgtbiVUVIOu76GZIVbULrysk53sfODBfi6GcdeLd1PZIijB1TkFVElEBFz
         B411dPM3fTuUlPHQ8kRWwUNv4sfpHSKRNazUbUZN8e3ynyQ9m05O1Eez6nwuYPvqKUgf
         DoTw==
X-Gm-Message-State: AOAM530fnoj412GosmFvNsgC+wdDv/EJtkEckxnP3bpVi/KjAnElVPTt
        zYPMamiEsssiW8k7Y7n010UOWTLU
X-Google-Smtp-Source: ABdhPJz/AALwV9gd8acRqPIn+a0eJSVgKeEpHZuxSXFC2/WisGDuvgIMt1iJw+CKzEAuR/p7tE0YlA==
X-Received: by 2002:aa7:984d:: with SMTP id n13mr17303136pfq.276.1595907323703;
        Mon, 27 Jul 2020 20:35:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:23 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 17/24] riscv: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:58 +1000
Message-Id: <20200728033405.78469-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 67c463812e2d..250defa06f3a 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -13,34 +13,16 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *task)
-{
-}
-
-/* Initialize context-related info for a new mm_struct */
-static inline int init_new_context(struct task_struct *task,
-	struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
 	switch_mm(prev, next, NULL);
 }
 
-static inline void deactivate_mm(struct task_struct *task,
-	struct mm_struct *mm)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
-- 
2.23.0

