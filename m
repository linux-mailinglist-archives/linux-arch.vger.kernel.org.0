Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30E259020
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIAORf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgIAOQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4CC06125C;
        Tue,  1 Sep 2020 07:16:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so847218pfg.13;
        Tue, 01 Sep 2020 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7hl6/jzH9JaCJmjBLvvza5EUcXtSUI/1TemyK+HC9o=;
        b=pNUM33L87/n3oMvM1sognLh5DCDBRm6ZHKqDFXRM9BZJCR6vzswELgtbDPSBnfrTVF
         W9OB4D7886nLFTuXJnoHU14ASpJG3zm5zKpFFxpfxeW/6JIfgoge8+p1byr6gTf3m3z7
         yCANr114qi38F/fThOZja3tYGmqXbyvtaSeFHfqRcvmNIkgmtg6PSUi6ak6DJnLjNVT3
         neYukQkFNkzifFFXKRE8VdR5S2Albh+rTn6gJVNW5SVe/oV7nFKvbhfsAjjCDPahKEOO
         QbdngNHv7o6geqrV5yyQhDX0jg0iO8wmpF/MX5OLsURm2XnAlIjPQhnEU9ohYiHpVtnt
         sLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7hl6/jzH9JaCJmjBLvvza5EUcXtSUI/1TemyK+HC9o=;
        b=PP9L82r4lBhay63I54b5vcjxEvp680dBHmSGa13c8h73RosO3+j4+Z5+meLfc5exKS
         cPgg4C7iwiE2vlVc4d08NnDI96TtusDufjZpKofsA/0jIIRo7Iwff/ww/ErRrmViRY5f
         g4RjUFcxLS77/165Xb/Qx0Atkh6W5TCUKvGxpMqZxrvRSigdVliE+0zhStXVoxo+1WbA
         l9FYmPpPCxWutsX79BiAOKVX+DjXPu7udun3j74lNYVnida9yBh47X1tI2MXbhioMBKj
         kpaWEzmsAiSsKHRQh0OJzbTUvbyYLEpuekACRJ8w4wEZHFeUu8B2XR/VpRzGys6PQxRk
         LF8w==
X-Gm-Message-State: AOAM531mVzlvnKh9QkgI5JZ+cq6UPWRfkTc3A8THW2Dyl1MZ6UZ6IK3u
        HPQuYgR/vzQJTjFJTlGf3M5IjPkHrYs=
X-Google-Smtp-Source: ABdhPJzMGurkU7OEkWAj30u5pzoBQBXN7lJH9ysmj05h8xZeAsFILA7j+WaGXQ2T4NFEf2hyfqF7ag==
X-Received: by 2002:a62:6887:: with SMTP id d129mr2000651pfc.279.1598969790530;
        Tue, 01 Sep 2020 07:16:30 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:30 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v3 11/23] mips: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:27 +1000
Message-Id: <20200901141539.1757549-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

