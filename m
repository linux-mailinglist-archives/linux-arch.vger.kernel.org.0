Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885B0105721
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUQfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 11:35:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:21562 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 11:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574354099;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=MR6HbPNBWmyhl8iShSyS/i2w9Bm/K5EVySERuVVBGj4=;
        b=TyVrdzgI1FPDm9KOIuHfLT2UKmM1GT61qGppwmtrkIUJ+BIZLy+mQE2cgaZHJB88k+
        CKZuIbVQqGikB8MzYwEv0NeonnrKd8i5NLjs7vwBzk4hJs3sVp4Neg8cTI5V/PBO1Trx
        XUHgFerlZH9XNt7Y8FWBvr6pVk5XmCZC0Lb6pdmW1q64E33Dg0xCeINnRptPGkttc0aX
        7E59uwXr4gGgE2ArOQb9SuNwplcqkbMA2leyM6S2ZAfa4rYC4o5Xcu56D0lja6kiZN1v
        Iz4vR2dMSJ+4lUO7hmuZb1b7BDzgXUTUN8AavrVhqHSNhFLbqQUZfl5FiNK2QtBMJpoA
        cmVw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgBcsBrTF1qGB6TwVFx4Pq4s7A="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:bd57:573a:d50f:b5]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vALGYnkb1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 17:34:49 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, darren@stevens-zone.net,
        mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
Date:   Thu, 21 Nov 2019 17:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
Content-Type: multipart/mixed;
 boundary="------------CA5FBA987424D6E471C8129F"
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------CA5FBA987424D6E471C8129F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.11.19 um 14:33 schrieb Robin Murphy:
> On 21/11/2019 12:21 pm, Christian Zigotzky wrote:
>> On 21 November 2019 at 01:16 pm, Christian Zigotzky wrote:
>>> On 21 November 2019 at 08:29 am, Christoph Hellwig wrote:
>>>> On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
>>>>> /*
>>>>>   *  DMA addressing mode.
>>>>>   *
>>>>>   *  0 : 32 bit addressing for all chips.
>>>>>   *  1 : 40 bit addressing when supported by chip.
>>>>>   *  2 : 64 bit addressing when supported by chip,
>>>>>   *      limited to 16 segments of 4 GB -> 64 GB max.
>>>>>   */
>>>>> #define   SYM_CONF_DMA_ADDRESSING_MODE 
>>>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
>>>>>
>>>>> Cyrus config:
>>>>>
>>>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
>>>>>
>>>>> I will configure “0 : 32 bit addressing for all chips” for the 
>>>>> RC8. Maybe this is the solution.
>>>> 0 means you are going to do bounce buffering a lot, which seems
>>>> generally like a bad idea.
>>>>
>>>> But why are we talking about the sym53c8xx driver now?  The last issue
>>>> you reported was about video4linux allocations.
>>>>
>>> Both drivers have the same problem. They don't work if we have more 
>>> than 3.5GB RAM. I try to find a solution until you have a good 
>>> solution. I have already a solution for V4L but I still need one for 
>>> the sym53c8xx driver.
>> OK, you mean that "0" is a bad idea but maybe it works until you have 
>> a solution. ;-)
>
> Is this on the same machine with the funny non-power-of-two 
> bus_dma_mask as your other report? If so, does Nicolas' latest 
> patch[1] help at all?
>
> Robin.
>
> [1] 
> https://lore.kernel.org/linux-iommu/20191121092646.8449-1-nsaenzjulienne@suse.de/T/#u
>
Robin,

I modified the patch and compiled a new RC8 of kernel 5.4 today. (patch 
attached)

We have to wait to Rolands test results with his SCSI PCI card. I tested 
it today but my TV card doesn't work with this patch.

Thanks

--------------CA5FBA987424D6E471C8129F
Content-Type: text/x-patch;
 name="dma-v1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dma-v1.patch"

diff -rupN a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
--- a/arch/powerpc/sysdev/fsl_pci.c	2019-11-17 23:47:30.000000000 +0100
+++ b/arch/powerpc/sysdev/fsl_pci.c	2019-11-21 15:32:50.216488955 +0100
@@ -115,8 +115,8 @@ static void pci_dma_dev_setup_swiotlb(st
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 
-	pdev->dev.bus_dma_mask =
-		hose->dma_window_base_cur + hose->dma_window_size;
+	pdev->dev.bus_dma_limit =
+		hose->dma_window_base_cur + hose->dma_window_size - 1;
 }
 
 static void setup_swiotlb_ops(struct pci_controller *hose)
@@ -135,7 +135,7 @@ static void fsl_pci_dma_set_mask(struct
 	 * mapping that allows addressing any RAM address from across PCI.
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
-		dev->bus_dma_mask = 0;
+		dev->bus_dma_limit = 0;
 		dev->archdata.dma_offset = pci64_dma_offset;
 	}
 }
diff -rupN a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
--- a/drivers/iommu/dma-iommu.c	2019-11-17 23:47:30.000000000 +0100
+++ b/drivers/iommu/dma-iommu.c	2019-11-21 15:32:50.216488955 +0100
@@ -405,8 +405,7 @@ static dma_addr_t iommu_dma_alloc_iova(s
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
-	if (dev->bus_dma_mask)
-		dma_limit &= dev->bus_dma_mask;
+	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
diff -rupN a/drivers/of/device.c b/drivers/of/device.c
--- a/drivers/of/device.c	2019-11-17 23:47:30.000000000 +0100
+++ b/drivers/of/device.c	2019-11-21 15:32:50.216488955 +0100
@@ -93,7 +93,7 @@ int of_dma_configure(struct device *dev,
 	bool coherent;
 	unsigned long offset;
 	const struct iommu_ops *iommu;
-	u64 mask;
+	u64 mask, end;
 
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
@@ -148,12 +148,13 @@ int of_dma_configure(struct device *dev,
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
+	end = dma_addr + size - 1;
+	mask = DMA_BIT_MASK(ilog2(end) + 1);
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
-	/* ...but only set bus mask if we found valid dma-ranges earlier */
+	/* ...but only set bus limit if we found valid dma-ranges earlier */
 	if (!ret)
-		dev->bus_dma_mask = mask;
+		dev->bus_dma_limit = end;
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
diff -rupN a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2019-11-17 23:47:30.000000000 +0100
+++ b/include/linux/device.h	2019-11-21 15:32:50.216488955 +0100
@@ -1186,8 +1186,8 @@ struct dev_links_info {
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
  * 		hardware supports 64-bit addresses for consistent allocations
  * 		such descriptors.
- * @bus_dma_mask: Mask of an upstream bridge or bus which imposes a smaller DMA
- *		limit than the device itself supports.
+ * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
+ *		DMA limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
@@ -1270,7 +1270,7 @@ struct device {
 					     not all hardware supports
 					     64 bit addresses for consistent
 					     allocations such descriptors. */
-	u64		bus_dma_mask;	/* upstream dma_mask constraint */
+	u64		bus_dma_limit;	/* upstream dma constraint */
 	unsigned long	dma_pfn_offset;
 
 	struct device_dma_parameters *dma_parms;
diff -rupN a/include/linux/dma-direct.h b/include/linux/dma-direct.h
--- a/include/linux/dma-direct.h	2019-11-17 23:47:30.000000000 +0100
+++ b/include/linux/dma-direct.h	2019-11-21 15:37:40.091564417 +0100
@@ -28,7 +28,7 @@ static inline bool dma_capable(struct de
 		return false;
 
 	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
+		min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff -rupN a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h	2019-11-17 23:47:30.000000000 +0100
+++ b/include/linux/dma-mapping.h	2019-11-21 15:32:50.220488949 +0100
@@ -693,7 +693,7 @@ static inline int dma_coerce_mask_and_co
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
+	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
 			    dma_get_required_mask(dev);
 }
 
diff -rupN a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c	2019-11-17 23:47:30.000000000 +0100
+++ b/kernel/dma/direct.c	2019-11-21 15:50:09.570609847 +0100
@@ -27,10 +27,10 @@ static void report_addr(struct device *d
 {
 	if (!dev->dma_mask) {
 		dev_err_once(dev, "DMA map on device without dma_mask\n");
-	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
+	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_limit) {
 		dev_err_once(dev,
-			"overflow %pad+%zu of DMA mask %llx bus mask %llx\n",
-			&dma_addr, size, *dev->dma_mask, dev->bus_dma_mask);
+			"overflow %pad+%zu of DMA mask %llx bus limit %llx\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
 	}
 	WARN_ON_ONCE(1);
 }
@@ -51,15 +51,14 @@ u64 dma_direct_get_required_mask(struct
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-		u64 *phys_mask)
+		u64 *phys_limit)
 {
-	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
-		dma_mask = dev->bus_dma_mask;
+	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
 
 	if (force_dma_unencrypted(dev))
-		*phys_mask = __dma_to_phys(dev, dma_mask);
+		*phys_limit = __dma_to_phys(dev, dma_limit);
 	else
-		*phys_mask = dma_to_phys(dev, dma_mask);
+		*phys_limit = dma_to_phys(dev, dma_limit);
 
 	/*
 	 * Optimistically try the zone that the physical address mask falls
@@ -69,9 +68,9 @@ static gfp_t __dma_direct_optimal_gfp_ma
 	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
 	 * zones.
 	 */
-	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (*phys_limit <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
 		return GFP_DMA;
-	if (*phys_mask <= DMA_BIT_MASK(32))
+	if (*phys_limit <= DMA_BIT_MASK(32))
 		return GFP_DMA32;
 	return 0;
 }
@@ -79,7 +78,7 @@ static gfp_t __dma_direct_optimal_gfp_ma
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
-			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
+			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -88,7 +87,7 @@ struct page *__dma_direct_alloc_pages(st
 	size_t alloc_size = PAGE_ALIGN(size);
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
-	u64 phys_mask;
+	u64 phys_limit;
 
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
@@ -96,7 +95,7 @@ struct page *__dma_direct_alloc_pages(st
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-			&phys_mask);
+			&phys_limit);
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, alloc_size);
@@ -110,7 +109,7 @@ again:
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		    phys_mask < DMA_BIT_MASK(64) &&
+		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
 			gfp |= GFP_DMA32;
 			goto again;
diff -rupN a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
--- a/arch/powerpc/include/asm/dma-direct.h	2019-11-17 23:47:30.000000000 +0100
+++ b/arch/powerpc/include/asm/dma-direct.h	2019-11-21 16:18:13.316815445 +0100
@@ -8,7 +8,7 @@ static inline bool dma_capable(struct de
 		return false;
 
 	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
+		min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
 }
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)

--------------CA5FBA987424D6E471C8129F--
