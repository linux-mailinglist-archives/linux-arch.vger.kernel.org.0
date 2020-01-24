Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940BA148BBE
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgAXQSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 11:18:24 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:60343 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387404AbgAXQSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 11:18:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ToSJxNn_1579882700;
Received: from localhost(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0ToSJxNn_1579882700)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jan 2020 00:18:20 +0800
From:   Guo Ren <guoren@linux.alibaba.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH] riscv: Use flush_icache_mm for flush_icache_user_range
Date:   Sat, 25 Jan 2020 00:18:10 +0800
Message-Id: <20200124161810.24322-1-guoren@linux.alibaba.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The only call path is:

__access_remote_vm -> copy_to_user_page -> flush_icache_user_range

Seems it's ok to use flush_icache_mm instead of flush_icache_all and
it could reduce flush_icache_all called on other harts.

I think the patch is the fixup for the commit 08f051eda33b.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Andrew Waterman <andrew@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index b69aecbb36d3..26589623fd57 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -85,7 +85,7 @@ static inline void flush_dcache_page(struct page *page)
  * so instead we just flush the whole thing.
  */
 #define flush_icache_range(start, end) flush_icache_all()
-#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
+#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma->vm_mm, 0)
 
 void dma_wbinv_range(unsigned long start, unsigned long end);
 void dma_wb_range(unsigned long start, unsigned long end);
-- 
2.17.0

