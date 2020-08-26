Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A763D25324C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHZOyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgHZOyM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B45DC061756;
        Wed, 26 Aug 2020 07:54:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so1007167plt.3;
        Wed, 26 Aug 2020 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+CDYnf/xWMGywxFUASijaNggUa5Y5mjXoyq0c/F/hQ=;
        b=ABCc0wxzXmQFbpavgTux2cZChkynQe0eihohjnlQa09LtXmp5CCC3kOM/xH/BNwhYC
         eNBsB7z1RZ734xLZ/R0Y4RRlTYsyinkZm6BDq3RLmBgiZgHqOs6gjpGJ4bbHvkcBQ2Bo
         v5zsVxE9zwpFB3wK9fAJsA94LdFboAA9yUYy+ur5lk1Xe/IAFY2JUdzSEK/1feUyU9JE
         7WrjdhHvKqmllN/ic6WM+JKwtfNFBrYgPgTDCT6+sB2JHbP4/qTkQCQsddD9Mx6NJmT1
         U6PN52eFRFQe2QL5uIKxDJAycpivr+nXLFshi4snzJqhap52t7bmvf+w0biB2bB015xc
         AF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+CDYnf/xWMGywxFUASijaNggUa5Y5mjXoyq0c/F/hQ=;
        b=HhQGihQk/UUQxrVadcuAuXwXsX1bk9zi72UCW9cH6pdIvo8sBZFnKJvWCB1OU7B9ex
         XYh0Hpf7ebjU1+265PoQufiHrozmg8jW6C9ndV/4lvGahN39qiwZdyE+PcefHPuvx5DG
         8NyOg5g+KySrBWauLIIFT0cCKLW6P54k7c1QzqKUrjPPWGOu/52y502uvtHWwJZxDq+a
         pYs/wOdiQtdIgSBsUkmY8hCzWhpSZRMpUI21Sg55ADIG+3lQwviEWCbqnhyGQSwhYb3t
         7HhxoCgiYkRAtvbZ6+xF0Xz4ZmdSsxHr+gTj3/6C202M/fXF1VCSFNq3VrZ4zPMO2hR3
         IGVw==
X-Gm-Message-State: AOAM5330OEp+VwhWpz1AyS/V+plISVMijznlUN6y1uReW/E3nwpfLPhz
        FV4MmmfX9ONXT2udrlHtvO6QU3nvo0o=
X-Google-Smtp-Source: ABdhPJxGES4oTiL4srNoZVKcYTuqSIOU/NOB2lV5KOk23i9GiHBmxVxj3/D912wRJ0jpOMkhamtulQ==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr12344048plt.78.1598453650781;
        Wed, 26 Aug 2020 07:54:10 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:10 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v2 19/23] sh: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:45 +1000
Message-Id: <20200826145249.745432-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sh/include/asm/mmu_context.h    | 5 ++---
 arch/sh/include/asm/mmu_context_32.h | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 461b1304580b..78eef4e7d5df 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -84,6 +84,7 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -120,9 +121,7 @@ static inline void switch_mm(struct mm_struct *prev,
 			activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
-#define deactivate_mm(tsk,mm)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk)		do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #else
 
diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/mmu_context_32.h
index 71bf12ef1f65..bc5034fa6249 100644
--- a/arch/sh/include/asm/mmu_context_32.h
+++ b/arch/sh/include/asm/mmu_context_32.h
@@ -2,15 +2,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_32_H
 #define __ASM_SH_MMU_CONTEXT_32_H
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	/* Do nothing */
-}
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 static inline void set_asid(unsigned long asid)
 {
-- 
2.23.0

