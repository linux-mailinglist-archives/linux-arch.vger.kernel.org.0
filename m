Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472601A7C45
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502795AbgDNNPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgDNNPY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2CBC061A0F;
        Tue, 14 Apr 2020 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Kl69HLWQOnE04wC+uxhqbtds0xCIlpZipVtGnO7U4c0=; b=My66LnNvAAIlKiTBNDHFh9YpkC
        z7lHK2mjnFfvdbpsnhzIplc0igKBHlccUmet+rWTnvHlHq/9jq22ujoAVkc1POdRaH8nAnI1fIf2D
        iJyGHO+afJtdahjeo02n82UU9FZkVAIG06owOap0CGyAZyLRsI+ffP4OAob2AaVSIv5f9QETNgA+d
        K0e+2WRQCZGCLar8kb3mgM70BVYScJ+P3YRBXFWyAGGZLEAGHUId6KaJ/FK2SkT4C1OKWx6UN6vlF
        DZCyomhhIG5he2qHvfEI4S6kujIjTND1odx3bgNjkRIvmtofxAGY9CpJyFJJavsvWxyvTPznzFkjI
        PnarSU2w==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOy-0007Ax-40; Tue, 14 Apr 2020 13:14:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] mm: enforce that vmap can't map pages executable
Date:   Tue, 14 Apr 2020 15:13:38 +0200
Message-Id: <20200414131348.444715-20-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To help enforcing the W^X protection don't allow remapping existing
pages as executable.

x86 bits from Peter Zijlstra <peterz@infradead.org>,
arm64 bits from Mark Rutland <mark.rutland@arm.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/pgtable.h     | 3 +++
 arch/x86/include/asm/pgtable_types.h | 6 ++++++
 include/asm-generic/pgtable.h        | 4 ++++
 mm/vmalloc.c                         | 2 +-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 538c85e62f86..47095216d6a8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -407,6 +407,9 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define __pgprot_modify(prot,mask,bits) \
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
 
+#define pgprot_nx(prot) \
+	__pgprot_modify(prot, 0, PTE_PXN)
+
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 947867f112ea..2e7c442cc618 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -282,6 +282,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+static inline pgprot_t pgprot_nx(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) | _PAGE_NX);
+}
+#define pgprot_nx pgprot_nx
+
 #ifdef CONFIG_X86_PAE
 
 /*
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 329b8c8ca703..8c5f9c29698b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -491,6 +491,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
 #endif
 
+#ifndef pgprot_nx
+#define pgprot_nx(prot)	(prot)
+#endif
+
 #ifndef pgprot_noncached
 #define pgprot_noncached(prot)	(prot)
 #endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7356b3f07bd8..334c75251ddb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2390,7 +2390,7 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_kernel_range((unsigned long)area->addr, size, prot,
+	if (map_kernel_range((unsigned long)area->addr, size, pgprot_nx(prot),
 			pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
-- 
2.25.1

