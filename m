Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C4253288
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHZO5P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgHZOxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3FC061756;
        Wed, 26 Aug 2020 07:53:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so1193124pjq.1;
        Wed, 26 Aug 2020 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ti5aFrmBPkKLjysSSabr7+oEKMDvyOOxBJHtaQyN6bs=;
        b=YOUyopMJi6fxTdRmP6+MMmHjqBrzqBdGsJhib6WpIKk/k44xKZCS738qRolqHsFXmK
         NrALc+p220xDhHQPzHhlT6Ov/G08qamDHOPs77c0f5Je9WZ798lnbsmyollAIKBpDDsV
         wWwncVzhMt2FWa36IUwtoK/BaRtjeH5LUueOpqkjqFqjYSsjexDCCQdC6qDm92nX0QLg
         6PyU9tmVP48l9eq3tmumUSuCjKbCKJauA7s0RqUG/lym/jmR+FG9/iUHM7U4kJUebuor
         GGJ5VtumN6UR7E0Td2DRSOO5v5K47hFfVC4pWBzq7eERdpNb7tQlVinH27SPg4d9DTj3
         Ov1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ti5aFrmBPkKLjysSSabr7+oEKMDvyOOxBJHtaQyN6bs=;
        b=aGEuFAF8RS8QqXF9u5Y/ZF9wVZy2W4LmUpdAsbjLaxawIbwwPzbgiyQmtB3wZlvSdO
         XGAEIuMdbGSmkjDxVDFzNPAHNIwWkUqc9iph4KIzrZ+wRZ2k8gpJUHrpRLYyyzr6xtrW
         e9k/LUH8/rR6P9AuqIi9fDSDpILqGNecLWMv4q7Q6yHBCQcxnyNaLzR+uuIK7trH6ug1
         frmf7npZAKWjvSCQYOIJ+DCC3XivgegoLqQ0Gru4LtQ4q+7A5to+EAMU+dUR1fUtCoZO
         5VOKnz4jWhc0YuCKaaoqZ2MXG4OHkhUv5fMAqCgJNLmdIYz3OJwvJ7/qWujx1QQmY4op
         THbQ==
X-Gm-Message-State: AOAM533ELPU/fJ4CMySOaEljZAOloBLZ6p1sfeoElQG8ws2lI/e5da/T
        00OVOHs4Ku6pa40lQtsyAt6D7/3F88k=
X-Google-Smtp-Source: ABdhPJy2SGDVDGvyx3hWFj5EHkiUSzPX9nxHi3Ncwo7mVkZoph8qmVI6xz3/z152bMoeWCsi54CPxg==
X-Received: by 2002:a17:90b:fd0:: with SMTP id gd16mr6417371pjb.122.1598453589734;
        Wed, 26 Aug 2020 07:53:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:08 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v2 03/23] arc: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:29 +1000
Message-Id: <20200826145249.745432-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arc/include/asm/mmu_context.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 3a5e6a5b9ed6..df164066e172 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -102,6 +102,7 @@ static inline void get_new_mmu_context(struct mm_struct *mm)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -113,6 +114,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags;
@@ -153,13 +155,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently here
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new ASID,
- * only if it was unallocated
+ * activate_mm defaults (in asm-generic) to switch_mm and is called at the
+ * time of execve() to get a new ASID Note the subtlety here:
+ * get_new_mmu_context() behaves differently here vs. in switch_mm(). Here
+ * it always returns a new ASID, because mm has an unallocated "initial"
+ * value, while in latter, it moves to a new ASID, only if it was
+ * unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
 
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keeping
  * for retiring-mm. However destroy_context( ) still needs to do that because
@@ -168,8 +170,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
 
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
 
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
-- 
2.23.0

