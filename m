Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8C25328D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHZO5O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgHZOxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB630C061756;
        Wed, 26 Aug 2020 07:53:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so1120892pfn.0;
        Wed, 26 Aug 2020 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRVo5HKDem8WxmcB1xWWA3LpL1WS5jJLaPxEr9bIN0g=;
        b=fSSBLXXXk2qS/LnVPa23lP13CmKBs1rky8hMENw53CWEEBphdlvfZ9/MTpLCvRZMD/
         ycGkdaD75uWOC76qpFqWC3i9Ck7qpJ1p/XO6hB+56qb22OcfnRShNTxizaIF7L6eyBpv
         EPtVWcKJsLuSDYbDXBkHS2U4vr9s3hz0CGyh/m/Fc6S1YOceeG5gNQGlgHP+1AMWGpRf
         4W0AzdqgZnJ7zAoD95zfCANL1wt2adlM/wOzy9AFxQfPK7mZSNL1zy3SQcTWBhNl8YFG
         PYeR0RXcuAUoSrj/mEEok3rT9xm4gbcbyoXfIztDu8O8dKjSa4uraQFeo6jI/gNkFIUN
         eIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRVo5HKDem8WxmcB1xWWA3LpL1WS5jJLaPxEr9bIN0g=;
        b=AFHNfLZ0eEjfSJnygPNcLhHvIDtJjtOaanB1EYxsCo9wIGMOHDlR+xZcqr7gHMZjzs
         NLp6GdIjvs4NZHuQG4Fok3X73obPIex0qpBn96Hiqx7ljI+5CGw5X7hyYMfaPGBt/GbV
         8ejO3tLpFga3Dx4GgxaTRB/WhVYSrpp+FprRCkRbEJvx+AB/WV3U9QoLstTYsLXWEtQS
         ubxuzYEh8X4ynAJ+gBqGmiOwsFcTQnRagf5bAiNpP/Z5SXuZFN2Fpq3bHIaMyq1IJPP9
         XFBMHrhRdC11k2hbJaFds7O1RIbSh5mYXLBQSPQNQ14dN4m8LxZBcnnKg/JceO6h3K5L
         +jLA==
X-Gm-Message-State: AOAM530SIuLaOuhxSjwglYg0A36e6lqa2uvja7gq6jYGH/hyZvcH2DHW
        GqUvpo24cGPpyiSFTpDo8EaYhZewD5w=
X-Google-Smtp-Source: ABdhPJx2I5iBb/AgkxmwaVWL1JQh+QbMlvvoQtZudmmMNCZaNPUm28VeclvSIUMYYia3AJbYczBWMw==
X-Received: by 2002:a62:86ca:: with SMTP id x193mr7890073pfd.114.1598453597165;
        Wed, 26 Aug 2020 07:53:17 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/23] arm64: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:31 +1000
Message-Id: <20200826145249.745432-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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
 arch/arm64/include/asm/mmu_context.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f2d7537d6f83..765e8a0f88c9 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,8 +174,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly when you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
-void check_and_switch_context(struct mm_struct *mm);
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
 
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -242,12 +242,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
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

