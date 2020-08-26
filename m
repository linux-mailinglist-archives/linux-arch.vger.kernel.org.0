Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34D253285
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHZO46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHZOxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF49C061757;
        Wed, 26 Aug 2020 07:53:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so1146932pgb.4;
        Wed, 26 Aug 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=RRiXPLTMXyNxkd/Q7cSppCEX4ypohtTUouPii1Ko6lFloN8J5gkEMLinRU6wt4LQS6
         DESO9NUZRxUwuB//GtGcpHfxW+jUTGTO+b9WiHCTCM8XE7h69ydPbdwyRu0lgf/+ThZM
         MhP2CJ1kDWYtrGOrgaTF7J899dRXB31I05zBRy6Xd2VkwBUGM2m1zNGgWueXOBWSDlOv
         /Dn9Vhk1Wddl8VNkvumE7XqIoCaS9zLYW5TvXZLkV7PiqQ4zedbHYaIJdfKdSfz/Dj6n
         903g+aLWs0KDriJmB34o2kFI8OwDEwuliPN/BaEMCUVrlfjBI0hj+YIWs+XeT4GhJ3uk
         sIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCO6eQrXV/q62wlJ5dCHYkGXNXvcNXkjUmp1GwIXZy0=;
        b=scPk87WFwHhU/f+qBmVvAvWGpRpzNZO1sle1CdYoXxzTAeH15vTNHlRhCo/A6bQtVY
         DhQyBaBeLVZObLNURXa3XAuTl1F3tKFftNDVPsD6Qj5rOw80VoFbkXYb4XkGrIyDXn5l
         +UbDSy8xlndE5hyI0wuaOjNFqNZntPX+l+ewWDOPR7ndIQ6SNS03uJCuwSgaKHIqNJ7e
         A7As1lh+R2/yL65IMUvdBUNUNDlWskWoouhkkLoNJHwFoPgcoS0e8s16CbOrbSrkfvGF
         FSWE5MR4x7dZYraDDLFm9Ore37NB/3cDr0gazHDA6VbmfJ4Zy6IoLLI+dlXEZS3qhyyw
         Cn6g==
X-Gm-Message-State: AOAM532khPedh4He+pHnCIP0QtxJ5jsB59BskWLLIfYR0sSq9MVXrRhK
        3PlVIwWM9BC3UIIRRllhbV5K8MPLYKQ=
X-Google-Smtp-Source: ABdhPJwSsJSzHc5MrbWpVkgrWNfzinki2wen6Dkyz8lDpl+VZJPEoGoFwALbjOyC7T503VBERSVgoQ==
X-Received: by 2002:a63:36c6:: with SMTP id d189mr10171323pga.392.1598453604300;
        Wed, 26 Aug 2020 07:53:24 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:23 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-hexagon@vger.kernel.org, Brian Cain <bcain@codeaurora.org>
Subject: [PATCH v2 07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:33 +1000
Message-Id: <20200826145249.745432-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

