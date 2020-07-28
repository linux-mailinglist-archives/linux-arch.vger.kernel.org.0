Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889923002D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgG1DfB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgG1DfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816BC061794;
        Mon, 27 Jul 2020 20:35:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so9190548pls.4;
        Mon, 27 Jul 2020 20:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiWkNEwCCC0m6okc9WhV7jiLYdcUc3FOzWjygUNhbfY=;
        b=R59x4WUX1ge7CJHjp7PrxGdP+hoQajod9t8NFjvLRVLvs1peTEITeF3Gp27+jITFY6
         GQoi9/EQoCPfOnxLXkP60QFfYCWSUEk3eTkXFQDG4Xguo7gH94G/37wS49eJT7z+YrCB
         t+RbWg7MuO/Y/4E7YJoEiKhWZZeXAH0Qe9n5b5qfzTJCR04vvxQi6Go4PeF2Jjhqg4Xh
         17wdDPEF5ZtwdcKNb8nZb/v5B5Lf+XnKAQAzkxZI33zWGNV6HYMtiXt9O9x6JmS7FN92
         eLf5M3eUdmffl7AUPxZUBULkdVbqsd2wMnbu7a2v9vLL3TyoTRtKsQXPZ5cfBIxmBlRR
         fgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TiWkNEwCCC0m6okc9WhV7jiLYdcUc3FOzWjygUNhbfY=;
        b=gzuXM3ApYqicnRxEjZPemaRpG5eNri7fdozwgntKlVTZjoD4TvrvEBtnfbyQc9dpPm
         4lsEXGmFoWyyEdMkZogVEmyPaA7w3IulzUfgxQvrbVORm7nO5h1mUXR+rXBoFOFBF1H2
         jtkp5A/bwMjbO3Sp+r8BBCk4Ynrd0Dd+vQzmP88WooRrj/KGNNiSRZymWtR1ekESZtOY
         hVkZUvm1tm3TDfER1JK9MG9Eqm8sw7ZNDntGbytYcP3HhAcQmTK4rcDzdoeLVb7mr9Fn
         grigASNR3kyiKHu0aeWfsa63c1s+fxBI129kfzuTiLaCL9AMHyxSEPqIDVgE6DwtKEtO
         UPrw==
X-Gm-Message-State: AOAM531Ns9nZJGm9S9ZBMe1hNIxpbReBAlfxXVy5ssJvmBrSiJRFKaCV
        bBZS4BT8rn0QWuLl2Net3dW1wRwb
X-Google-Smtp-Source: ABdhPJxRYhI8/MsagOMafo1pS6zstDzKFOU2r074Wy/70Oqrct466kgOSbiaCGCHCixCD0dMGIKZ1Q==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr10131584pls.48.1595907300090;
        Mon, 27 Jul 2020 20:35:00 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:59 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 11/24] mips: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:52 +1000
Message-Id: <20200728033405.78469-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/mips/include/asm/mmu_context.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index cddead91acd4..ed9f2d748f63 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -124,10 +124,6 @@ static inline void set_cpu_context(unsigned int cpu,
 #define cpu_asid(cpu, mm) \
 	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 extern void get_new_mmu_context(struct mm_struct *mm);
 extern void check_mmu_context(struct mm_struct *mm);
 extern void check_switch_mmu_context(struct mm_struct *mm);
@@ -136,6 +132,7 @@ extern void check_switch_mmu_context(struct mm_struct *mm);
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -180,14 +177,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	dsemul_mm_cleanup(mm);
 }
 
-#define activate_mm(prev, next)	switch_mm(prev, next, current)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 static inline void
 drop_mmu_context(struct mm_struct *mm)
 {
@@ -237,4 +232,6 @@ drop_mmu_context(struct mm_struct *mm)
 	local_irq_restore(flags);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_MMU_CONTEXT_H */
-- 
2.23.0

