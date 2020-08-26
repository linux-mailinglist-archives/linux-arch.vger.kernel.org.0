Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8B253289
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHZO5P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgHZOxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDAC061574;
        Wed, 26 Aug 2020 07:53:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so976939pjb.2;
        Wed, 26 Aug 2020 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nrd8d6fyv75dXwELwu7SjNDDoELmbfaISz3tG67A/Og=;
        b=jmGYaI3y7+bK+s5Vq9pxlP9AKQX1/f2kkCSAPyU9Hi/mpiMeJEdVOU/SlTvNdwQGsE
         W2SIrItUXPPqUOIXKf/izMh44nFlQ2RurR55qfloUW+TfZiQl2VuBZNvaB49yw6EoD4a
         WxeSZrkQmX/QFaDD02lYY1c3hZD/Mb97GrTdTrkW4nhVIts6RXNT93bIwp8VxBnDweHM
         g845Oid0hY/B7UgntbvniBX8J6laGUpy2/U4xJWfWAToa3tq1C9lqyWqPQUihHF3u6pk
         Et/YbsLLCXqIJwlosSd6raD7od40ipLLbl2bAjKmM86DA4Fd+m/rvkN3KdTJEvDaHCh5
         2VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nrd8d6fyv75dXwELwu7SjNDDoELmbfaISz3tG67A/Og=;
        b=MJlkqfn+9VSAzglTDWKQSfLWMzYPutX6HzpXakf8lXEq49WX1GxcoVbHWuFBHhUWPg
         27u5WsOjg8qY/d3N5cvFnyeI8IaH/d40MCqBJ/iTiQN4qgZ0rPoZDPmqpFB+7kOnIGE2
         kZj9LvEwsNj3pw5kPNFOjZO284ThNHg0XcalEubArKnBjnTpanxjg/4Etmn+Ib5Mgfyd
         RB7Gbnpbe7sJ5rnt/ctXlUhuU8iGE5xiY5ec+p0rlqP7z8rGjo/nPsXLAGZRoNu8hbNH
         5saFEUPSPSuBnH6mkL3CjLneXzIVTiYdc3ZfV47fa65nyRTCICsCy764bSUJBlUQcDdO
         tnTw==
X-Gm-Message-State: AOAM533Tt+gbrNvlijLfLkVKTSVw5lEtCvK28pogP5Y4nqliXggTm8+v
        j2v6jVrBWy1yXLzjdb4C7mdLfAvBHBk=
X-Google-Smtp-Source: ABdhPJyDERUfmwLIZqqYQ35h4vwNp6nxCDqre3x7r/Ny6pXllt93M9hcqByBq70CqedHa2ThMMOxZA==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr6341778pjb.174.1598453593254;
        Wed, 26 Aug 2020 07:53:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:12 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/23] arm: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:30 +1000
Message-Id: <20200826145249.745432-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

