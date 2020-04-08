Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51C1A20BC
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgDHMAf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgDHMAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PTLovE2hoWoaJSeKjEPYtv2zFcEJY2sjZbxxW8f2wTw=; b=qBbgX++1L6mbdTJxAcMrWN4t2V
        u9WDZZC7mdQwUsrShnSL1UCdGBL3YYnIasKmmUdle7ux+K9NWAgFSn/8Z5Or/h5l2CXPBlEhJaH+s
        7ypYs8p8BFOakK1MBY+tZJqmU5FM7x+7mgGUTK0kaWjDdtB/i2g1gUOXjrGk3zunKwTyBeQcr7KsM
        jNBqMl/FSUWjf6f2hjNz2Fvg/spu5FxPMzkL8oana1Lk1b57TUxB8aSrns98Hs9ZP2LUsOwg/TcD1
        rV7BNeoVKk0JT391TnMyrKkrAgnqchbkGEaxqIGZfbm809OuI2n9SWJ28rGJFmfQY4V67OQKZ9BkQ
        2Rxzsv0Q==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9NF-0002CS-3L; Wed, 08 Apr 2020 12:00:06 +0000
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
Subject: [PATCH 10/28] mm: only allow page table mappings for built-in zsmalloc
Date:   Wed,  8 Apr 2020 13:59:08 +0200
Message-Id: <20200408115926.1467567-11-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows to unexport map_vm_area and unmap_kernel_range, which are
rather deep internal and should not be available to modules.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig   | 2 +-
 mm/vmalloc.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 36949a9425b8..614cc786b519 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -702,7 +702,7 @@ config ZSMALLOC
 
 config ZSMALLOC_PGTABLE_MAPPING
 	bool "Use page table mapping to access object in zsmalloc"
-	depends on ZSMALLOC
+	depends on ZSMALLOC=y
 	help
 	  By default, zsmalloc uses a copy-based object mapping method to
 	  access allocations that span two pages. However, if a particular
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3375f9508ef6..9183fc0d365a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2046,7 +2046,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	vunmap_page_range(addr, end);
 	flush_tlb_kernel_range(addr, end);
 }
-EXPORT_SYMBOL_GPL(unmap_kernel_range);
 
 int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 {
@@ -2058,7 +2057,6 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 
 	return err > 0 ? 0 : err;
 }
-EXPORT_SYMBOL_GPL(map_vm_area);
 
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
-- 
2.25.1

