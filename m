Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07E1D5126
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgEOOh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbgEOOh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:37:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA40C05BD09;
        Fri, 15 May 2020 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QKVIgxxqArZPDCcD+fcp72AY7pKZ1eMD6jkvekw50ps=; b=U00g7SVm+r79wulCB6FTYGkw2R
        mRjWYIYyV0s9ydUNfDN6K5qNd19C5wPzcyqdvTfWLUuzKDBgaFjA/j7PIE3Ik9Qv4BLdMp9S+ecqJ
        wMjUpwQRFD9dvbDYMKody/broi5k1VZaOWbhSNaKaizd07PkJ0djmXfFeF1Qw6hZ9Dpy4FCKopPYu
        S/j9yHKeykn1OL0HU8wHBaV3EeyvT+n3ZvhzUx/KerOOi3kKY3R5FABp9POlwEC1ZNmy5ofW5/u9+
        boVRGb5d7zr5S1XbTEie4sTFM2c2oZ3FyuZcpdA8JPIL+Jq94iMkKr0MrCpW5jDPc+pqijaaTfwZv
        bsQqw1XA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbT3-0004oj-R3; Fri, 15 May 2020 14:37:42 +0000
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
Subject: [PATCH 18/29] arm,sparc,unicore32: remove flush_icache_user_range
Date:   Fri, 15 May 2020 16:36:35 +0200
Message-Id: <20200515143646.3857579-19-hch@lst.de>
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

flush_icache_user_range is only used by <asm-generic/cacheflush.h>, so
remove it from the architectures that implement it, but don't use
<asm-generic/cacheflush.h>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/cacheflush.h       | 3 ---
 arch/sparc/include/asm/cacheflush_32.h  | 2 --
 arch/sparc/include/asm/cacheflush_64.h  | 1 -
 arch/unicore32/include/asm/cacheflush.h | 3 ---
 4 files changed, 9 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 7114b9aa46b87..c78e14fcfb5df 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -318,9 +318,6 @@ extern void flush_kernel_dcache_page(struct page *);
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
 
-#define flush_icache_user_range(vma,page,addr,len) \
-	flush_dcache_page(page)
-
 /*
  * We don't appear to need to do anything here.  In fact, if we did, we'd
  * duplicate cache flushing elsewhere performed by flush_dcache_page().
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index fb66094a2c30c..41c6d734a4741 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -17,8 +17,6 @@
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma, pg)		do { } while (0)
 
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
 		flush_cache_page(vma, vaddr, page_to_pfn(page));\
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index e7517434d1fa6..b9341836597ec 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -49,7 +49,6 @@ void __flush_dcache_range(unsigned long start, unsigned long end);
 void flush_dcache_page(struct page *page);
 
 #define flush_icache_page(vma, pg)	do { } while(0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 void flush_ptrace_access(struct vm_area_struct *, struct page *,
 			 unsigned long uaddr, void *kaddr,
diff --git a/arch/unicore32/include/asm/cacheflush.h b/arch/unicore32/include/asm/cacheflush.h
index 9393ca4047e93..ff0be92ebc320 100644
--- a/arch/unicore32/include/asm/cacheflush.h
+++ b/arch/unicore32/include/asm/cacheflush.h
@@ -162,9 +162,6 @@ extern void flush_dcache_page(struct page *);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
-#define flush_icache_user_range(vma, page, addr, len)	\
-	flush_dcache_page(page)
-
 /*
  * We don't appear to need to do anything here.  In fact, if we did, we'd
  * duplicate cache flushing elsewhere performed by flush_dcache_page().
-- 
2.26.2

