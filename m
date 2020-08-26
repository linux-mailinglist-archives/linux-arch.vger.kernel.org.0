Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDA25324F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgHZOyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgHZOy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A304C061757;
        Wed, 26 Aug 2020 07:54:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so1008268plb.12;
        Wed, 26 Aug 2020 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4c//fvG4fjXYLBPyQJ141PEsJK2A9XDWhulJsN1c2g=;
        b=npDO1sJ/9Lj/B2a9PZJG70emc1czb76ScCXnQ2oCD1xY+i1qLbbqM6g9M7zppI5izy
         +H+esxZ+abKKnJ5VdUfsAi6AFEbYwDt7k3pcmYxC4WK8g76ILaH3yedmYAh5ddC/tzBI
         wJOfm8z4D9+QM/OwCTdUl16NQhm40qGVfU73NJ1ZzU96KMhh5X0HVZYcD7kp5ktLLWGe
         HJnEUyoyS4FjoLwWmSjBl+63WW4Ck6wfJ+zkn/SkZVzUXtq9Djbcm6p/76OxocPdqgt+
         5XjZgVR8vtdU6hRrFcu6mF9I5Y4mMocjBbQoV9CYyb92jNN3BfJSYyOBqQvhF1iydVy2
         hRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4c//fvG4fjXYLBPyQJ141PEsJK2A9XDWhulJsN1c2g=;
        b=EqNHThxrkIpkL+dFvz76PQaly5Bnc0hxJUV9RSPAuNTfvy/xWNZGZqzvvDJVlP0vhD
         L1xRThGFjka4yODrvleo+rJcqr17ceDmhdIqLWGES8Tvlg0+S00VXU0V5V6iP0fZBt+9
         RUtA27lxhSPTxvJ+5+0QX420TCwohOumwZJ3YXxj3qpfBpS3gF6suE9dOmjzvoxhmzd+
         u80SpmcOznUbMbtG5LiCcZWVNwfdfkWzG5G3tq2jFxarVYpXn+rGu2Wzp52bNadwPhBb
         Ix1KC5piM2EjrirtrjTgH932loGyHBKFuUniM6/0VuCVS2BsMsRSNbXeb6xa0fqMkWLg
         OtSA==
X-Gm-Message-State: AOAM533rC8FPzNSjdxUDMHotwdizg5XYqiAD/uwrY5l3BFV2/KYPx9xw
        N1IPsAk7m35WtV8jXKsn5ciJ1l00rGs=
X-Google-Smtp-Source: ABdhPJxvlK/X1ouPjuda7L40DWOtJsOi9bxydEWaZH+cGgSmUaZIqEtdMn3J1zKle1a/UidEnCdOFg==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr12358648pll.258.1598453666968;
        Wed, 26 Aug 2020 07:54:26 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 23/23] xtensa: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:49 +1000
Message-Id: <20200826145249.745432-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

