Return-Path: <linux-arch+bounces-10258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E467A3E3FE
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CAF1899D34
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265621504B;
	Thu, 20 Feb 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hYATQJd0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479292135B9;
	Thu, 20 Feb 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076427; cv=none; b=sqkIbVwp5C1c1ymjo7yeTzMsAK3K6Rl+lvFV0Or58mD2QkFljmYITwjGXQ408V3tYXmcWVksX9QlPjFMr//9FmwVlWs0Ar+oXu0dzY72iF8OD7Je9K263dIJ3BR9UVZQr05JkAoYa3BvXEobZlz9/HQWRwqmLryDVgwJ4PikP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076427; c=relaxed/simple;
	bh=tvVibzWFMT/Id704xOoV1gCY4q6/mA45h/Pg+6JUrQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mYyFi3bxv2SsCnuTfpxshFRzK6P6pvhTiWpdSOAdqhXitKW7DMEb/LVB6fbG74x43CnqFBiGxnuGMpD4UCUF1chFuxhuZbl9buLpfs3zOcAX9IlQpKZM2grdmH/XtQZ+ara+LgnIjOEYzSF+KGEpdRfvoKjutxCnraooyWc1zTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hYATQJd0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 232D22059197;
	Thu, 20 Feb 2025 10:33:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 232D22059197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740076418;
	bh=cM0W5qUd693Fr3OrdVtsWGhuROfGGe7HnF5gUiDq5aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYATQJd042Mb9AA2hOEuQb9t0B829p6m3wx38QlmCxkMU+kJ0xwtX834q7kzRzZ8A
	 uZVmHxLfDiD1AGB9IeRTLuD0LSb1nxl+76/RDFBUw6kVWQRhpINSjrtdamGqIcVYOZ
	 T9zPcMzpFEiryHLygzSoAi1824np2JNH/a00mNLk=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mhklinux@outlook.com,
	eahariha@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v2 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root partition support
Date: Thu, 20 Feb 2025 10:33:16 -0800
Message-Id: <1740076396-15086-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

CONFIG_MSHV_ROOT allows kernels built to run as a normal Hyper-V guest
to exclude the root partition code, which is expected to grow
significantly over time.

This option is a tristate so future driver code can be built as a
(m)odule, allowing faster development iteration cycles.

If CONFIG_MSHV_ROOT is disabled, don't compile hv_proc.c, and stub
hv_root_partition() to return false unconditionally. This allows the
compiler to optimize away root partition code blocks since they will
be disabled at compile time.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/Kconfig             | 16 ++++++++++++++++
 drivers/hv/Makefile            |  3 ++-
 include/asm-generic/mshyperv.h | 24 ++++++++++++++++++++----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..794e88e9dc6b 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -55,4 +55,20 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config MSHV_ROOT
+	tristate "Microsoft Hyper-V root partition support"
+	depends on HYPERV
+	depends on !HYPERV_VTL_MODE
+	# The hypervisor interface operates on 4k pages. Enforcing it here
+	# simplifies many assumptions in the root partition code.
+	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
+	# no particular order, making it impossible to reassemble larger pages
+	depends on PAGE_SIZE_4KB
+	default n
+	help
+	  Select this option to enable support for booting and running as root
+	  partition on Microsoft Hyper-V.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 9afcabb3fbd2..2b8dc954b350 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,5 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 
 # Code that must be built-in
-obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o hv_proc.o
+obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
+obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index d2b1a8fc074c..b29357cff2f7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -223,10 +223,6 @@ void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(void *addr);
 
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
-int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
-
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
@@ -327,9 +323,29 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_MSHV_ROOT)
 static inline bool hv_root_partition(void)
 {
 	return hv_current_partition_type == HV_PARTITION_TYPE_ROOT;
 }
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+
+#else /* CONFIG_MSHV_ROOT */
+static inline bool hv_root_partition(void) { return false; }
+static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+{
+	return -EOPNOTSUPP;
+}
+static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
+{
+	return -EOPNOTSUPP;
+}
+static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_MSHV_ROOT */
 
 #endif
-- 
2.34.1


