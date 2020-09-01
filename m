Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168222590FF
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgIAOnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgIAOQi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565FC06125F;
        Tue,  1 Sep 2020 07:16:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so149361plp.1;
        Tue, 01 Sep 2020 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rF0Gg/FItWzC1FRYFQdU1CM/THHapJ9NmHYGWF5PYaM=;
        b=WzUBSHiEEVYXLd5qlbZdiTvUByjDNOOf/Vsr/o61BzXL5UVg5zTZaZdPeuvbkS/Onv
         PCxIHdjkMKd9h4n6CHNnM+ryyaQk7hrcFKcdjwpda651L51ULnlRBFAZGUDAS0lEQ9JC
         MqiO+WgIQlS+BXH2RhGdF7iXG7+npVOWpxDv0K7xslMLxEoW1kjP6Zk4rDTzL79/ButI
         4ao2BB6glSpr/ad775rxf48hwFYzkoC93QbS0sYI1061h63ba1DWuXWX2LQAp1/9Syy1
         B8ESXA+bCOAbmc9fBwpbDG+OK+i0TVEhGJbT6408kUMiORSNRhdo5x8CqTo+TgkHoQGh
         7ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rF0Gg/FItWzC1FRYFQdU1CM/THHapJ9NmHYGWF5PYaM=;
        b=PYZQ6YtschFf8nnFiRpiwm9kKFwRxlF/SWR73wFvu0QCgiV37JLEQX6pp24XRxGkfc
         1TtRX+L/2B1EnFw1mW0bFHnBZO9bTQpiax5LiDCAFdleBaLeqIxfyC/T9CKVTZundJmV
         ZMmZlOmZLSxkZqlNeSBacj6oN5XKtDvdvRZngDNa0CcSA703o5MHi34Z0gJDbA2SfbUA
         +KqY/upwDkjh4FOmZhHAV8U/Vpjs5SDq7fygNl+jr/dpmC3PZ7PzsH/sHSVPF7+/cb0V
         VANsYSyfqW+jmBLDN6VGHcDO0JZgBhkDytpXBkDeXTfuTYPn5QvHR/bMIo8QTkxmJBnH
         DS/Q==
X-Gm-Message-State: AOAM532PKPTSEq2WVfXmIjkcErptyZMS0u3TxPWylBmIWMFPwEhQupta
        D6MXREP4iDfGandr+eCg6j62WeAQurs=
X-Google-Smtp-Source: ABdhPJxAWHVJz4qjW72EohwUKHF1cKxUaKdI5k8vecTZBIbH6qy//hJ4IaY8hwl1kx3ydSR74SPQwA==
X-Received: by 2002:a17:90a:4541:: with SMTP id r1mr1818789pjm.88.1598969797778;
        Tue, 01 Sep 2020 07:16:37 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:37 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v3 13/23] nios2: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:29 +1000
Message-Id: <20200901141539.1757549-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Please ack or nack if you object to this being mered via
Arnd's tree.

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

