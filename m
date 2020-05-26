Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88D61D51C2
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgEOOjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgEOOhh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:37:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C551C061A0C;
        Fri, 15 May 2020 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tuZN2xrlpt1mzaSPTZQmZcxarUCgYHN/WWoYWZD5CMA=; b=OENN5BUCXaUFPu7vI1494p7r4i
        S2dWDz0q6EWysp938RuBPRMV7kgePBmLH86pBEtpSxJyy42RL6Y+aCvaXjvJsMsI0Y4cyNO31G5iS
        EDmw72wTcCGqP425Pzg2PhrQeX9C+wPmSNKyptdRpxxMAO8Jbpjz23AKJX/zySzDflvnXEYd/KAWK
        vmOpVRfCzg8IGj9xt5P0AqH8hWqou3lR/3g0g4llT+vsNPlUKFazS2BA6cnVS0ADrmPONbFmj9wV2
        JISTWNjwp8dRFxxV5zRFRImsFzOhhILf6BR9L1clZ+G5XbmEr/KM3Eliay6Xe7YkhFBk3k/YJSHzP
        0aBKdEYw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbSb-0004At-Ol; Fri, 15 May 2020 14:37:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/29] arm64: use asm-generic/cacheflush.h
Date:   Fri, 15 May 2020 16:36:26 +0200
Message-Id: <20200515143646.3857579-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/cacheflush.h | 46 ++++-------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index e6cca3d4acf70..03a5a187163ab 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -94,20 +94,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 #endif
 	kick_all_cpus_sync();
 }
-
-static inline void flush_cache_mm(struct mm_struct *mm)
-{
-}
-
-static inline void flush_cache_page(struct vm_area_struct *vma,
-				    unsigned long user_addr, unsigned long pfn)
-{
-}
-
-static inline void flush_cache_range(struct vm_area_struct *vma,
-				     unsigned long start, unsigned long end)
-{
-}
+#define flush_icache_range flush_icache_range
 
 /*
  * Cache maintenance functions used by the DMA API. No to be used directly.
@@ -123,12 +110,7 @@ extern void __dma_flush_area(const void *, size_t);
  */
 extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 	unsigned long, void *, const void *, unsigned long);
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	do {							\
-		memcpy(dst, src, len);				\
-	} while (0)
-
-#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
+#define copy_to_user_page copy_to_user_page
 
 /*
  * flush_dcache_page is used when the kernel has written to the page
@@ -154,29 +136,11 @@ static __always_inline void __flush_icache_all(void)
 	dsb(ish);
 }
 
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-
-/*
- * We don't appear to need to do anything here.  In fact, if we did, we'd
- * duplicate cache flushing elsewhere performed by flush_dcache_page().
- */
-#define flush_icache_page(vma,page)	do { } while (0)
-
-/*
- * Not required on AArch64 (PIPT or VIPT non-aliasing D-cache).
- */
-static inline void flush_cache_vmap(unsigned long start, unsigned long end)
-{
-}
-
-static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
-{
-}
-
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 
-#endif
+#include <asm-generic/cacheflush.h>
+
+#endif /* __ASM_CACHEFLUSH_H */
-- 
2.26.2

