Return-Path: <linux-arch+bounces-11347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD0A819BD
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC268A5D97
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94CC86359;
	Wed,  9 Apr 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="McGLXv4A"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4CBE49;
	Wed,  9 Apr 2025 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157329; cv=none; b=u34UBEkVnXTxR92IjjIq3u4V5j95vjNZ5x9JcoV3zuTKxUfi9+vwgZd5YuAxSgYiKNc5/H2yU4gLAArKKMhkaGH4SzUkufHdZndPXMDmFvTW5RYVWHy7/Fcv+XOYXPYva8xoEAs2OJBL4RbFE6GyKKe+yLxYmFHAxCMyKtSuSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157329; c=relaxed/simple;
	bh=NlUylieq7zqtbJbgU5nAIJBTItP8sEwHTU+L22tHH2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud5m04cDmCImJpIMCCFfESI/iaSF7l7vjgOErPaxT9/y/+RDAOg4gv8D2aIYImTFycUHfFHjefRmR88VfmuSPp6cLK4bsukaHLhDDbv/fRSTWVNLgDPJ+VxQCpuEkkvSGxD/gOY7mGGSbvtep655iprDJmEwfyhSmKuzf76iTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=McGLXv4A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A01E62113E9C;
	Tue,  8 Apr 2025 17:08:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A01E62113E9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157319;
	bh=ScAyHBVfs5HWRQcwNPAG1fCXHMLzKFfYfnZtLva146o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McGLXv4AovBaCa6ogzUN2QbkWjq82U9bygyOzdxyboM+WLaIEHEN+Ia0S8Ca4osN3
	 081VZK6aLeK1NFOE/z9NdXVB2oiEouMbfcZ/idTfeY4xhVRysMWSvM6MC9aUJi+dvn
	 xTq8hwe3HwPc6kMOXjjJKIwUkcfda/7qxlVcUWd4=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 5/6] arch, drivers: Add device struct bitfield to not bounce-buffer
Date: Tue,  8 Apr 2025 17:08:34 -0700
Message-ID: <20250409000835.285105-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bounce-buffering makes the system spend more time copying
I/O data. When the I/O transaction take place between
a confidential and a non-confidential endpoints, there is
no other way around.

Introduce a device bitfield to indicate that the device
doesn't need to perform bounce buffering. The capable
device may employ it to save on copying data around.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/mm/mem_encrypt.c  | 3 +++
 include/linux/device.h     | 8 ++++++++
 include/linux/dma-direct.h | 3 +++
 include/linux/swiotlb.h    | 3 +++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 95bae74fdab2..6349a02a1da3 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -19,6 +19,9 @@
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
+	if (dev->use_priv_pages_for_io)
+		return false;
+
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..4aa4a6fd9580 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -725,6 +725,8 @@ struct device_physical_location {
  * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  * @dma_iommu: Device is using default IOMMU implementation for DMA and
  *		doesn't rely on dma_ops structure.
+ * @use_priv_pages_for_io: Device is using private pages for I/O, no need to
+ *		bounce-buffer.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -843,6 +845,7 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
 #endif
+	bool			use_priv_pages_for_io:1;
 };
 
 /**
@@ -1079,6 +1082,11 @@ static inline bool dev_removable_is_valid(struct device *dev)
 	return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
 }
 
+static inline bool dev_priv_pages_for_io(struct device *dev)
+{
+	return dev->use_priv_pages_for_io;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d7e30d4f7503..b096369f847e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -94,6 +94,9 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
+	if (dev_priv_pages_for_io(dev))
+		return phys_to_dma_unencrypted(dev, paddr);
+
 	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
 }
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..35ee10641b42 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -173,6 +173,9 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
+	if (dev_priv_pages_for_io(dev))
+		return false;
+
 	return mem && mem->force_bounce;
 }
 
-- 
2.43.0


