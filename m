Return-Path: <linux-arch+bounces-5582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE5939B06
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27B41F22956
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704214E2C4;
	Tue, 23 Jul 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgAoC+Hc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CC14A609;
	Tue, 23 Jul 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717217; cv=none; b=OUG/IEiAY9P1P5K4uuIAd38QGEZNu+YA+BH40kEvEbb70eppTGOfG9jkYFHbbtBBd4VbhglS1K3iZA6/HQsw/9JmExc1eK3SwNLgT91ZWsBJgNVk5275CT0TuuHHLvWhosSAvhUCsxUKGgVypOmS+j21Qqf3nZAJp4JwcdULP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717217; c=relaxed/simple;
	bh=emeCYa9405g7/z24yhBWS68KWW8+Lb3s/YOK8bOaThI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X39zL+ML5ZNo+iunUSlEywlE8HkFpQPaTX/lZy2tRn4cwkXUIwj1ViENWAgNnCO2TPlcRc5lkEM7tm33RrBtCZmU9CAyz28RbFq7b8GmUQ9tI+XEhbYfD1EBXpUPLU/n5zNV0w1zcOfKJxxAQnXUTPgZy/HpIRJ2aUtumcGCQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgAoC+Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFFDC4AF12;
	Tue, 23 Jul 2024 06:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717217;
	bh=emeCYa9405g7/z24yhBWS68KWW8+Lb3s/YOK8bOaThI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgAoC+Hcal9bWK9k7ho6yBYf06kymWVllDUMPiOaeuFSG/wojxIxKcWyED4DoWkCl
	 ZyPnLzk1UZksRbBGs+vwS6J3QRkp5NCWUyBtV2hPxbzh2xDsZ8HA+/i+k9yezOal8u
	 zhjJSmaqAV92XU7hpKX6nY/kRVxDgU4f5bxdcxuLSfaiLoEIwLORtA6VE/d1oMTTUm
	 Pqc1pcChaNRo/+GbV4+lfx2+t+YfKTxY+qn5wYaSZxtCRIZx8059ZX38rWfyX1IoPG
	 OdZJdrg7fImaUDMXuKWgBftxFVlRAZKp9u8sSnRW4s39ogVzgJG0rOPKH30S5pFCFo
	 G7ZwK7pI1cKjg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 24/25] mm: make range-to-target_node lookup facility a part of numa_memblks
Date: Tue, 23 Jul 2024 09:41:55 +0300
Message-ID: <20240723064156.4009477-25-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The x86 implementation of range-to-target_node lookup (i.e.
phys_to_target_node() and memory_add_physaddr_to_nid()) relies on
numa_memblks.

Since numa_memblks are now part of the generic code, move these
functions from x86 to mm/numa_memblks.c and select
CONFIG_NUMA_KEEP_MEMINFO when CONFIG_NUMA_MEMBLKS=y for dax and cxl.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/include/asm/sparsemem.h |  9 --------
 arch/x86/mm/numa.c               | 38 --------------------------------
 drivers/cxl/Kconfig              |  2 +-
 drivers/dax/Kconfig              |  2 +-
 include/linux/numa_memblks.h     |  7 ++++++
 mm/numa.c                        |  1 +
 mm/numa_memblks.c                | 38 ++++++++++++++++++++++++++++++++
 7 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 64df897c0ee3..3918c7a434f5 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -31,13 +31,4 @@
 
 #endif /* CONFIG_SPARSEMEM */
 
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_NUMA_KEEP_MEMINFO
-extern int phys_to_target_node(phys_addr_t start);
-#define phys_to_target_node phys_to_target_node
-extern int memory_add_physaddr_to_nid(u64 start);
-#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-#endif
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 16bc703c9272..8e790528805e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -449,41 +449,3 @@ u64 __init numa_emu_dma_end(void)
 	return PFN_PHYS(MAX_DMA32_PFN);
 }
 #endif /* CONFIG_NUMA_EMU */
-
-#ifdef CONFIG_NUMA_KEEP_MEMINFO
-static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
-{
-	int i;
-
-	for (i = 0; i < mi->nr_blks; i++)
-		if (mi->blk[i].start <= start && mi->blk[i].end > start)
-			return mi->blk[i].nid;
-	return NUMA_NO_NODE;
-}
-
-int phys_to_target_node(phys_addr_t start)
-{
-	int nid = meminfo_to_nid(&numa_meminfo, start);
-
-	/*
-	 * Prefer online nodes, but if reserved memory might be
-	 * hot-added continue the search with reserved ranges.
-	 */
-	if (nid != NUMA_NO_NODE)
-		return nid;
-
-	return meminfo_to_nid(&numa_reserved_meminfo, start);
-}
-EXPORT_SYMBOL_GPL(phys_to_target_node);
-
-int memory_add_physaddr_to_nid(u64 start)
-{
-	int nid = meminfo_to_nid(&numa_meminfo, start);
-
-	if (nid == NUMA_NO_NODE)
-		nid = numa_meminfo.blk[0].nid;
-	return nid;
-}
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-
-#endif
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 99b5c25be079..29c192f20082 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,7 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
-	select NUMA_KEEP_MEMINFO if (NUMA && X86)
+	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a88744244149..d656e4c0eb84 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -30,7 +30,7 @@ config DEV_DAX_PMEM
 config DEV_DAX_HMEM
 	tristate "HMEM DAX: direct access to 'specific purpose' memory"
 	depends on EFI_SOFT_RESERVE
-	select NUMA_KEEP_MEMINFO if (NUMA && X86)
+	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	default DEV_DAX
 	help
 	  EFI 2.8 platforms, and others, may advertise 'specific purpose'
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index 5c6e12ad0b7a..17d4bcc34091 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -46,6 +46,13 @@ static inline int numa_emu_cmdline(char *str)
 }
 #endif /* CONFIG_NUMA_EMU */
 
+#ifdef CONFIG_NUMA_KEEP_MEMINFO
+extern int phys_to_target_node(phys_addr_t start);
+#define phys_to_target_node phys_to_target_node
+extern int memory_add_physaddr_to_nid(u64 start);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif /* CONFIG_NUMA_KEEP_MEMINFO */
+
 #endif /* CONFIG_NUMA_MEMBLKS */
 
 #endif	/* __NUMA_MEMBLKS_H */
diff --git a/mm/numa.c b/mm/numa.c
index 67a0d7734a98..da27eb151dc5 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -3,6 +3,7 @@
 #include <linux/memblock.h>
 #include <linux/printk.h>
 #include <linux/numa.h>
+#include <linux/numa_memblks.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index e4358ad92233..8609c6eb3998 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -528,3 +528,41 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
+
+#ifdef CONFIG_NUMA_KEEP_MEMINFO
+static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
+{
+	int i;
+
+	for (i = 0; i < mi->nr_blks; i++)
+		if (mi->blk[i].start <= start && mi->blk[i].end > start)
+			return mi->blk[i].nid;
+	return NUMA_NO_NODE;
+}
+
+int phys_to_target_node(phys_addr_t start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	/*
+	 * Prefer online nodes, but if reserved memory might be
+	 * hot-added continue the search with reserved ranges.
+	 */
+	if (nid != NUMA_NO_NODE)
+		return nid;
+
+	return meminfo_to_nid(&numa_reserved_meminfo, start);
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
+
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int nid = meminfo_to_nid(&numa_meminfo, start);
+
+	if (nid == NUMA_NO_NODE)
+		nid = numa_meminfo.blk[0].nid;
+	return nid;
+}
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+#endif /* CONFIG_NUMA_KEEP_MEMINFO */
-- 
2.43.0


