Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4939B1F8E24
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgFOGre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 02:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgFOGrQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:16 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E6C21508;
        Mon, 15 Jun 2020 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203633;
        bh=x9HwgOk8y9Ox/zkIemYG2drU3iFpIRxVqJjyvw3fnlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1FlvD3W77IjIuvh4vTixoaWll4XRfrWETALu/1ypkSFwWlhClWvgmX7OZ6tZYqPl
         haFXinmV3JU0e39iSI/+lGLXYdUr4crkqaUuxBBiID0X2nzVb3nPk6Bc8ERpGKbS80
         EtWMKcOjQ1mRbgp782DDARGZw+AoJc3Eq5mRYtyw=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnu-7Z; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-media@vger.kernel.org
Subject: [PATCH 26/29] docs: fix references for DMA*.txt files
Date:   Mon, 15 Jun 2020 08:47:05 +0200
Message-Id: <df99e29cef1e389f2acdff0eb1b92161f7be291b.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As we moved those files to core-api, fix references to point
to their newer locations.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/pci.rst                          |  6 +++---
 Documentation/block/biodoc.rst                     |  2 +-
 Documentation/core-api/bus-virt-phys-mapping.rst   |  2 +-
 Documentation/core-api/dma-api.rst                 |  6 +++---
 Documentation/core-api/dma-isa-lpc.rst             |  2 +-
 Documentation/driver-api/usb/dma.rst               |  6 +++---
 Documentation/memory-barriers.txt                  |  6 +++---
 .../translations/ko_KR/memory-barriers.txt         |  6 +++---
 arch/ia64/hp/common/sba_iommu.c                    | 12 ++++++------
 arch/parisc/kernel/pci-dma.c                       |  2 +-
 arch/x86/include/asm/dma-mapping.h                 |  4 ++--
 arch/x86/kernel/amd_gart_64.c                      |  2 +-
 drivers/parisc/sba_iommu.c                         | 14 +++++++-------
 include/linux/dma-mapping.h                        |  2 +-
 include/media/videobuf-dma-sg.h                    |  2 +-
 kernel/dma/debug.c                                 |  2 +-
 16 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 8c016d8c9862..d10d3fe604c5 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -265,7 +265,7 @@ Set the DMA mask size
 ---------------------
 .. note::
    If anything below doesn't make sense, please refer to
-   Documentation/DMA-API.txt. This section is just a reminder that
+   :doc:`/core-api/dma-api`. This section is just a reminder that
    drivers need to indicate DMA capabilities of the device and is not
    an authoritative source for DMA interfaces.
 
@@ -291,7 +291,7 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 Setup shared control data
 -------------------------
 Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
-memory.  See Documentation/DMA-API.txt for a full description of
+memory.  See :doc:`/core-api/dma-api` for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
 
@@ -421,7 +421,7 @@ owners if there is one.
 
 Then clean up "consistent" buffers which contain the control data.
 
-See Documentation/DMA-API.txt for details on unmapping interfaces.
+See :doc:`/core-api/dma-api` for details on unmapping interfaces.
 
 
 Unregister from other subsystems
diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
index b964796ec9c7..ba7f45d0271c 100644
--- a/Documentation/block/biodoc.rst
+++ b/Documentation/block/biodoc.rst
@@ -196,7 +196,7 @@ a virtual address mapping (unlike the earlier scheme of virtual address
 do not have a corresponding kernel virtual address space mapping) and
 low-memory pages.
 
-Note: Please refer to Documentation/DMA-API-HOWTO.txt for a discussion
+Note: Please refer to :doc:`/core-api/dma-api-howto` for a discussion
 on PCI high mem DMA aspects and mapping of scatter gather lists, and support
 for 64 bit PCI.
 
diff --git a/Documentation/core-api/bus-virt-phys-mapping.rst b/Documentation/core-api/bus-virt-phys-mapping.rst
index 4bb07c2f3e7d..c7bc99cd2e21 100644
--- a/Documentation/core-api/bus-virt-phys-mapping.rst
+++ b/Documentation/core-api/bus-virt-phys-mapping.rst
@@ -8,7 +8,7 @@ How to access I/O mapped memory from within device drivers
 
 	The virt_to_bus() and bus_to_virt() functions have been
 	superseded by the functionality provided by the PCI DMA interface
-	(see Documentation/DMA-API-HOWTO.txt).  They continue
+	(see :doc:`/core-api/dma-api-howto`).  They continue
 	to be documented below for historical purposes, but new code
 	must not use them. --davidm 00/12/12
 
diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 2d8d2fed7317..63b4a2f20867 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -5,7 +5,7 @@ Dynamic DMA mapping using the generic device
 :Author: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
 
 This document describes the DMA API.  For a more gentle introduction
-of the API (and actual examples), see Documentation/DMA-API-HOWTO.txt.
+of the API (and actual examples), see :doc:`/core-api/dma-api-howto`.
 
 This API is split into two pieces.  Part I describes the basic API.
 Part II describes extensions for supporting non-consistent memory
@@ -471,7 +471,7 @@ without the _attrs suffixes, except that they pass an optional
 dma_attrs.
 
 The interpretation of DMA attributes is architecture-specific, and
-each attribute should be documented in Documentation/DMA-attributes.txt.
+each attribute should be documented in :doc:`/core-api/dma-attributes`.
 
 If dma_attrs are 0, the semantics of each of these functions
 is identical to those of the corresponding function
@@ -484,7 +484,7 @@ for DMA::
 
 	#include <linux/dma-mapping.h>
 	/* DMA_ATTR_FOO should be defined in linux/dma-mapping.h and
-	* documented in Documentation/DMA-attributes.txt */
+	* documented in Documentation/core-api/dma-attributes.rst */
 	...
 
 		unsigned long attr;
diff --git a/Documentation/core-api/dma-isa-lpc.rst b/Documentation/core-api/dma-isa-lpc.rst
index b1ec7b16c21f..e59a3d35a93d 100644
--- a/Documentation/core-api/dma-isa-lpc.rst
+++ b/Documentation/core-api/dma-isa-lpc.rst
@@ -17,7 +17,7 @@ To do ISA style DMA you need to include two headers::
 	#include <asm/dma.h>
 
 The first is the generic DMA API used to convert virtual addresses to
-bus addresses (see Documentation/DMA-API.txt for details).
+bus addresses (see :doc:`/core-api/dma-api` for details).
 
 The second contains the routines specific to ISA DMA transfers. Since
 this is not present on all platforms make sure you construct your
diff --git a/Documentation/driver-api/usb/dma.rst b/Documentation/driver-api/usb/dma.rst
index 59d5aee89e37..2b3dbd3265b4 100644
--- a/Documentation/driver-api/usb/dma.rst
+++ b/Documentation/driver-api/usb/dma.rst
@@ -10,7 +10,7 @@ API overview
 
 The big picture is that USB drivers can continue to ignore most DMA issues,
 though they still must provide DMA-ready buffers (see
-``Documentation/DMA-API-HOWTO.txt``).  That's how they've worked through
+:doc:`/core-api/dma-api-howto`).  That's how they've worked through
 the 2.4 (and earlier) kernels, or they can now be DMA-aware.
 
 DMA-aware usb drivers:
@@ -60,7 +60,7 @@ and effects like cache-trashing can impose subtle penalties.
   force a consistent memory access ordering by using memory barriers.  It's
   not using a streaming DMA mapping, so it's good for small transfers on
   systems where the I/O would otherwise thrash an IOMMU mapping.  (See
-  ``Documentation/DMA-API-HOWTO.txt`` for definitions of "coherent" and
+  :doc:`/core-api/dma-api-howto` for definitions of "coherent" and
   "streaming" DMA mappings.)
 
   Asking for 1/Nth of a page (as well as asking for N pages) is reasonably
@@ -91,7 +91,7 @@ Working with existing buffers
 Existing buffers aren't usable for DMA without first being mapped into the
 DMA address space of the device.  However, most buffers passed to your
 driver can safely be used with such DMA mapping.  (See the first section
-of Documentation/DMA-API-HOWTO.txt, titled "What memory is DMA-able?")
+of :doc:`/core-api/dma-api-howto`, titled "What memory is DMA-able?")
 
 - When you're using scatterlists, you can map everything at once.  On some
   systems, this kicks in an IOMMU and turns the scatterlists into single
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index eaabc3134294..0e4947a8282d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -546,8 +546,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1932,7 +1932,7 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for more
      information on consistent memory.
 
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 34d041d68f78..604cee350e53 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -570,8 +570,8 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 데이터 의존성 배리어 (역사적)
@@ -1907,7 +1907,7 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 
      writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
-     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
+     위해선 Documentation/core-api/dma-api.rst 문서를 참고하세요.
 
 
 =========================
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index a806227c1fad..656a4888c300 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -907,7 +907,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
  * @dir: dma direction
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 			       unsigned long poff, size_t size,
@@ -1028,7 +1028,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 			   enum dma_data_direction dir, unsigned long attrs)
@@ -1105,7 +1105,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * @size:  number of bytes mapped in driver buffer.
  * @dma_handle:  IOVA of new buffer.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
@@ -1162,7 +1162,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
  * @vaddr:  virtual address IOVA of "consistent" buffer.
  * @dma_handler:  IO virtual address of "consistent" buffer.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
 			      dma_addr_t dma_handle, unsigned long attrs)
@@ -1425,7 +1425,7 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			    int nents, enum dma_data_direction dir,
@@ -1524,7 +1524,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 70cd24bdcfec..4f1596bb1936 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -3,7 +3,7 @@
 ** PARISC 1.1 Dynamic DMA mapping support.
 ** This implementation is for PA-RISC platforms that do not support
 ** I/O TLBs (aka DMA address translation hardware).
-** See Documentation/DMA-API-HOWTO.txt for interface definitions.
+** See Documentation/core-api/dma-api-howto.rst for interface definitions.
 **
 **      (c) Copyright 1999,2000 Hewlett-Packard Company
 **      (c) Copyright 2000 Grant Grundler
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 6b15a24930e0..fed67eafcacc 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -3,8 +3,8 @@
 #define _ASM_X86_DMA_MAPPING_H
 
 /*
- * IOMMU interface. See Documentation/DMA-API-HOWTO.txt and
- * Documentation/DMA-API.txt for documentation.
+ * IOMMU interface. See Documentation/core-api/dma-api-howto.rst and
+ * Documentation/core-api/dma-api.rst for documentation.
  */
 
 #include <linux/scatterlist.h>
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 17cb5b933dcf..e89031e9c847 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -6,7 +6,7 @@
  * This allows to use PCI devices that only support 32bit addresses on systems
  * with more than 4GB.
  *
- * See Documentation/DMA-API-HOWTO.txt for the interface specification.
+ * See Documentation/core-api/dma-api-howto.rst for the interface specification.
  *
  * Copyright 2002 Andi Kleen, SuSE Labs.
  */
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 7e112829d250..5368452eb5a6 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -666,7 +666,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
  * @dev: instance of PCI owned by the driver that's asking
  * @mask:  number of address bits this PCI device can handle
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static int sba_dma_supported( struct device *dev, u64 mask)
 {
@@ -698,7 +698,7 @@ static int sba_dma_supported( struct device *dev, u64 mask)
  * @size:  number of bytes to map in driver buffer.
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static dma_addr_t
 sba_map_single(struct device *dev, void *addr, size_t size,
@@ -788,7 +788,7 @@ sba_map_page(struct device *dev, struct page *page, unsigned long offset,
  * @size:  number of bytes mapped in driver buffer.
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void
 sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
@@ -867,7 +867,7 @@ sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * @size:  number of bytes mapped in driver buffer.
  * @dma_handle:  IOVA of new buffer.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
@@ -898,7 +898,7 @@ static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle
  * @vaddr:  virtual address IOVA of "consistent" buffer.
  * @dma_handler:  IO virtual address of "consistent" buffer.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void
 sba_free(struct device *hwdev, size_t size, void *vaddr,
@@ -933,7 +933,7 @@ int dump_run_sg = 0;
  * @nents:  number of entries in list
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static int
 sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
@@ -1017,7 +1017,7 @@ sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
  * @nents:  number of entries in list
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.txt
+ * See Documentation/core-api/dma-api-howto.rst
  */
 static void 
 sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 78f677cf45ab..ef2b153ddbd9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -14,7 +14,7 @@
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
- * of each attribute should be defined in Documentation/DMA-attributes.txt.
+ * of each attribute should be defined in Documentation/core-api/dma-attributes.rst.
  */
 
 /*
diff --git a/include/media/videobuf-dma-sg.h b/include/media/videobuf-dma-sg.h
index b89d5e31f172..34450f7ad510 100644
--- a/include/media/videobuf-dma-sg.h
+++ b/include/media/videobuf-dma-sg.h
@@ -31,7 +31,7 @@
  *	does memory allocation too using vmalloc_32().
  *
  * videobuf_dma_*()
- *	see Documentation/DMA-API-HOWTO.txt, these functions to
+ *	see Documentation/core-api/dma-api-howto.rst, these functions to
  *	basically the same.  The map function does also build a
  *	scatterlist for the buffer (and unmap frees it ...)
  *
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36c962a86bf2..f97f088ace7e 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1071,7 +1071,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	/*
 	 * Drivers should use dma_mapping_error() to check the returned
 	 * addresses of dma_map_single() and dma_map_page().
-	 * If not, print this warning message. See Documentation/DMA-API.txt.
+	 * If not, print this warning message. See Documentation/core-api/dma-api.rst.
 	 */
 	if (entry->map_err_type == MAP_ERR_NOT_CHECKED) {
 		err_printk(ref->dev, entry,
-- 
2.26.2

