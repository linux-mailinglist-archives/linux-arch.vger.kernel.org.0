Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA90230049
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG1Dfp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgG1Dfp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8879C061794;
        Mon, 27 Jul 2020 20:35:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so9189220pls.5;
        Mon, 27 Jul 2020 20:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JLKzjyC1SBrEiODvVn8VxTDptzEZPqzW7tXvM9+ThQ=;
        b=Y4v7O+c6dQW18i+moFxlIujKDWDg8TDWOxk7VAOQUv7lpN3eIGmWg65qbJokQXpv40
         UuT6EROOAMfswGgIFaroSWv+Mxql9qoz1IHiogbhHvaOeJP1mcnqhbDtYipKgiKhmP4G
         BM/hy0mcL/r4XYZNyEQ/Dq3DNN4I4sCLkCLJRfIpmVHZNZDKsRDobQidEP4GEcXETmgo
         e0Whauxc61AhbEoBPJup+JQsoTFN2+iNEOikR5SKtBYnAyNqDLjB7PwWnbfMG9758iOP
         ahvYvtqrPAIyVMePToqBg8V2Nwy0qyOncpCfHJtYy8nW/uEDwftqKXhZkuo+JYERt7QE
         BKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JLKzjyC1SBrEiODvVn8VxTDptzEZPqzW7tXvM9+ThQ=;
        b=EHaneodta9fzdJ5jL5SSH0cZpBZ7xOOWPvI1ST8Rl+vJqYI6qtc+PMjIJZzRAnIS0W
         lEPRLjc/++YWT3pbBBHnS6GU/tUeiRhza/LYlWmgN2Td/wp/Y05yomAxNkH4gm57GfxQ
         DiNdMgU9TxmjdGoT0zLdEvhhcAI/VnYlCo5sgaPKsGDAEnQ1LqC+3nRLbToFdT5Fsdke
         HeaOxI+Y3Rfoc1BtzdtjhD6N70q/v7lKx0P+Hn6H4qad1fib0OzeFnE2YnaK77j7UWKz
         o91iT1aM229AhzENMpzMrCRoxiHXF36xsQXBNqRwDAkhnRe2B6Kx4nvfUpM+s52zSMst
         va4w==
X-Gm-Message-State: AOAM533RpEEc6Fjq4Lmdw4l99bPAD754+M+uehV9bTB85vTHHf8qdaTK
        TyuDiCUBsdALof2z1aMGa50E2eT8
X-Google-Smtp-Source: ABdhPJwI1FVOs/aIP3aOo7bYYcO5O1FN4uPDxItlYfSi2TqGuyUZ2WAOWZxW7EZLnuLC+TqbMNcSKg==
X-Received: by 2002:a17:90a:f493:: with SMTP id bx19mr2119021pjb.134.1595907344315;
        Mon, 27 Jul 2020 20:35:44 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:43 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 22/24] unicore32: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:03 +1000
Message-Id: <20200728033405.78469-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/unicore32/include/asm/mmu_context.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 388c0c811c68..e1751cb5439c 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -18,24 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-single.h>
 
-#define init_new_context(tsk, mm)	0
-
-#define destroy_context(mm)		do { } while (0)
-
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
@@ -52,9 +34,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		cpu_switch_mm(next->pgd, next);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-#define activate_mm(prev, next)	switch_mm(prev, next, NULL)
-
 /*
  * We are inserting a "fake" vma for the user-accessible vector page so
  * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
@@ -95,4 +74,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 	/* by default, allow everything */
 	return true;
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

