Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5621A20D9
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgDHMAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgDHMAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MdI7hYvB8H59wJUy/bDd3DLvQ/Y7NjDPTi/6Y1N+3xo=; b=oBXgOvfKuQ0cA1zrUU+9FZZdxI
        Tw2KgK/EBdsvvKB2EjRHTs7YasIZU/GkBi/huPTCajO09wg0CGETLLloV0TI7bSWojpyNZ80xZPGK
        OU3rCXXboUvLt3gNTnCJeKXU7mpUIpXYVvl5ytOz8s5BDpkGD0We5krcZQz4bQrM5quUkr+bNDo4I
        Rlnv0VI+L4A+73DKzVs8UU733HXGiTIT49e173N8QcGPIX0wnWgmEOEdaMKXq1CBLLLecI3KVygXp
        Wrg/eTQDDD0S4LhbOVgCFmk4rPX0HsxVFRFpyu3ylRpAgygvSJsww6vi/+a0Vgd1zF7YluEqwwjbW
        OxqUj4Qw==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9Nc-00055R-Bm; Wed, 08 Apr 2020 12:00:29 +0000
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
Subject: [PATCH 16/28] mm: remove unmap_vmap_area
Date:   Wed,  8 Apr 2020 13:59:14 +0200
Message-Id: <20200408115926.1467567-17-hch@lst.de>
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

This function just has a single caller, open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b0c7cdc8701a..258220b203f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1247,14 +1247,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
-/*
- * Clear the pagetable entries of a given vmap_area
- */
-static void unmap_vmap_area(struct vmap_area *va)
-{
-	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
-}
-
 /*
  * lazy_max_pages is the maximum amount of virtual address space we gather up
  * before attempting to purge with a TLB flush.
@@ -1416,7 +1408,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 static void free_unmap_vmap_area(struct vmap_area *va)
 {
 	flush_cache_vunmap(va->va_start, va->va_end);
-	unmap_vmap_area(va);
+	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(va->va_start, va->va_end);
 
-- 
2.25.1

