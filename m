Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E010A2590CD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgIAOim (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIAORm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC3DC06125C;
        Tue,  1 Sep 2020 07:17:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so873648pfg.2;
        Tue, 01 Sep 2020 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GA7usuAihtWp/iTn8pjSUo+agWDeKhUidbvz3amkOCk=;
        b=vKUi3CT5x2cUml5A3FoH5o7mANaQNhQQXmhG7RhK1IxI+2No8uNVjEZaMnr0IzA2e+
         mFHVMn57j/G7jahwTvh57QZYZvU7vQqDCBPat2qS08dUl36IGB1voFOeurV2SO5lo8pV
         uoi4tzm9zkWj9YrnimXxoRrV14iINOLZsZYMoQrd6IWNfezf/1EGZMNSmfEZWLvvfWT1
         blAfw7qPOqKSWzr1VkfaBD8C1QoL3fc8uwnEOLT9+uDmP3XOJdDnXwxVsAqWls4Hdg1N
         pJses5elE/RX6Oea6bkY0P/rjv6Cch/kHx1VldEEsG1ApybMcX2COkroEQky+gc3T5uU
         k9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GA7usuAihtWp/iTn8pjSUo+agWDeKhUidbvz3amkOCk=;
        b=doXdsU3+yThowehm/LuJVsYUfrK8t7ZCOaGBKKQEcA/fySuez2evtf3gLMikrSYgBx
         eDu6m64cIEF2fy3tfcpri8xjZipJaCzM5yalNidwdHiO092WwamJNZfUc2vWHyJjvS6I
         z2324lVH7Juk+cQmQaDkRQ8wCiNGQyyeJCLDNy5CffalOPQ/a5vD2U8KC4FCw6XL1Si1
         VqthlvklzM8F4nYAf4RjR/SOTdNgm9lhF7UyM84gmG9opFJKuqyLW7DY7DV3pNz6umgs
         ts8wnNHTgBpqWOIWKn5bSqNfOxmpg8wNeIt31EqLVwn9l4AZNDAoZQKBKFmUqxg5I/v7
         kvDA==
X-Gm-Message-State: AOAM5319gBA23hzofWnKTjfKT+Z6aFY9JNOUp2luaIGNsP80n4640ucM
        ZjP8obVG8vkA2rObj4h2LELhDwYgTrU=
X-Google-Smtp-Source: ABdhPJzeqxrrUqdUUsxeoS6rzUl1Puk+QzDB+Z29ZkL6FZRno1ci3PQMh4rLsPoa0DyPjGjLi0oj/w==
X-Received: by 2002:a62:fc46:: with SMTP id e67mr2009061pfh.109.1598969823177;
        Tue, 01 Sep 2020 07:17:03 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:17:02 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v3 19/23] sh: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:35 +1000
Message-Id: <20200901141539.1757549-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

