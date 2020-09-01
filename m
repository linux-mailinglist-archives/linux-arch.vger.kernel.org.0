Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD66A259129
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIAOrN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgIAOQF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7801C06125C;
        Tue,  1 Sep 2020 07:16:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a8so606131plm.2;
        Tue, 01 Sep 2020 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqrgjgkwQOLPKBKvSr9gJrTOHEBDRQ8iqEq+YmYLPME=;
        b=Rb4ZX3asfwOJg4osK9f8BVD5bqX4bXtB9PhlYShZ/rsHMNJrSi7aW2zu7V3aeOSrJm
         L2LbvTedaoP87o2rocKNCt0/zGqCSl8eyW69u7bu2hDSiC9BpP5v7sW099OXDjyBdWWo
         3Dg8HtuVdHhv4tO9TNdQ9p7FPLbxF6eKt5KtLUEe04377yijdLe6uEt3jFztB5iQJPK4
         PJPMg87eK/AzEN4h8pHk8gZr/ac06hwgAeEbRZnmntpetDHiMSbEIcMeq5Hkn+vjZ4Lw
         qOoGZEdbd+2uUXFX4RlrE4zjEFdoITSaRAxqiXKYn3VD6kqvA2fIF/XqYX5/ac3wnZzd
         7oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqrgjgkwQOLPKBKvSr9gJrTOHEBDRQ8iqEq+YmYLPME=;
        b=gU4esBd6ad5V8fT4AuiKkVXfQ9zI2uXfCeaa8urY+N4xtQGroKdE/StBu6weviKiHX
         dHnUvByPRUXhxWRWROv+dJU0fFGcHNr6ZB7WZDvNl1L1jltLtuvEZ84YiVwL45+NN6aP
         2KVTUcHPLC0cGdojXkC4a32aiaZ+C+QYMTuP0hYtj4ydv1flkKpYGFncwk8tYFGeyMdP
         HGbeFECaA8yArFUKECtlj2pl95SNp5jRzOQn0lkX3CEcRVu0+m49Wcnr+AwikJhuI2If
         lx3Triay7XUI8oJukPYei3lcmh7csRBRteL4cnAFoevrRrtF+nvvNuSJctsT0PmeZ1Ux
         K7mg==
X-Gm-Message-State: AOAM530vtV3Fj86zMPmZymrQAVlQQ/IspcKmLr5mTVDJHBDOKlOdz6Fd
        1Gmg0JJ0iQ0XGYRqCuadbRS67MC4D+A=
X-Google-Smtp-Source: ABdhPJzlSzEv9CsAxwBinDg5rdhmsaopGLA6RpgIsGSWM/G1oTk+NhLtBCJS2/eCVKKOb3FB1mzI9A==
X-Received: by 2002:a17:90a:4e42:: with SMTP id t2mr1758800pjl.121.1598969763778;
        Tue, 01 Sep 2020 07:16:03 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 04/23] arm: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:20 +1000
Message-Id: <20200901141539.1757549-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

