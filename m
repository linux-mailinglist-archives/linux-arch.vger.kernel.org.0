Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4711A20C0
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgDHMAf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgDHMAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qHYG2lKPWxAtj2y97LKGlEeBAYw/IleMtn8t2h2BNUI=; b=jqMwtXWTTkA0/3hvzI1s4BK9R4
        g7Gd0qqoRMNid+NeBaCpqsh7OXiuT9v8NNYqNEFMjWvIWct/K/5KwGw7o51P5KqRKw7cx4du3n9H3
        eEN2r19YLkITmGNOU6HbM3/g8QzUEtK51Gzkev/J0hob2diZCeUKsHd2jypkMAbsaa1RgBTc1if8v
        U4+hXPasDyScvvMXbtUfFz/7DZrkGjZP4BzcbfPggK6Epmawkj97nJfmwbhmx5pVDiJblL11Pp7nM
        T4BleYvqiLY/IDxTSupMu1FoRTvyouNNa868QLvJobXoF4ihunbOfFiOU8KlgleD3J5Xx07Wwm4UV
        +kH8ZMQg==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9N9-000292-L0; Wed, 08 Apr 2020 12:00:00 +0000
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
Subject: [PATCH 09/28] mm: rename CONFIG_PGTABLE_MAPPING to CONFIG_ZSMALLOC_PGTABLE_MAPPING
Date:   Wed,  8 Apr 2020 13:59:07 +0200
Message-Id: <20200408115926.1467567-10-hch@lst.de>
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

Rename the Kconfig variable to clarify the scope.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 include/linux/zsmalloc.h             | 2 +-
 mm/Kconfig                           | 2 +-
 mm/zsmalloc.c                        | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3cc3ca5fa027..583d8abd80a4 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -81,7 +81,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMA=y
 CONFIG_ZSMALLOC=m
-CONFIG_PGTABLE_MAPPING=y
+CONFIG_ZSMALLOC_PGTABLE_MAPPING=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 2219cce81ca4..0fdbf653b173 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -20,7 +20,7 @@
  * zsmalloc mapping modes
  *
  * NOTE: These only make a difference when a mapped object spans pages.
- * They also have no effect when PGTABLE_MAPPING is selected.
+ * They also have no effect when ZSMALLOC_PGTABLE_MAPPING is selected.
  */
 enum zs_mapmode {
 	ZS_MM_RW, /* normal read-write mapping */
diff --git a/mm/Kconfig b/mm/Kconfig
index 691021492e78..36949a9425b8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -700,7 +700,7 @@ config ZSMALLOC
 	  returned by an alloc().  This handle must be mapped in order to
 	  access the allocated space.
 
-config PGTABLE_MAPPING
+config ZSMALLOC_PGTABLE_MAPPING
 	bool "Use page table mapping to access object in zsmalloc"
 	depends on ZSMALLOC
 	help
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2f836a2b993f..ac0524330b9b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -293,7 +293,7 @@ struct zspage {
 };
 
 struct mapping_area {
-#ifdef CONFIG_PGTABLE_MAPPING
+#ifdef CONFIG_ZSMALLOC_PGTABLE_MAPPING
 	struct vm_struct *vm; /* vm area for mapping object that span pages */
 #else
 	char *vm_buf; /* copy buffer for objects that span pages */
@@ -1113,7 +1113,7 @@ static struct zspage *find_get_zspage(struct size_class *class)
 	return zspage;
 }
 
-#ifdef CONFIG_PGTABLE_MAPPING
+#ifdef CONFIG_ZSMALLOC_PGTABLE_MAPPING
 static inline int __zs_cpu_up(struct mapping_area *area)
 {
 	/*
@@ -1151,7 +1151,7 @@ static inline void __zs_unmap_object(struct mapping_area *area,
 	unmap_kernel_range(addr, PAGE_SIZE * 2);
 }
 
-#else /* CONFIG_PGTABLE_MAPPING */
+#else /* CONFIG_ZSMALLOC_PGTABLE_MAPPING */
 
 static inline int __zs_cpu_up(struct mapping_area *area)
 {
@@ -1233,7 +1233,7 @@ static void __zs_unmap_object(struct mapping_area *area,
 	pagefault_enable();
 }
 
-#endif /* CONFIG_PGTABLE_MAPPING */
+#endif /* CONFIG_ZSMALLOC_PGTABLE_MAPPING */
 
 static int zs_cpu_prepare(unsigned int cpu)
 {
-- 
2.25.1

