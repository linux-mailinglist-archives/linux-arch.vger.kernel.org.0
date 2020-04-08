Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF91A20FE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgDHMBX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:01:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgDHMBT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yoWrcY0l+M6NFV8Uvzg54oimNxw2jqv1XNGGXoQf8EM=; b=fgct8iNkw4/nL2q1x2CTzoiFy+
        GOnBpuDh9nQj7GoWcSmnwnTt+iyfxGbP8DS3O2zEk1a/Hz80jV3EETykN+FmdWPi0NFFG4fvnvdqD
        0PBhAbP75T9/HAp4v8SAHau0uicmcoq8heh8c+B/PuFOPYgAm6GN9f7DQ9NqFmO/SCtb1SNmmcFhh
        Lri2Z9/nLYmaChUWOkqWv0SGr/x6XhzvF/Fe2/Tbr+MYARDTgg+fMOEEtLFD3mb14DiWVTQxS+5D6
        XmQEEZ7u9b3j3Dd4druNDiePv9RJH6BsrgK1zZ8J6Gz4hWDS/xLpHuiaWBDA3MgNjfe+IUZvV+acg
        3vxyqjUA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9O8-0005qa-TW; Wed, 08 Apr 2020 12:01:01 +0000
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
Subject: [PATCH 26/28] arm64: use __vmalloc_node in arch_alloc_vmap_stack
Date:   Wed,  8 Apr 2020 13:59:24 +0200
Message-Id: <20200408115926.1467567-27-hch@lst.de>
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

arch_alloc_vmap_stack can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/vmap_stack.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 0a12115d9638..0cc6636e3f15 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -19,10 +19,8 @@ static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
 {
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
 
-	return __vmalloc_node_range(stack_size, THREAD_ALIGN,
-				    VMALLOC_START, VMALLOC_END,
-				    THREADINFO_GFP, PAGE_KERNEL, 0, node,
-				    __builtin_return_address(0));
+	return __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+			__builtin_return_address(0));
 }
 
 #endif /* __ASM_VMAP_STACK_H */
-- 
2.25.1

