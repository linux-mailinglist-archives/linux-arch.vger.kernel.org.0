Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B916259117
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgIAOpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgIAOQQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47070C061262;
        Tue,  1 Sep 2020 07:16:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so700633pjq.1;
        Tue, 01 Sep 2020 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=jY0Xaw9JClMjKguKr4toi3p2h52MIKL8klJRnYZgFU374fx+7NSFwezgNkVvksRVOy
         DYkQbHh7OHKuhcayw9z3bY5GcYg3oGuCrZLLRFoB/4MZq3ZzD4tuKb048U8PY8HJPD3G
         WkGilznMqAHXKZWW5arP54iwQAqH+klI5v08g+l3XG4qDb39FE7bdubGz787QJKoEjSu
         Q0hRLmVw+tp2JsWReiv9abKKc6uOy/oAhdh1NYAXW+W8LPsIa5SNCDXVCxlP54ntb8qu
         cXcSVccpvMjq65/ErNO7QIUO9gnI+msCcv1artDIopurRB/jlS5gQB4fO6Dxm7udd3PF
         yOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=HvxaILdum9UAHkIoUmUttw8DADoRGjl9COEUvKPOVuU4HQqJpsDdlm8OBqr2dERssM
         Pk6iuIzntG3QxlAp4pUn19I+56d0qLaK9wp4yoXCaLUcXT69PubpYGu8cwhwLx62JcOs
         Rz52E4uzSgY9kXaqeSlglGWCPelKvsGhjX8C+qrNjKcX1dONFtjP+ELKBQgNzhQd9RW5
         qrMcfvqYfOD5RzSe5YtQvpfqdNDbKXGfdZ2aLPgou5thFODyH149H1m+P7g0SgXOu2xR
         JEvf3G6HMbKotDNXtqIeAL5MxKTJ++3e1UEzm77B95XHvV0lZFjPW7pSCUEsKRXjPplo
         5DvA==
X-Gm-Message-State: AOAM530Jh+urRF++CYxEpVxcxgi/nfD3pMU+6BNc2rtiMCfLiV6M4Wo6
        cidHh37ztSwEvhPlIoRg2o4a30MNiNU=
X-Google-Smtp-Source: ABdhPJzDhqPmNMs02kXqTuJ5TNQPQLwR0ghPHSND126V9lWl/ABU+Fbr19n8k+R38sdwk7u1/fCSsQ==
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr1839791pjb.35.1598969775636;
        Tue, 01 Sep 2020 07:16:15 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-hexagon@vger.kernel.org, Brian Cain <bcain@codeaurora.org>
Subject: [PATCH v3 07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:23 +1000
Message-Id: <20200901141539.1757549-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <bcain@codeaurora.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/hexagon/include/asm/mmu_context.h | 33 ++++----------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/hexagon/include/asm/mmu_context.h b/arch/hexagon/include/asm/mmu_context.h
index cdc4adc0300a..81947764c47d 100644
--- a/arch/hexagon/include/asm/mmu_context.h
+++ b/arch/hexagon/include/asm/mmu_context.h
@@ -15,39 +15,13 @@
 #include <asm/pgalloc.h>
 #include <asm/mem-layout.h>
 
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 /*
  * VM port hides all TLB management, so "lazy TLB" isn't very
  * meaningful.  Even for ports to architectures with visble TLBs,
  * this is almost invariably a null function.
+ *
+ * mm->context is set up by pgd_alloc, so no init_new_context required.
  */
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *tsk)
-{
-}
-
-/*
- * Architecture-specific actions, if any, for memory map deactivation.
- */
-static inline void deactivate_mm(struct task_struct *tsk,
-	struct mm_struct *mm)
-{
-}
-
-/**
- * init_new_context - initialize context related info for new mm_struct instance
- * @tsk: pointer to a task struct
- * @mm: pointer to a new mm struct
- */
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	/* mm->context is set up by pgd_alloc */
-	return 0;
-}
 
 /*
  *  Switch active mm context
@@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 /*
  *  Activate new memory map for task
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
@@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */
 #include <asm-generic/mm_hooks.h>
 
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

