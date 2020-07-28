Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2B230033
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgG1DfM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgG1DfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37CC061794;
        Mon, 27 Jul 2020 20:35:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l6so9185818plt.7;
        Mon, 27 Jul 2020 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ0N2+dVPSv9zBmIax9FhAdje7sgqYgmgfJjCmKnWDA=;
        b=k+SBQyBvHv6bYtnVcbgMDkBAdBoCa4QoKpfHqJZIUZHwOuBbYHrJ5U429c8n+pnJ63
         RNWj4/66GTWXp6cIn6XLevHJlBAdacCmMoHN0cjiNbFrDinmRfAV7IrasclMmxoMVADv
         vZNMdDUhbTKnym+mkaCi3X3ajYZ+Z6XsoYwYYhScZKQP8EJc/vzmG1JPZpkJI/LudB5a
         ZCiqCthWmmcTkhOkgX4u8eqlXZFATiL+RbR8o8SkovD7Oc3Lw2He6+A5iDrRFfqyoamA
         OvG+LSEzWGvRce0dbaH0Q8pWidkHj4Bpe6KVsTE1Xgie4OYjgLC4AgCA7s8NQTuvoNPM
         Um8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ0N2+dVPSv9zBmIax9FhAdje7sgqYgmgfJjCmKnWDA=;
        b=V5Mf2UWEzUfUkL6kUGGe7/2qzZdcXHMmcpI7Zy/OOE8APgkHRILlyYYSeAgpFmr1aU
         F+KDzgPVLhngb8slOOScf7eAPcrSRbeBh6Ofx6moTjqrWPLCPFlYk5wbhSbuhDExkyFi
         POqEPZ8egGK1bJVVnQ+UcXM6k7A6nsMGdmplFihc2llUD3KA3h01xo3qn4OOFy4O8OON
         hFp2pecYkmhNOcC6QOc30PbdzIFC2z077+joO7hEWmuUrZq0pFs2DrtVuSihRK3BDnpA
         m3KSVoX6+/9gDqXSwAsVPQwCqBB217YUb7kh2i+MiKSfCOZyOWJ6yXyGlrUcaAK0IBXN
         S6oA==
X-Gm-Message-State: AOAM531bvchP6OYMjR2K134TVc6Np2Mg/oH8p7JdBuLkXIZlkz6gevgc
        RRaXOAubBp83CVttyqXMNlMIPZd9
X-Google-Smtp-Source: ABdhPJzv8QVNMwZpdBvbr0dCqJM80cgxLsujPUqdgNMJ/PsaZ7BgVojxi5BnmzceR6G1fj9/gDjU7g==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr19970202plk.342.1595907311445;
        Mon, 27 Jul 2020 20:35:11 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 14/24] openrisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:55 +1000
Message-Id: <20200728033405.78469-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/openrisc/include/asm/mmu_context.h | 8 +++-----
 arch/openrisc/mm/tlb.c                  | 2 ++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
index ced577542e29..a6702384c77d 100644
--- a/arch/openrisc/include/asm/mmu_context.h
+++ b/arch/openrisc/include/asm/mmu_context.h
@@ -17,13 +17,13 @@
 
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		      struct task_struct *tsk);
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
 
 /* current active pgd - this is similar to other processors pgd
@@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 4b680aed8f5f..821aab4cf3be 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * instance.
  */
 
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	mm->context = NO_CONTEXT;
@@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
  * drops it.
  */
 
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
-- 
2.23.0

