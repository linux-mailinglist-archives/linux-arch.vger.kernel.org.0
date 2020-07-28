Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB523004D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgG1Dfy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgG1Dfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51567C061794;
        Mon, 27 Jul 2020 20:35:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so11103858pge.12;
        Mon, 27 Jul 2020 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4c//fvG4fjXYLBPyQJ141PEsJK2A9XDWhulJsN1c2g=;
        b=txe/TGzL2m1an+nZ6gO/mOSaoDI67xtlU7/eV990yjKoxcG0UfjMij72knv2aBpCp2
         Cmtnr2BvxdLRtTcDUSFaEAb7Z6tcoihpK17xxJYDDSVRrl8Ng35DB0GUKAPDDH/N/Il4
         OGJQEP3s0QLkEwIycouiFmf0Iggxw7P9Xect2VxLD+duf8ES3viEDp29UWiSlYwxHKau
         /JVQR3zrFqLOQbAuVpRdfYoIugdCdZH6AmURIiDdvn7JFxX1o92/dnHolj4XC0RqBHi/
         y73+XgdiLyAmNUH/W4N5EpDTFftABn3UeUI0v4wf6HTZXGQNAk8Fd5MLKDU3siIoSFGe
         Gb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4c//fvG4fjXYLBPyQJ141PEsJK2A9XDWhulJsN1c2g=;
        b=N/Felcxs7K9RnR47cbAs7M66SGepUaF9Jn1ayXmUmZuakyFLC1ZDxSy7Ho0vbxnrjo
         pqYHFh06vuA3zNkYCU/vB5pZZz1X7enuVlNi2SXpzB/NyGB0tYv8JnD+b2C+BD83Js5C
         fEt1Z6ntqns3Q7paPEdPgbpk1ri6rtAe7qYX2+E9meA6ZHsIE33qV7O6TiciZtDue7WP
         DDZqqg5TF9UxhO4ttjVJlRQN9ILyO8LkDCjh6Y1xrXZV1/v9S8WZRM+yi3iVl7sKi+Y2
         FeV0VVtvHIlzt3r9J/WKnHTlCAwX7K9W4oeCvWpIkmvkCPbX+trjaG13nUayoarPKAWV
         Gn1Q==
X-Gm-Message-State: AOAM530xamW3JJ+rpMo2XLnS27dkP156DLCEw5mOxSB1JwMLLeeEb+LQ
        8WyZby4kTkMbeCqkdO72s4u2nPId
X-Google-Smtp-Source: ABdhPJxLSrOIo2pJZ6JxdbY8sqTL+sLacJBQP0Z57JrGGqLjqaHZnmGavtkNBCHUG79mxlKKrr0QRQ==
X-Received: by 2002:a63:1406:: with SMTP id u6mr22223509pgl.108.1595907352696;
        Mon, 27 Jul 2020 20:35:52 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:52 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 24/24] xtensa: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:05 +1000
Message-Id: <20200728033405.78469-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/xtensa/include/asm/mmu_context.h   | 11 +++--------
 arch/xtensa/include/asm/nommu_context.h | 26 +------------------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/xtensa/include/asm/mmu_context.h b/arch/xtensa/include/asm/mmu_context.h
index 74923ef3b228..e337ba9686e9 100644
--- a/arch/xtensa/include/asm/mmu_context.h
+++ b/arch/xtensa/include/asm/mmu_context.h
@@ -111,6 +111,7 @@ static inline void activate_context(struct mm_struct *mm, unsigned int cpu)
  * to -1 says the process has never run on any core.
  */
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 		struct mm_struct *mm)
 {
@@ -136,24 +137,18 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)	switch_mm((prev), (next), NULL)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 /*
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	invalidate_page_directory();
 }
 
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	/* Nothing to do. */
-
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* CONFIG_MMU */
 #endif /* _XTENSA_MMU_CONTEXT_H */
diff --git a/arch/xtensa/include/asm/nommu_context.h b/arch/xtensa/include/asm/nommu_context.h
index 37251b2ef871..7c9d1918dc41 100644
--- a/arch/xtensa/include/asm/nommu_context.h
+++ b/arch/xtensa/include/asm/nommu_context.h
@@ -7,28 +7,4 @@ static inline void init_kio(void)
 {
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
-static inline int init_new_context(struct task_struct *tsk,struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-				struct task_struct *tsk)
-{
-}
-
-static inline void deactivate_mm(struct task_struct *tsk, struct mm_struct *mm)
-{
-}
+#include <asm-generic/nommu_context.h>
-- 
2.23.0

