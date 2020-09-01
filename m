Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F32590C7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIAOik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgIAORr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08673C061231;
        Tue,  1 Sep 2020 07:17:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so694381pjr.2;
        Tue, 01 Sep 2020 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMyHyW/ibxSh5eYl/5ny2xFFH4uUfgxHccMgqoyeGgg=;
        b=m0wh+6ZWCvB6xY6mobQfA84EWeAOgcj+P2/sh51P0HP2QNZuoPLB4itoOJee1tInOQ
         GEjtY/zF2RIFEOTODiaE5O0lp9WTjMayA7dEE5eEQK4pNP0kPNTmHVr0qkB6H27MwLNO
         z+uwXWhwY4Bwnt0Y3roqq7rEOguaD1PSqR/vm24XMbtevgG/+2iY0oiKw6hkKQPT9taQ
         xXBkZClMgTlN+miUmXc5YALkeb7wSWbpxv0YaydGGIDZMj4VYVAvMvLfhZGKyxP4BQ6r
         Z+lbaCG+pJU7taGtqg9nJn7HkrrxnEpANuQO8vDFWIHah5Moa86nBAIdDRDVvK8hX/fz
         WfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMyHyW/ibxSh5eYl/5ny2xFFH4uUfgxHccMgqoyeGgg=;
        b=C7VzlcJ7K4InC424A8TXgt9MKGydVLfBvd4Dy2lyAY0gfWLc0t9oPyPQIXUHe7w4bQ
         8tBTHdaJkN+hVi0Om8M//lkNBnq3rHC0MNyvNg3pTiWqsRhMYqlQaZdlHDDi+3qVn5hB
         4HaBbW1Gs2kNGdaXGRzK+IPamqAtpkmb8AiOGoxI/XHj5n42cCHu2lfxa/TyoHDuDIgM
         n3uhF+7Y5mhSJga+G+KkduKmPoSHPFqQIL4pnxB6jC0dML5L48/Fwlzt+lXbbMvQTyn1
         oxRovwQTUGBhHPc4Z1vmF05rFlqOYxchDWvf6llD0D7eYFcFgwRmdA+4MDkpTD+WSA3Y
         YB6Q==
X-Gm-Message-State: AOAM533ngEJm6AOx8N9Ee8TVL8JGbmIhocgOcTmH986Lm6ZKPW/V8rh0
        5Ixq/QDem6+dsxQuXzkyO5hgdigYwQs=
X-Google-Smtp-Source: ABdhPJzbcFQsPm7Juj1VJ+J7JhZyyCQaH2ESZtwRm7LnWnuXUzY2Z/dW/q488h9lXB+CpPnMrTeagA==
X-Received: by 2002:a17:90b:1284:: with SMTP id fw4mr1652373pjb.205.1598969831450;
        Tue, 01 Sep 2020 07:17:11 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:17:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH v3 21/23] um: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:37 +1000
Message-Id: <20200901141539.1757549-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Please ack or nack if you object to this being mered via
Arnd's tree.

 arch/um/include/asm/mmu_context.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..f8a100770691 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,9 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
  * end asm-generic/mm_hooks.h functions
  */
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 extern void force_flush_all(void);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
 	/*
@@ -66,13 +65,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, 
-				  struct task_struct *tsk)
-{
-}
-
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

