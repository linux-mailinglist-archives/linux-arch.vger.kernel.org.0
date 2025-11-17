Return-Path: <linux-arch+bounces-14830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2EC639D9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 096BE4E1AB9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F262F7478;
	Mon, 17 Nov 2025 10:49:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D37257435;
	Mon, 17 Nov 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376553; cv=none; b=DJ9HXAr4jsjgpw6BlIS9jYvU11XjIzpADCkCa1WasRKkUmZNDyUzHl9Il25Y7XtfzjbMgUYDwGDgTkARfFlpCDp/o8BhNSt4X4YPG9sFcLHmp+hzM2TTf6Ry5Cu3tUBuz3aLPL4P2JDOSCj6muLxz9F9DVi+fXnLjJNNA+ppgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376553; c=relaxed/simple;
	bh=RzoE+z4WZtEst8a0TLTBQRiw3A4tvs5r2oyQpJBjHaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpU/2XPs4EoMpubOieHmtbsfFvrL4j+WsR305/nJK9VltDJuzQ0kETy56KTRB4jnGF+LHy74JzNIh8OdbAli3ZZfBNdOgeOh3JINZTf1DAtdTsmDYh8HauONViJ8Nm7uWaMoBvLQtKxrxh+4/Y24A4Gsvt/6lwecBuoveNk9Ac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d94Gd1S7BzJ46tC;
	Mon, 17 Nov 2025 18:48:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A6B1D14038F;
	Mon, 17 Nov 2025 18:49:05 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 17 Nov 2025 10:49:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Drew Fustini
	<fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 2/7] memregion: Support fine grained invalidate by cpu_cache_invalidate_memregion()
Date: Mon, 17 Nov 2025 10:47:55 +0000
Message-ID: <20251117104800.2041329-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

From: Yicong Yang <yangyicong@hisilicon.com>

Extend cpu_cache_invalidate_memregion() to support invalidating a
particular range of memory by introducing start and length parameters.
Control of types of invalidation is left for when use cases turn up. For
now everything is Clean and Invalidate.

Where the range is unknown, use the provided cpu_cache_invalidate_all()
helper to act as documentation of intent in a fashion that is clearer than
passing (0, -1) to cpu_cache_invalidate_memregion().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v6: No change
v5: Tiny tweaks to patch description for readability.
v4: Add cpu_cache_invalidate_all() helper for the (0, -1) case that
    applies when we don't have the invalidate range so just want to
    invalidate all caches. - (Thanks to Dan Williams for this suggestion).
v3: Rebase on top of previous patch that removed the IO_RESDESC_*
    parameter.
---
 arch/x86/mm/pat/set_memory.c |  2 +-
 drivers/cxl/core/region.c    |  5 ++++-
 drivers/nvdimm/region.c      |  2 +-
 drivers/nvdimm/region_devs.c |  2 +-
 include/linux/memregion.h    | 13 +++++++++++--
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0cfee2544ad4..05e7704f0128 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -368,7 +368,7 @@ bool cpu_cache_has_invalidate_memregion(void)
 }
 EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
 
-int cpu_cache_invalidate_memregion(void)
+int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len)
 {
 	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
 		return -ENXIO;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 36489cb086f3..7d0f6f07352f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -236,7 +236,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 		return -ENXIO;
 	}
 
-	cpu_cache_invalidate_memregion();
+	if (!cxlr->params.res)
+		return -ENXIO;
+	cpu_cache_invalidate_memregion(cxlr->params.res->start,
+				       resource_size(cxlr->params.res));
 	return 0;
 }
 
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 47e263ecedf7..53567f3ed427 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -110,7 +110,7 @@ static void nd_region_remove(struct device *dev)
 	 * here is ok.
 	 */
 	if (cpu_cache_has_invalidate_memregion())
-		cpu_cache_invalidate_memregion();
+		cpu_cache_invalidate_all();
 }
 
 static int child_notify(struct device *dev, void *data)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index c375b11aea6d..1220530a23b6 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -90,7 +90,7 @@ static int nd_region_invalidate_memregion(struct nd_region *nd_region)
 		}
 	}
 
-	cpu_cache_invalidate_memregion();
+	cpu_cache_invalidate_all();
 out:
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index 945646bde825..a55f62cc5266 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -27,6 +27,9 @@ static inline void memregion_free(int id)
 /**
  * cpu_cache_invalidate_memregion - drop any CPU cached data for
  *     memregion
+ * @start: start physical address of the target memory region.
+ * @len: length of the target memory region. -1 for all the regions of
+ *       the target type.
  *
  * Perform cache maintenance after a memory event / operation that
  * changes the contents of physical memory in a cache-incoherent manner.
@@ -45,7 +48,7 @@ static inline void memregion_free(int id)
  * the cache maintenance.
  */
 #ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
-int cpu_cache_invalidate_memregion(void);
+int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len);
 bool cpu_cache_has_invalidate_memregion(void);
 #else
 static inline bool cpu_cache_has_invalidate_memregion(void)
@@ -53,10 +56,16 @@ static inline bool cpu_cache_has_invalidate_memregion(void)
 	return false;
 }
 
-static inline int cpu_cache_invalidate_memregion(void)
+static inline int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len)
 {
 	WARN_ON_ONCE("CPU cache invalidation required");
 	return -ENXIO;
 }
 #endif
+
+static inline int cpu_cache_invalidate_all(void)
+{
+	return cpu_cache_invalidate_memregion(0, -1);
+}
+
 #endif /* _MEMREGION_H_ */
-- 
2.48.1


