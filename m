Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF26230016
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgG1De1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1De1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86651C061794;
        Mon, 27 Jul 2020 20:34:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so10190021pfu.1;
        Mon, 27 Jul 2020 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6IDKVv/shVEq6irgZZFcLvF1FRkf6GgTDbDcMbNEAs=;
        b=mUj0kRjoi+GkfsEEulsR8I1ODkKxm2yMW1q4DFRYoT2WuM/K1HJF18QaoGvF51V/BY
         vM83LGIhB6ZjJqLPPHT9uFlSBP3KReVY8HB79V4M8Wu/vF+xgORhq7DMZEQQ++NH0ZAV
         mFK4Xn6j0PeyM+RyBFjURcrBjsahRZ/ZJI3c3pzHIdF5ztbBCzR8pUV3rViN1Dm9oFQ1
         RZGL/vy0pzgwTBdTrrp2WpxcIcp2doMnFvbFH+fq2Yofew4xjI0Bk+jVA47kOwv5RZ2q
         eng4HHv3cWyaJuK54Ux9nmmi9vtCNW+EBWiEzxhDxn7JpTKe7JiIdHXfBIS4yOBwJGA7
         bmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6IDKVv/shVEq6irgZZFcLvF1FRkf6GgTDbDcMbNEAs=;
        b=kEr9LgKk7jVvcCxCq0fyM9uVjXhbNNr/zVFLrk9UOkgGW2xFutJCuZvsnYk+C0IMkN
         NncPWNmtDnReCmbmvqNaYkgtyVOXMO+9Kh/3oST7Jvc8Ap27uQ2dn0uwzhIHIezSgyt7
         J7a91aMrSrZWyJF24a96GJ74qptHR6i84oKaankDkjzzDHrDs2LzP554IMzwy6sZIM3K
         CYVJJourdQy9E7T+yerYacMsZYCSbuoH49phJAOArV8GAtcUolSqDxfMA9qlzovdflHD
         x7nSVNLlVTEmQzdqvfUedL9pdGVbLSZ6dL9nSZ5w7EH+ZftawF7HHAGaOOXNNEVgvk0g
         2tEw==
X-Gm-Message-State: AOAM530Y3U8pY9PfGFmDbI10LwHWanqS4KGZWY0r29EgDTLR/3OeXn7b
        IofbuUTsKb0XrsZ5LWZHr1IKyPLB
X-Google-Smtp-Source: ABdhPJxXK0fAvVm2vGx0kybaDVzbf7EyPsM4mvSci9SPK3buL1yg9sAfhTTS/zJLffLE9MCTeN62IQ==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr8626171pfm.34.1595907266776;
        Mon, 27 Jul 2020 20:34:26 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 02/24] alpha: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:43 +1000
Message-Id: <20200728033405.78469-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 6d7d9bc1b4b8..4eea7c616992 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -214,8 +214,6 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 	tbiap();
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 #ifdef CONFIG_ALPHA_GENERIC
 # define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
@@ -229,6 +227,7 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 # endif
 #endif
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -242,12 +241,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-extern inline void
-destroy_context(struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -255,6 +249,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
 #undef __MMU_EXTERN_INLINE
-- 
2.23.0

