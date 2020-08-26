Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2F253275
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHZOxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgHZOxj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFACC061574;
        Wed, 26 Aug 2020 07:53:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so1105414pfp.7;
        Wed, 26 Aug 2020 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiWkNEwCCC0m6okc9WhV7jiLYdcUc3FOzWjygUNhbfY=;
        b=rAKnJSzoYGEt2qz9xpeOoAPU5HEBAIcGp2QMXDNOmDMGvtSi8nEbdgdGX4IFZOiDiJ
         YSulPWs0g0rFoIPZzuactbR2BzWo5KyJRQQUHVUOb6e/mDu+rYLgN/LRkGmT8cCqU89s
         1gnriktuGcmVtyq5bcKKFpiJ1VRGhSGNgnd8mZJxfHm05adz9W8WQTN7fjs4ghDMr4Hi
         lgafmjkMsR+S4+gktKITf8DascRPy8EvmLArXwgjenS1P8c+O3dBReOxcnW7/4hyOfEw
         KWapPWgWXqrwefoxSsG9l0cwhzt8lPpewxhDXihJURChqO74oQEOhPh571wclGPTwXKJ
         75RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TiWkNEwCCC0m6okc9WhV7jiLYdcUc3FOzWjygUNhbfY=;
        b=Hv/xFeRDdOgvYTyXuzToNzoPBfYMJ6MKRhNzifPyjOZ6B4iDk9pLQlDYy9+VMTZrnY
         jIusMUK6rOKEF/OM1UXhkiZz966KvlIGHXkIJWnTtUPGzaN9ecFMYrsS4jMKcPJfNxX+
         6v/PfHvC87aVc1yX6jUssALs109PoV3Op6/PaTMne4XXWNOH/HievxcOBy1obbWSrasa
         oZrQOCHPrRvt10te382/Eu8G1Zfcw8sc4zrmCinooTguf3AVYka5wegz5jN9ebrQbTO6
         qAuTYvO8dWK0NxnIpxhdNVvSuohHll40CkIBG5O5dKt2y/tFf0a2k7RsP4nVDycoefzM
         RE5Q==
X-Gm-Message-State: AOAM5339Mevr62mKHzrWppIRSoQaMPXa+OPp7suVpDIn8YWdZIv9s4gM
        ODYEyLxQsECG9ZA8GgDp4G2cTIdRNgM=
X-Google-Smtp-Source: ABdhPJzrJJGcj7n7yPW1Wiv/Z390c4CVmxzbpAV27ojgXu7b+a5x8oR0g/bY1t7uSrfq0YKzDrAWsg==
X-Received: by 2002:a63:747:: with SMTP id 68mr3027260pgh.90.1598453618734;
        Wed, 26 Aug 2020 07:53:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 11/23] mips: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:37 +1000
Message-Id: <20200826145249.745432-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

