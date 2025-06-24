Return-Path: <linux-arch+bounces-12438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D79AE6BAC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632B87AB132
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103630749B;
	Tue, 24 Jun 2025 15:48:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353926CE18;
	Tue, 24 Jun 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780122; cv=none; b=t0hN9pzKbhJMsoJr7CvhsrARnS5new2uLTEALgbT+2nx/iPwxHXt0/AL2reYszJ48IHS/jTquO0JRF/0vcssNcXLfuiZbVbX7Yu1i4Z8Dc1ioIPZIkP34tjwjzQu5HOe47/HH36iQtpFuyxZXEMem3Ot76AkINNwJQjgA5u8E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780122; c=relaxed/simple;
	bh=09VWyhbytfHIPmjC0JqRlZ5hftULEhD4/shI0lMgRyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+xrE883cCcwQpQF+gOgvG79wW5U1DAXlUoH79hW8kmqfY6RNGPw5rdN+JaCu3/1iNvUBhTpLvhrdgJXIdmyoWmGiBqsz6hPtPF9ON+sOopUNJV5mbGnHYllNnKiE1q5T0JULuhTMlJBUR5xErfXNTSsGXF+wLc+1UagU+dPZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRTqZ0CdXz6GDts;
	Tue, 24 Jun 2025 23:47:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6251F1400CA;
	Tue, 24 Jun 2025 23:48:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 17:48:37 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, H Peter Anvin
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Subject: [PATCH v2 1/8] memregion: Support fine grained invalidate by cpu_cache_invalidate_memregion()
Date: Tue, 24 Jun 2025 16:47:57 +0100
Message-ID: <20250624154805.66985-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Yicong Yang <yangyicong@hisilicon.com>

Extend cpu_cache_invalidate_memregion() to support invalidate certain
range of memory. Control of types of invlidation is left for when
usecases turn up. For now everything is Clean and Invalidate.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 drivers/cxl/core/region.c    | 6 +++++-
 drivers/nvdimm/region.c      | 3 ++-
 drivers/nvdimm/region_devs.c | 3 ++-
 include/linux/memregion.h    | 8 ++++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 46edc11726b7..8b39aad22458 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -368,7 +368,7 @@ bool cpu_cache_has_invalidate_memregion(void)
 }
 EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
 
-int cpu_cache_invalidate_memregion(int res_desc)
+int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
 {
 	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
 		return -ENXIO;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..6e6e8ace0897 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -237,7 +237,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 		return -ENXIO;
 	}
 
-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	if (!cxlr->params.res)
+		return -ENXIO;
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL,
+				       cxlr->params.res->start,
+				       resource_size(cxlr->params.res));
 	return 0;
 }
 
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 88dc062af5f8..033e40f4dc52 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -110,7 +110,8 @@ static void nd_region_remove(struct device *dev)
 	 * here is ok.
 	 */
 	if (cpu_cache_has_invalidate_memregion())
-		cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
+		cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY,
+					       0, -1);
 }
 
 static int child_notify(struct device *dev, void *data)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index de1ee5ebc851..7e93766065d1 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -90,7 +90,8 @@ static int nd_region_invalidate_memregion(struct nd_region *nd_region)
 		}
 	}
 
-	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY,
+				       0, -1);
 out:
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c01321467789..91d088ee3695 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -28,6 +28,9 @@ static inline void memregion_free(int id)
  * cpu_cache_invalidate_memregion - drop any CPU cached data for
  *     memregions described by @res_desc
  * @res_desc: one of the IORES_DESC_* types
+ * @start: start physical address of the target memory region.
+ * @len: length of the target memory region. -1 for all the regions of
+ *       the target type.
  *
  * Perform cache maintenance after a memory event / operation that
  * changes the contents of physical memory in a cache-incoherent manner.
@@ -46,7 +49,7 @@ static inline void memregion_free(int id)
  * the cache maintenance.
  */
 #ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
-int cpu_cache_invalidate_memregion(int res_desc);
+int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len);
 bool cpu_cache_has_invalidate_memregion(void);
 #else
 static inline bool cpu_cache_has_invalidate_memregion(void)
@@ -54,7 +57,8 @@ static inline bool cpu_cache_has_invalidate_memregion(void)
 	return false;
 }
 
-static inline int cpu_cache_invalidate_memregion(int res_desc)
+static inline int cpu_cache_invalidate_memregion(int res_desc,
+						 phys_addr_t start, size_t len)
 {
 	WARN_ON_ONCE("CPU cache invalidation required");
 	return -ENXIO;
-- 
2.48.1


