Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA9253240
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgHZOxu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgHZOxr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E328C061574;
        Wed, 26 Aug 2020 07:53:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so977623pjb.2;
        Wed, 26 Aug 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Crho1GeckyYBxh3qCyLD5ViQ5IZWY4Rxj/DBwYad/GM=;
        b=ZlgkMnJGdVfC98/jQl+I8jkQKmP360nq86MHnsiomaeZP5OuNBJccP6fMuIQkBa5FE
         X2I2ILOSi97V2mT87OutGPOoX5hS+gfyEWO4qMgDJSSwdtq9iNdVGMIlRL29g6Rz0044
         OFqI/wZsfUTM0XOfft71HPNEshXfkd184b6VY7CNH4c75J/gB61iyNuKvpiYyYn1uAI9
         KqRn3z+88CJ6NIfrnn3FnL0Cyx40NkS0MLsnf4mC4CM8Wzatkc/jDXeVIqwyMFNPrEY0
         Uk4xeelsIqLGWSTlEWIjJZVXFsmr0hyGiGvX7KSes7UiegTLJji+CshexSQc/wkJ7kWB
         SXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Crho1GeckyYBxh3qCyLD5ViQ5IZWY4Rxj/DBwYad/GM=;
        b=GYnZjxBKbAFp2nUhx1bloMRGLm7wLzShEYfsVhWmp908a95jpPeP5sEoHqvPWWG5ve
         LW3BWDmFFuLqE9nHhPifj90Ny4Y8IJxmA19GIef4JdKx1KH7mPNZNTtiQDcJaJGz42Fw
         Anx0uWvGeF1JOclgVOlm81YnOasdPJCbtnTfC9JwcKy8N0gof2RFNDJF+wnn66tTRARo
         t47rFN860EGshZ47LRImc/BgQqTz69vrCH+lZVnSitTGJl00J8HP4vLv7j8GDxaUfrGK
         f1D0LQL2uiXDIlyXuzQ8ey55N4dWZNvbWocgGj7PVbxFJvek7skL33OOMzPNcK6s7002
         /SMQ==
X-Gm-Message-State: AOAM533XyzI8deYdUsnz/R178Yu3RlDJOca8+KB0+7pl5oaBWSNSzoOg
        qRnJdayhqrBY9+XO3tjGfshqIQgyRHw=
X-Google-Smtp-Source: ABdhPJzQoD1QarIs2qs7wxJ/lG+RA59AJBajALNQu9EE/q9NsmY0IQzXt6oyZkDE7VUDB8fSaMqk4Q==
X-Received: by 2002:a17:90a:f2d3:: with SMTP id gt19mr6264154pjb.229.1598453625741;
        Wed, 26 Aug 2020 07:53:45 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 13/23] nios2: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:39 +1000
Message-Id: <20200826145249.745432-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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
 1 file changed, 4 insertions(+), 17 deletions(-)

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
-- 
2.23.0

