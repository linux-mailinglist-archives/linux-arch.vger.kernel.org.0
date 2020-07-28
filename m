Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975A023001B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG1Deh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1Def (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E58C0619D2;
        Mon, 27 Jul 2020 20:34:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so9188170pls.5;
        Mon, 27 Jul 2020 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nrd8d6fyv75dXwELwu7SjNDDoELmbfaISz3tG67A/Og=;
        b=QHMAvZm/I0mF7utvjLbQSyiSosPMZuOxRY46k50CA7iZnu7xOPahXjDTi/nli2iOhv
         Oujn0wifZJR0DIe2O8z1n0MmwDSg9mE3kxEZ/3Bms22rTyKzBjZpGjj4ZRt1TsSZAXKH
         cxEtM8iWj21TtUr1td7PZ1i6Xfb3xSLRfzOaallNzYOVSTkzj2Y7yKuPBodwXP0ooyRc
         plFBjkGe3b2VhcXajSxhIDjHOKQS9D34CfcZEhtK2JnsDK6E28/nBVwOwsb90HNxJSHp
         jCvNTGFACF+ZyyVeYdv5DKC96pLKi++TWTA+CqIsqWVfyWEpL1nESj9KwJxZuZyWGUdV
         d2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nrd8d6fyv75dXwELwu7SjNDDoELmbfaISz3tG67A/Og=;
        b=k6T4NbK2jIhej7WO44OO0NnL6BMzeqeKaavexa6XEODWlLSy4bpTkKoWaF7JvRKfI4
         2qmxdVfhLNlXSBgROgtblJuvpCVfH8kTuOfpRZsGF/4NVx7sNPXj21BZiW3UsQ+f64HY
         NQ5YN4TLIxDCUgttECpxjKfpKKZD21H2IxFN3QrL5qQyNghGtX4cnWO0fDZxMA6ldFIQ
         EmBYeVXTXthT03F0IvmzMM5F4skCrb3UzomjGccPvuM1cGIvgIdPzMqddsRRvz3oczt8
         guwuefphLkuy7EP3tI1n55kP38N/93QVL8kMitllzAL8y7FKZwdLGN8/VGc0D4WvqGHm
         eVlQ==
X-Gm-Message-State: AOAM531l4bH+bTImzvLlWnQCs8R2RhK7eSHJ8M47QCZ2AUcsfQZJAiWF
        XgPPE2ty/Hgr18q/jDr5W4Z5lZa8
X-Google-Smtp-Source: ABdhPJz+ArXXeCto+CwCq9TBJZxoqe/CgzjVj2vgHlZDtuVaDXZVPE2JctuE3f1k9kh4PunK2ucVxw==
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr2327280pjb.147.1595907274466;
        Mon, 27 Jul 2020 20:34:34 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:45 +1000
Message-Id: <20200728033405.78469-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/include/asm/mmu_context.h | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index f99ed524fe41..84e58956fcab 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
+
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void)
 
 #endif	/* CONFIG_MMU */
 
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
 #endif	/* CONFIG_CPU_HAS_ASID */
 
-#define destroy_context(mm)		do { } while(0)
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -149,6 +129,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #endif
-- 
2.23.0

