Return-Path: <linux-arch+bounces-10988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BBA6AC44
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 18:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7BE461F77
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A11DFDB9;
	Thu, 20 Mar 2025 17:42:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED51D7E41;
	Thu, 20 Mar 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492547; cv=none; b=EOk8ahUSDtoCStxybWJJMsApaWhuKfsg4IRhHRvitYBKZgPdYw0B/fhkDdTMzHxhCQJ16et7BgO0PPlvPlva0P+uwi8HpDDGuI0kVl6+Hn7yMoklLO9iBVYdw3qsEXdCKEthUXSe0PHI/WB/4NcK0zMdQ89tzgGAHZ//jGPP8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492547; c=relaxed/simple;
	bh=FTr+lyk7JqhK8p0DnorWhl9mDPFmTWkvv1/y/ay/2hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOkfVOCdct1gyVvfj18DVGx9EJaS5Gm//4dx5b5zBfMjQmgppbsT3uhD25P9jp9xr24VYXwc44iv1WcdEnN1IuqL3BI6E5UdefriISZ9PWFhJlFgd8VamLQwwM75ICxurWOR6HUxxFTlLQsZgLpDmjmURM6BEqSU63XCGm7OCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJXr66Rdqz6M4js;
	Fri, 21 Mar 2025 01:39:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F93614050D;
	Fri, 21 Mar 2025 01:42:23 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 18:42:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, <conor@kernel.org>, Yicong Yang
	<yangyicong@huawei.com>, <linux-acpi@vger.kernel.org>
CC: <linux-arch@vger.kernel.org>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, <linux-mm@kvack.org>,
	<gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 2/6] arm64: Support ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Date: Thu, 20 Mar 2025 17:41:14 +0000
Message-ID: <20250320174118.39173-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Yicong Yang <yangyicong@hisilicon.com>

ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
invalidate certain memory regions in a cache-incoherent manner.
Currently is used by NVIDMM and CXL memory. This is mainly done
by the system component and is implementation define per spec.
Provides a method for the platforms register their own invalidate
method and implement ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cacheflush.h | 14 ++++++++++
 arch/arm64/mm/flush.c               | 42 +++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..11ecd20ec3b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,6 +21,7 @@ config ARM64
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CC_PLATFORM
+	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CRC32
 	select ARCH_HAS_CRC_T10DIF if KERNEL_MODE_NEON
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 28ab96e808ef..b8eb8738c965 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -139,6 +139,20 @@ static __always_inline void icache_inval_all_pou(void)
 	dsb(ish);
 }
 
+#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+
+#include <linux/memregion.h>
+
+struct system_cache_flush_method {
+	int (*invalidate_memregion)(int res_desc,
+				    phys_addr_t start, size_t len);
+};
+
+void arm64_set_sys_cache_flush_method(const struct system_cache_flush_method *method);
+void arm64_clr_sys_cache_flush_method(const struct system_cache_flush_method *method);
+
+#endif /* CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION */
+
 #include <asm-generic/cacheflush.h>
 
 #endif /* __ASM_CACHEFLUSH_H */
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 013eead9b695..d822406d925d 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/libnvdimm.h>
 #include <linux/pagemap.h>
+#include <linux/memregion.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cache.h>
@@ -100,3 +101,44 @@ void arch_invalidate_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 #endif
+
+#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+
+static const struct system_cache_flush_method *scfm_data;
+DEFINE_SPINLOCK(scfm_lock);
+
+void arm64_set_sys_cache_flush_method(const struct system_cache_flush_method *method)
+{
+	guard(spinlock_irqsave)(&scfm_lock);
+	if (scfm_data || !method || !method->invalidate_memregion)
+		return;
+
+	scfm_data = method;
+}
+EXPORT_SYMBOL_GPL(arm64_set_sys_cache_flush_method);
+
+void arm64_clr_sys_cache_flush_method(const struct system_cache_flush_method *method)
+{
+	guard(spinlock_irqsave)(&scfm_lock);
+	if (scfm_data && scfm_data == method)
+		scfm_data = NULL;
+}
+
+int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
+{
+	guard(spinlock_irqsave)(&scfm_lock);
+	if (!scfm_data)
+		return -EOPNOTSUPP;
+
+	return scfm_data->invalidate_memregion(res_desc, start, len);
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
+
+bool cpu_cache_has_invalidate_memregion(void)
+{
+	guard(spinlock_irqsave)(&scfm_lock);
+	return !!scfm_data;
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
+
+#endif /* CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION */
-- 
2.43.0


