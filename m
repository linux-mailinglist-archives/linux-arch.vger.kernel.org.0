Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF9230021
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgG1Der (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgG1Deq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3DC061794;
        Mon, 27 Jul 2020 20:34:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so10190329pfu.1;
        Mon, 27 Jul 2020 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HL7MtoQQEXJbD0R6d/PbjEBDKKa2Jd3NzBDoc9RLQlI=;
        b=alOL57K1j81ubRKJUFCi4kYNgADnqsVICZmOks4Ew6eayB10wPf7QRXEIyQLQiQz+r
         JULpy2JKO1zSwr3rdJIzFIdo3cOSvHCAv16IrpnjIZzLVoXBB3o3l1KfiHxOLuMYzj+7
         zHhh9o/vHTqdaLRcE37Gy9CE+sCcQeNgzxn7B24EImXeaLx27nIOh8s6aUDv+Ks22Z4D
         LckZxLW2BY8kq1RKzJF4W1xdSzb2EgaYbZJ/iDFh/gTQ5Z05NRLi++iva8t7mgWGqgqL
         uRGJcB6oZT0MIKkE/ImH+lWjNq60Mx5fqvbHTKGP+uNnbhJJMOyDU6TDSNuZa6msgf4C
         oq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HL7MtoQQEXJbD0R6d/PbjEBDKKa2Jd3NzBDoc9RLQlI=;
        b=oPpgWSeF9F2mgWVjfZx3xI1fUpFyv1lshc5FZzeSei85NX25GE1V0bHN03/86a0+Yo
         03qGCNRZ4D5+BvopcnP+2x5ZMp4XY1cM6j+9RibA6Ruy9EU3U0MZxjskXgiRiGgTzrRd
         Dlo7uhaH/vhbIk2CvQAdfi9UYVzaXbeqfFvm+715yk+WpJGw9Mf4Y069p6uATDu2BOIi
         Oe+Nsv4SILPT5o0QrgNXnRDzF+BOuvssMlXdCAndcd42Npv9w021SSn5XaNZP7q+nVjM
         tw/a8CmwNloDxe2DVrBiPq6cS97YP5MADDPpov2libc8VIVkq4bchAktSnFWOGTnNha0
         80OQ==
X-Gm-Message-State: AOAM5303tIt43DhzBhvLn6IM+9x8/hLTrNgt9r+EINcg3SpQFeN1coYJ
        RWUZWGpJepxYoFekKlNGoMbP4mKL
X-Google-Smtp-Source: ABdhPJw9Vc66wmybAqwevWxPGcHdHCsl+QByAKHybSBTqvhpqDvbi8b/flGkN692mj/WG7gwCMJaLg==
X-Received: by 2002:a62:3385:: with SMTP id z127mr9025613pfz.31.1595907285632;
        Mon, 27 Jul 2020 20:34:45 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 07/24] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:48 +1000
Message-Id: <20200728033405.78469-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/hexagon/include/asm/mmu_context.h | 33 ++++----------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/hexagon/include/asm/mmu_context.h b/arch/hexagon/include/asm/mmu_context.h
index cdc4adc0300a..81947764c47d 100644
--- a/arch/hexagon/include/asm/mmu_context.h
+++ b/arch/hexagon/include/asm/mmu_context.h
@@ -15,39 +15,13 @@
 #include <asm/pgalloc.h>
 #include <asm/mem-layout.h>
 
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 /*
  * VM port hides all TLB management, so "lazy TLB" isn't very
  * meaningful.  Even for ports to architectures with visble TLBs,
  * this is almost invariably a null function.
+ *
+ * mm->context is set up by pgd_alloc, so no init_new_context required.
  */
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *tsk)
-{
-}
-
-/*
- * Architecture-specific actions, if any, for memory map deactivation.
- */
-static inline void deactivate_mm(struct task_struct *tsk,
-	struct mm_struct *mm)
-{
-}
-
-/**
- * init_new_context - initialize context related info for new mm_struct instance
- * @tsk: pointer to a task struct
- * @mm: pointer to a new mm struct
- */
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	/* mm->context is set up by pgd_alloc */
-	return 0;
-}
 
 /*
  *  Switch active mm context
@@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 /*
  *  Activate new memory map for task
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
@@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */
 #include <asm-generic/mm_hooks.h>
 
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

