Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05D2590C5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIAOif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgIAOR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05129C06123A;
        Tue,  1 Sep 2020 07:17:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls14so675897pjb.3;
        Tue, 01 Sep 2020 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TuljzwT/taYwLAxWlXZZmSA1JGxC1yPToMpQKgO55w=;
        b=vMb3r5vpL+QhkRrXIl+ox645IRbVqx89mbaXMOnBZAhR9E+FXTLl6roBhM+GQbCeOx
         1U8UUNEuDTum31qKlbKJeOcqoux35a4Jd4S0H06CPUlUiMVVwMcW3b7yMgb2KlDOJZsl
         Ash4DBb57qEptLWAJWXS44zYA7UeKg+1awpvzhYWEtWPcH2EN4Nl0oIYIVYRXLHK+Rkb
         9Xy2yHHiGXDNl8tx9ZDunXL3KrdLKvQkAhjE0y8R0V6eOKLngbm880pThlRZU4DcPi6u
         sa7ZRpJ8mKy0hxGDnnoAe3NH9X9sO3PYCzJ7V8Ngevo1W7i+/cm1hBwCWCx7Xro1SlEO
         6/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TuljzwT/taYwLAxWlXZZmSA1JGxC1yPToMpQKgO55w=;
        b=AMup9Op7HcXHcYonjG7sVSNxTlp3ysr9EwJKRyFIrkOujqAaVI5k+e2zuxeiKPdQLd
         FkSUsFK69cGfp3E9y/7ujGB8M/hJCpDHbQotQIWH8AucsWmqCs3+ymflPknTaDNULtgM
         IY6MDGNIjr273W9Bht09+a4SXv38lKIY6nxXueIshh/gjm0oRQhkRD9wF6LLTQcrn5Al
         XSxG6A6ghoo5QXG4t2uS6rfmX7RCo/wMQN7UXO9RugZcVKAy9E0lFDS+ZoGCi/7nlwQ5
         lT2HjmcoajE59V+L+3LRdpx4qq2/4nnc03/XBqnbBs1R5wxFcF1g44RX84Cs8AFJwPFi
         R+vQ==
X-Gm-Message-State: AOAM5306g5icLvyWMmxCjVAEbCI/I3aD46i6qoh8yJ4qTJxczyBQl3Xk
        lB1Robdw5/FjKEOcHExoUQQ4N05/LSg=
X-Google-Smtp-Source: ABdhPJxz4M3UuJfyQ/Z0oMUaKnqoDspo9LWuPGYuUcmj9p+2WrlmX/NWbSHEPJ95PYvgYV4snR8jiQ==
X-Received: by 2002:a17:902:7e86:: with SMTP id z6mr1579503pla.316.1598969840395;
        Tue, 01 Sep 2020 07:17:20 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:17:20 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v3 23/23] xtensa: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:39 +1000
Message-Id: <20200901141539.1757549-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

