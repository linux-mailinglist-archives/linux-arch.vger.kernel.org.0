Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127EB3805F6
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 11:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhENJQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 05:16:01 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60766 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhENJQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 05:16:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UYqB9hX_1620983673;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYqB9hX_1620983673)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 May 2021 17:14:48 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     will@kernel.org
Cc:     aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] asm-generic/tlb: Fix duplicate included asm-generic/tlb.h
Date:   Fri, 14 May 2021 17:14:31 +0800
Message-Id: <1620983671-45286-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Clean up the following includecheck warning:

./arch/arm/include/asm/tlb.h: asm-generic/tlb.h is included more than
once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/arm/include/asm/tlb.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03..df4a6ea 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -15,6 +15,7 @@
 #define __ASMARM_TLB_H
 
 #include <asm/cacheflush.h>
+#include <asm-generic/tlb.h>
 
 #ifndef CONFIG_MMU
 
@@ -22,8 +23,6 @@
 
 #define tlb_flush(tlb)	((void) tlb)
 
-#include <asm-generic/tlb.h>
-
 #else /* !CONFIG_MMU */
 
 #include <linux/swap.h>
@@ -34,8 +33,6 @@ static inline void __tlb_remove_table(void *_table)
 	free_page_and_swap_cache((struct page *)_table);
 }
 
-#include <asm-generic/tlb.h>
-
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-- 
1.8.3.1

