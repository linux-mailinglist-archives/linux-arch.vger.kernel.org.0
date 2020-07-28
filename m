Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07100230025
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgG1Dej (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgG1Dej (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04DC061794;
        Mon, 27 Jul 2020 20:34:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so2282868pfl.11;
        Mon, 27 Jul 2020 20:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLCo3Tk+lxREvcakRGac/Ng0j4T/GOteVNveKT3Mrb0=;
        b=HnC3UjGv+m0tU9xTbpRWvbcPR7+Lt5ZN3EL28a/0mi8A/q+hbAczLsS3nUVqiGLiuW
         EiniTd5jtilMJZFmO0PMPi7a+blkrENBtM9oMLNODC3zJ47JaPCeNqklG71kRDoh3yFg
         HbK9DYUTb1/8B4ykFsAsLsGEaFwWbbZaMVEeU4Sbgx5UK14DK3qtAZCGtxeaOhNf08r0
         zXZDVWgYlqQZlIVKaXvX+ouKXW+XvptAqLX+kha+1E4F2czSCLJ7mOTKjpTzZs4YhJar
         g0BmGmRvqG/YhqfVf5PSUeEfeLMeOi5zfXVLkGmM+O9wSf+9XGCZHQYm6CxvjAxMo36Z
         NjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLCo3Tk+lxREvcakRGac/Ng0j4T/GOteVNveKT3Mrb0=;
        b=HvNnUn7FE8whr5jfQYC41JhNgrhUz5zIlIMaiWPUjQnfDq6mB/VSfMfAdzM6d+T3VM
         MeENMDR2mxBi5/4YHO4RMfuKgt3xWU4LnujbaVWSqYtJaNSlG6LdLcSrYSVGmtGpHM/D
         cmfPbdAwTGydxgo1Kb5m2ELYzaPT/bF1CeB6a7Rm4f11geGy7w0vDodKXh3H0gI1xr6R
         JsRKPB4xrOsGQm/jyYvBKkEfkox8Iqmta+aINhIGSi2++54buGNdvynbT2wgFpv/XDJu
         ta5sH3q1CPeGheniNxh3Kc79KhQb6+EFRK91kum/t+g4LXN7cStAfIdsOdGDJKKdBWkI
         zUyA==
X-Gm-Message-State: AOAM5301of39tlikTK9Z3xwjzIvpkch4tQ2YLw74W90rBAmypGCL3liu
        ud6445GCZ6cKQWcyGB32jfxzZjFf
X-Google-Smtp-Source: ABdhPJxqkjcQJjy20YQ8lm0iiv+MQTiwXbUI2uiLeEqgTNovbPmCo9H8X++qot7CTFtYr/wPKm7S+g==
X-Received: by 2002:a63:395:: with SMTP id 143mr16621520pgd.57.1595907278354;
        Mon, 27 Jul 2020 20:34:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:37 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/24] arm64: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:46 +1000
Message-Id: <20200728033405.78469-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b0bd9b55594c..0f5e351f586a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,7 +174,6 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly when you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -244,12 +244,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	update_saved_ttbr0(tsk, next);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, current)
-
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
-- 
2.23.0

