Return-Path: <linux-arch+bounces-13228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85619B2DA05
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3FD5A69E0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF32DE6ED;
	Wed, 20 Aug 2025 10:30:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787361D5170;
	Wed, 20 Aug 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685829; cv=none; b=cRO1YNdYZ8UB+YqYyCbN8+1AHfMh2P+Ti3wu7tb4+BcJ2OWKyfQ+UsxLVLmpmEJy2uKFYXzfZOeFVO5pJ+r4FrPZCxYn0/e7ZJD2PXSUxKhaIfLMF517uDYp2a9Mw6VyHuA4wLAaxykCmDmFM/PjVah6AMD9mJ23TqkeLEyIToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685829; c=relaxed/simple;
	bh=jOi3W5LlCxGuTIfCYNjiux4xfahWFBeicczxvSaERfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYo15oh061v5SfbZclnRe4X8PiVHoCUD/DMZFE9s5IIIgy5jrrAu721NS0wEAp75lWwMZAHStSF8lqhz9LTq/bi7/6hLh5GurrhJB0FKSxvO5Z44ojRh+299tDUULwLvtlw/1RtnBKNUTVt9yVgeZjJ2dxTt275z9Lruehmcjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6N2S16GWz6M4q0;
	Wed, 20 Aug 2025 18:28:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 858AF1402F4;
	Wed, 20 Aug 2025 18:30:23 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Aug 2025 12:30:22 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
CC: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>
Subject: [PATCH v3 1/8] memregion: Drop unused IORES_DESC_* parameter from cpu_cache_invalidate_memregion()
Date: Wed, 20 Aug 2025 11:29:43 +0100
Message-ID: <20250820102950.175065-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

The res_desc parameter was originally introduced for documentation purposes
and with the idea that with HDM-DB CXL invalidation could be triggered from
the device. That has not come to pass and the continued existence of the
option is confusing when we add a range in the following patch which might
not be a strict subset of the res_desc. So avoid that confusion by dropping
the parameter.

Link: https://lore.kernel.org/linux-mm/686eedb25ed02_24471002e@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V3: New patch.
    As Dan calls out in the linked mail, an alternative might be to lookup
    the ranges and enforce the descriptor but his expressed preference
    was for dropping the parameter.
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 drivers/cxl/core/region.c    | 2 +-
 drivers/nvdimm/region.c      | 2 +-
 drivers/nvdimm/region_devs.c | 2 +-
 include/linux/memregion.h    | 7 +++----
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..4019b17fb65e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -368,7 +368,7 @@ bool cpu_cache_has_invalidate_memregion(void)
 }
 EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
 
-int cpu_cache_invalidate_memregion(int res_desc)
+int cpu_cache_invalidate_memregion(void)
 {
 	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
 		return -ENXIO;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..d7fa76810f82 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -228,7 +228,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 		return -ENXIO;
 	}
 
-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	cpu_cache_invalidate_memregion();
 	return 0;
 }
 
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 88dc062af5f8..c43506448edf 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -110,7 +110,7 @@ static void nd_region_remove(struct device *dev)
 	 * here is ok.
 	 */
 	if (cpu_cache_has_invalidate_memregion())
-		cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
+		cpu_cache_invalidate_memregion();
 }
 
 static int child_notify(struct device *dev, void *data)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index de1ee5ebc851..3cdd93d40997 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -90,7 +90,7 @@ static int nd_region_invalidate_memregion(struct nd_region *nd_region)
 		}
 	}
 
-	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
+	cpu_cache_invalidate_memregion();
 out:
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c01321467789..945646bde825 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -26,8 +26,7 @@ static inline void memregion_free(int id)
 
 /**
  * cpu_cache_invalidate_memregion - drop any CPU cached data for
- *     memregions described by @res_desc
- * @res_desc: one of the IORES_DESC_* types
+ *     memregion
  *
  * Perform cache maintenance after a memory event / operation that
  * changes the contents of physical memory in a cache-incoherent manner.
@@ -46,7 +45,7 @@ static inline void memregion_free(int id)
  * the cache maintenance.
  */
 #ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
-int cpu_cache_invalidate_memregion(int res_desc);
+int cpu_cache_invalidate_memregion(void);
 bool cpu_cache_has_invalidate_memregion(void);
 #else
 static inline bool cpu_cache_has_invalidate_memregion(void)
@@ -54,7 +53,7 @@ static inline bool cpu_cache_has_invalidate_memregion(void)
 	return false;
 }
 
-static inline int cpu_cache_invalidate_memregion(int res_desc)
+static inline int cpu_cache_invalidate_memregion(void)
 {
 	WARN_ON_ONCE("CPU cache invalidation required");
 	return -ENXIO;
-- 
2.48.1


