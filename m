Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC154AD02
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfFRVHt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 17:07:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfFRVFx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jun 2019 17:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LlVQ5AgDnGeVreoNQv5wQOL6WOl9jGIbq69M3UI1xTA=; b=ZaZuy9l6/Ggb2QQVZs1T38/Jiv
        CtntnfPNCLjMC3OvceIzJ9DrBsVXwc1XE3p+C/np1rrU265Okcg/ne/X4p46hD/Jw/rYeNgBZ73Pa
        ZIm/HbtFDoz1x6v3K2O4lo9zWrgczxl+dfRqTlvVf1VQIAz9l0y13RhVE/itGt+mB0z6hwntGy0FK
        4NaIs1AlYQBCaWq9AtnGuFQc13k05oXiA9XddnRY42yEI8HuzANN6Pr8nCZIyTYhskzt5T4BWiDjR
        CJCl2jQqimjNcJw1sbb35YKu4vF9XR32EMe5h3gsCQFLhZae58cWzJJoHMhP/ayEmHRKAKSAc9+0E
        cyJQTmEQ==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006zA-J3; Tue, 18 Jun 2019 21:05:51 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002Cp-1p; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v1 15/22] docs: driver-api: add a chapter for memory-related API
Date:   Tue, 18 Jun 2019 18:05:39 -0300
Message-Id: <5a67bbb44d92b4fb07e3eef5b291608524f72ff3.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are some DMA files under the main dir. Move them to the
new chapter and add an index file for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/pci.rst                        |  6 +++---
 Documentation/block/biodoc.rst                   |  2 +-
 .../driver-api/bus-virt-phys-mapping.rst         |  2 +-
 Documentation/driver-api/index.rst               |  2 ++
 .../mm/dma-api-howto.rst}                        |  2 --
 .../{DMA-API.rst => driver-api/mm/dma-api.rst}   |  8 +++-----
 .../mm/dma-attributes.rst}                       |  2 --
 .../mm/dma-isa-lpc.rst}                          |  4 +---
 Documentation/driver-api/mm/index.rst            | 11 +++++++++++
 Documentation/driver-api/usb/dma.rst             |  6 +++---
 Documentation/memory-barriers.txt                |  6 +++---
 .../translations/ko_KR/memory-barriers.txt       |  6 +++---
 arch/ia64/hp/common/sba_iommu.c                  | 12 ++++++------
 arch/ia64/sn/pci/pci_dma.c                       |  4 ++--
 arch/parisc/kernel/pci-dma.c                     |  2 +-
 arch/x86/include/asm/dma-mapping.h               |  4 ++--
 arch/x86/kernel/amd_gart_64.c                    |  2 +-
 drivers/parisc/sba_iommu.c                       | 16 ++++++++--------
 include/linux/dma-mapping.h                      |  2 +-
 include/media/videobuf-dma-sg.h                  |  2 +-
 kernel/dma/debug.c                               |  2 +-
 21 files changed, 54 insertions(+), 49 deletions(-)
 rename Documentation/{DMA-API-HOWTO.rst => driver-api/mm/dma-api-howto.rst} (99%)
 rename Documentation/{DMA-API.rst => driver-api/mm/dma-api.rst} (99%)
 rename Documentation/{DMA-attributes.rst => driver-api/mm/dma-attributes.rst} (99%)
 rename Documentation/{DMA-ISA-LPC.rst => driver-api/mm/dma-isa-lpc.rst} (98%)
 create mode 100644 Documentation/driver-api/mm/index.rst

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 0f52d172c9ac..8665209eda40 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -265,7 +265,7 @@ Set the DMA mask size
 ---------------------
 .. note::
    If anything below doesn't make sense, please refer to
-   Documentation/DMA-API.rst. This section is just a reminder that
+   Documentation/driver-api/mm/dma-api.rst. This section is just a reminder that
    drivers need to indicate DMA capabilities of the device and is not
    an authoritative source for DMA interfaces.
 
@@ -291,7 +291,7 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 Setup shared control data
 -------------------------
 Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
-memory.  See Documentation/DMA-API.rst for a full description of
+memory.  See Documentation/driver-api/mm/dma-api.rst for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
 
@@ -421,7 +421,7 @@ owners if there is one.
 
 Then clean up "consistent" buffers which contain the control data.
 
-See Documentation/DMA-API.rst for details on unmapping interfaces.
+See Documentation/driver-api/mm/dma-api.rst for details on unmapping interfaces.
 
 
 Unregister from other subsystems
diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
index 59bd93bec8fc..2206c88e7dee 100644
--- a/Documentation/block/biodoc.rst
+++ b/Documentation/block/biodoc.rst
@@ -195,7 +195,7 @@ a virtual address mapping (unlike the earlier scheme of virtual address
 do not have a corresponding kernel virtual address space mapping) and
 low-memory pages.
 
-Note: Please refer to Documentation/DMA-API-HOWTO.rst for a discussion
+Note: Please refer to Documentation/driver-api/mm/dma-api-howto.rst for a discussion
 on PCI high mem DMA aspects and mapping of scatter gather lists, and support
 for 64 bit PCI.
 
diff --git a/Documentation/driver-api/bus-virt-phys-mapping.rst b/Documentation/driver-api/bus-virt-phys-mapping.rst
index 80972916e88c..18b6fdf618d2 100644
--- a/Documentation/driver-api/bus-virt-phys-mapping.rst
+++ b/Documentation/driver-api/bus-virt-phys-mapping.rst
@@ -8,7 +8,7 @@ How to access I/O mapped memory from within device drivers
 
 	The virt_to_bus() and bus_to_virt() functions have been
 	superseded by the functionality provided by the PCI DMA interface
-	(see Documentation/DMA-API-HOWTO.rst).  They continue
+	(see Documentation/driver-api/mm/dma-api-howto.rst).  They continue
 	to be documented below for historical purposes, but new code
 	must not use them. --davidm 00/12/12
 
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index bb2621b17212..492b96003af2 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -16,6 +16,7 @@ available subsections can be seen below.
 
    basics
    infrastructure
+   mm/index
    pm/index
    clk
    device-io
@@ -59,6 +60,7 @@ available subsections can be seen below.
    fpga/index
    acpi/index
    generic-counter
+   mm/index
 
    atomic_bitops
    bt8xxgpio
diff --git a/Documentation/DMA-API-HOWTO.rst b/Documentation/driver-api/mm/dma-api-howto.rst
similarity index 99%
rename from Documentation/DMA-API-HOWTO.rst
rename to Documentation/driver-api/mm/dma-api-howto.rst
index db9f8fcebe1f..358d495456d1 100644
--- a/Documentation/DMA-API-HOWTO.rst
+++ b/Documentation/driver-api/mm/dma-api-howto.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =========================
 Dynamic DMA mapping Guide
 =========================
diff --git a/Documentation/DMA-API.rst b/Documentation/driver-api/mm/dma-api.rst
similarity index 99%
rename from Documentation/DMA-API.rst
rename to Documentation/driver-api/mm/dma-api.rst
index 2f26857f97ff..c2c4d0b456b1 100644
--- a/Documentation/DMA-API.rst
+++ b/Documentation/driver-api/mm/dma-api.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ============================================
 Dynamic DMA mapping using the generic device
 ============================================
@@ -7,7 +5,7 @@ Dynamic DMA mapping using the generic device
 :Author: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
 
 This document describes the DMA API.  For a more gentle introduction
-of the API (and actual examples), see Documentation/DMA-API-HOWTO.rst.
+of the API (and actual examples), see Documentation/driver-api/mm/dma-api-howto.rst.
 
 This API is split into two pieces.  Part I describes the basic API.
 Part II describes extensions for supporting non-consistent memory
@@ -465,7 +463,7 @@ without the _attrs suffixes, except that they pass an optional
 dma_attrs.
 
 The interpretation of DMA attributes is architecture-specific, and
-each attribute should be documented in Documentation/DMA-attributes.rst.
+each attribute should be documented in Documentation/driver-api/mm/dma-attributes.rst.
 
 If dma_attrs are 0, the semantics of each of these functions
 is identical to those of the corresponding function
@@ -478,7 +476,7 @@ for DMA::
 
 	#include <linux/dma-mapping.h>
 	/* DMA_ATTR_FOO should be defined in linux/dma-mapping.h and
-	* documented in Documentation/DMA-attributes.rst */
+	* documented in Documentation/driver-api/mm/dma-attributes.rst */
 	...
 
 		unsigned long attr;
diff --git a/Documentation/DMA-attributes.rst b/Documentation/driver-api/mm/dma-attributes.rst
similarity index 99%
rename from Documentation/DMA-attributes.rst
rename to Documentation/driver-api/mm/dma-attributes.rst
index 471c5c38f9d9..8f8d97f65d73 100644
--- a/Documentation/DMA-attributes.rst
+++ b/Documentation/driver-api/mm/dma-attributes.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==============
 DMA attributes
 ==============
diff --git a/Documentation/DMA-ISA-LPC.rst b/Documentation/driver-api/mm/dma-isa-lpc.rst
similarity index 98%
rename from Documentation/DMA-ISA-LPC.rst
rename to Documentation/driver-api/mm/dma-isa-lpc.rst
index 205a379c2d62..6ae393d391cf 100644
--- a/Documentation/DMA-ISA-LPC.rst
+++ b/Documentation/driver-api/mm/dma-isa-lpc.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ============================
 DMA with ISA and LPC devices
 ============================
@@ -19,7 +17,7 @@ To do ISA style DMA you need to include two headers::
 	#include <asm/dma.h>
 
 The first is the generic DMA API used to convert virtual addresses to
-bus addresses (see Documentation/DMA-API.rst for details).
+bus addresses (see Documentation/driver-api/mm/dma-api.rst for details).
 
 The second contains the routines specific to ISA DMA transfers. Since
 this is not present on all platforms make sure you construct your
diff --git a/Documentation/driver-api/mm/index.rst b/Documentation/driver-api/mm/index.rst
new file mode 100644
index 000000000000..e34c7ee4a4b9
--- /dev/null
+++ b/Documentation/driver-api/mm/index.rst
@@ -0,0 +1,11 @@
+==========================
+Memory Related Kernel APIs
+==========================
+
+.. toctree::
+   :maxdepth: 1
+
+   dma-api
+   dma-api-howto
+   dma-attributes
+   dma-isa-lpc
diff --git a/Documentation/driver-api/usb/dma.rst b/Documentation/driver-api/usb/dma.rst
index 12955a77c7fe..8ef36aa2278d 100644
--- a/Documentation/driver-api/usb/dma.rst
+++ b/Documentation/driver-api/usb/dma.rst
@@ -10,7 +10,7 @@ API overview
 
 The big picture is that USB drivers can continue to ignore most DMA issues,
 though they still must provide DMA-ready buffers (see
-``Documentation/DMA-API-HOWTO.rst``).  That's how they've worked through
+``Documentation/driver-api/mm/dma-api-howto.rst``).  That's how they've worked through
 the 2.4 (and earlier) kernels, or they can now be DMA-aware.
 
 DMA-aware usb drivers:
@@ -60,7 +60,7 @@ and effects like cache-trashing can impose subtle penalties.
   force a consistent memory access ordering by using memory barriers.  It's
   not using a streaming DMA mapping, so it's good for small transfers on
   systems where the I/O would otherwise thrash an IOMMU mapping.  (See
-  ``Documentation/DMA-API-HOWTO.rst`` for definitions of "coherent" and
+  ``Documentation/driver-api/mm/dma-api-howto.rst`` for definitions of "coherent" and
   "streaming" DMA mappings.)
 
   Asking for 1/Nth of a page (as well as asking for N pages) is reasonably
@@ -91,7 +91,7 @@ Working with existing buffers
 Existing buffers aren't usable for DMA without first being mapped into the
 DMA address space of the device.  However, most buffers passed to your
 driver can safely be used with such DMA mapping.  (See the first section
-of Documentation/DMA-API-HOWTO.rst, titled "What memory is DMA-able?")
+of Documentation/driver-api/mm/dma-api-howto.rst, titled "What memory is DMA-able?")
 
 - When you're using scatterlists, you can map everything at once.  On some
   systems, this kicks in an IOMMU and turns the scatterlists into single
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 4a44f00478db..087b0d864a94 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -549,8 +549,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/PCI/pci.rst
-	    Documentation/DMA-API-HOWTO.rst
-	    Documentation/DMA-API.rst
+	    Documentation/driver-api/mm/dma-api-howto.rst
+	    Documentation/driver-api/mm/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1933,7 +1933,7 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.rst file for more
+     relaxed I/O accessors and the Documentation/driver-api/mm/dma-api.rst file for more
      information on consistent memory.
 
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 03c06a7800c3..7b86ac9f15d2 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -570,8 +570,8 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
 
 	    Documentation/PCI/pci.rst
-	    Documentation/DMA-API-HOWTO.rst
-	    Documentation/DMA-API.rst
+	    Documentation/driver-api/mm/dma-api-howto.rst
+	    Documentation/driver-api/mm/dma-api.rst
 
 
 데이터 의존성 배리어 (역사적)
@@ -1904,7 +1904,7 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 
      writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
-     위해선 Documentation/DMA-API.rst 문서를 참고하세요.
+     위해선 Documentation/driver-api/mm/dma-api.rst 문서를 참고하세요.
 
 
 MMIO 쓰기 배리어
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 8f97d42316e8..0b0b5084e6c8 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -912,7 +912,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
  * @dir: dma direction
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 			       unsigned long poff, size_t size,
@@ -1033,7 +1033,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 			   enum dma_data_direction dir, unsigned long attrs)
@@ -1110,7 +1110,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * @size:  number of bytes mapped in driver buffer.
  * @dma_handle:  IOVA of new buffer.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
@@ -1167,7 +1167,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
  * @vaddr:  virtual address IOVA of "consistent" buffer.
  * @dma_handler:  IO virtual address of "consistent" buffer.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
 			      dma_addr_t dma_handle, unsigned long attrs)
@@ -1430,7 +1430,7 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			    int nents, enum dma_data_direction dir,
@@ -1529,7 +1529,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
  * @dir:  R/W or both.
  * @attrs: optional dma attributes
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction dir,
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index f475fccea152..a06ae52117f0 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2000,2002-2005 Silicon Graphics, Inc. All rights reserved.
  *
- * Routines for PCI DMA mapping.  See Documentation/DMA-API.rst for
+ * Routines for PCI DMA mapping.  See Documentation/driver-api/mm/dma-api.rst for
  * a description of how these routines should be used.
  */
 
@@ -72,7 +72,7 @@ EXPORT_SYMBOL(sn_dma_set_mask);
  * that @dma_handle will have the %PCIIO_DMA_CMD flag set.
  *
  * This interface is usually used for "command" streams (e.g. the command
- * queue for a SCSI controller).  See Documentation/DMA-API.rst for
+ * queue for a SCSI controller).  See Documentation/driver-api/mm/dma-api.rst for
  * more information.
  */
 static void *sn_dma_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 2bb63062f6c3..08e7ff08fa94 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -3,7 +3,7 @@
 ** PARISC 1.1 Dynamic DMA mapping support.
 ** This implementation is for PA-RISC platforms that do not support
 ** I/O TLBs (aka DMA address translation hardware).
-** See Documentation/DMA-API-HOWTO.rst for interface definitions.
+** See Documentation/driver-api/mm/dma-api-howto.rst for interface definitions.
 **
 **      (c) Copyright 1999,2000 Hewlett-Packard Company
 **      (c) Copyright 2000 Grant Grundler
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index dfa443fe17c2..ff9ff85529fc 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -3,8 +3,8 @@
 #define _ASM_X86_DMA_MAPPING_H
 
 /*
- * IOMMU interface. See Documentation/DMA-API-HOWTO.rst and
- * Documentation/DMA-API.rst for documentation.
+ * IOMMU interface. See Documentation/driver-api/mm/dma-api-howto.rst and
+ * Documentation/driver-api/mm/dma-api.rst for documentation.
  */
 
 #include <linux/scatterlist.h>
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 03108de30105..397c2cdd19d8 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -6,7 +6,7 @@
  * This allows to use PCI devices that only support 32bit addresses on systems
  * with more than 4GB.
  *
- * See Documentation/DMA-API-HOWTO.rst for the interface specification.
+ * See Documentation/driver-api/mm/dma-api-howto.rst for the interface specification.
  *
  * Copyright 2002 Andi Kleen, SuSE Labs.
  */
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 267ceb5f7838..349b4a2f21a1 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -666,7 +666,7 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
  * @dev: instance of PCI owned by the driver that's asking
  * @mask:  number of address bits this PCI device can handle
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static int sba_dma_supported( struct device *dev, u64 mask)
 {
@@ -678,7 +678,7 @@ static int sba_dma_supported( struct device *dev, u64 mask)
 		return(0);
 	}
 
-	/* Documentation/DMA-API-HOWTO.rst tells drivers to try 64-bit
+	/* Documentation/driver-api/mm/dma-api-howto.rst tells drivers to try 64-bit
 	 * first, then fall back to 32-bit if that fails.
 	 * We are just "encouraging" 32-bit DMA masks here since we can
 	 * never allow IOMMU bypass unless we add special support for ZX1.
@@ -706,7 +706,7 @@ static int sba_dma_supported( struct device *dev, u64 mask)
  * @size:  number of bytes to map in driver buffer.
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static dma_addr_t
 sba_map_single(struct device *dev, void *addr, size_t size,
@@ -796,7 +796,7 @@ sba_map_page(struct device *dev, struct page *page, unsigned long offset,
  * @size:  number of bytes mapped in driver buffer.
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void
 sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
@@ -875,7 +875,7 @@ sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * @size:  number of bytes mapped in driver buffer.
  * @dma_handle:  IOVA of new buffer.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
@@ -906,7 +906,7 @@ static void *sba_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle
  * @vaddr:  virtual address IOVA of "consistent" buffer.
  * @dma_handler:  IO virtual address of "consistent" buffer.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void
 sba_free(struct device *hwdev, size_t size, void *vaddr,
@@ -941,7 +941,7 @@ int dump_run_sg = 0;
  * @nents:  number of entries in list
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static int
 sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
@@ -1025,7 +1025,7 @@ sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
  * @nents:  number of entries in list
  * @direction:  R/W or both.
  *
- * See Documentation/DMA-API-HOWTO.rst
+ * See Documentation/driver-api/mm/dma-api-howto.rst
  */
 static void 
 sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7ff3fcd73cec..eb234c3f466b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -14,7 +14,7 @@
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
- * of each attribute should be defined in Documentation/DMA-attributes.rst.
+ * of each attribute should be defined in Documentation/driver-api/mm/dma-attributes.rst.
  *
  * DMA_ATTR_WRITE_BARRIER: DMA to a memory region with this attribute
  * forces all pending DMA writes to complete.
diff --git a/include/media/videobuf-dma-sg.h b/include/media/videobuf-dma-sg.h
index 50a549e5b477..60f2df32bf39 100644
--- a/include/media/videobuf-dma-sg.h
+++ b/include/media/videobuf-dma-sg.h
@@ -34,7 +34,7 @@
  *	does memory allocation too using vmalloc_32().
  *
  * videobuf_dma_*()
- *	see Documentation/DMA-API-HOWTO.rst, these functions to
+ *	see Documentation/driver-api/mm/dma-api-howto.rst, these functions to
  *	basically the same.  The map function does also build a
  *	scatterlist for the buffer (and unmap frees it ...)
  *
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 616919c774a5..1d3f9b8de6df 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1069,7 +1069,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	/*
 	 * Drivers should use dma_mapping_error() to check the returned
 	 * addresses of dma_map_single() and dma_map_page().
-	 * If not, print this warning message. See Documentation/DMA-API.rst.
+	 * If not, print this warning message. See Documentation/driver-api/mm/dma-api.rst.
 	 */
 	if (entry->map_err_type == MAP_ERR_NOT_CHECKED) {
 		err_printk(ref->dev, entry,
-- 
2.21.0

