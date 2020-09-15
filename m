Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D826A239
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIOJcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 05:32:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgIOJcS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 05:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E8F11B3;
        Tue, 15 Sep 2020 02:32:17 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.14.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26FB3F68F;
        Tue, 15 Sep 2020 02:32:15 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        George Cherian <george.cherian@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/2] asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap() implementation
Date:   Tue, 15 Sep 2020 10:32:03 +0100
Message-Id: <20200915093203.16934-3-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For arches that do not select CONFIG_GENERIC_IOMAP, the current
pci_iounmap() function does nothing causing obvious memory leaks
for mapped regions that are backed by MMIO physical space.

In order to detect if a mapped pointer is IO vs MMIO, a check must made
available to the pci_iounmap() function so that it can actually detect
whether the pointer has to be unmapped.

In configurations where CONFIG_HAS_IOPORT_MAP && !CONFIG_GENERIC_IOMAP,
a mapped port is detected using an ioport_map() stub defined in
asm-generic/io.h.

Use the same logic to implement a stub (ie __pci_ioport_unmap()) that
detects if the passed in pointer in pci_iounmap() is IO vs MMIO to
iounmap conditionally and call it in pci_iounmap() fixing the issue.

Leave __pci_ioport_unmap() as a NOP for all other config options.

Reported-by: George Cherian <george.cherian@marvell.com>
Link: https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
Link: https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: George Cherian <george.cherian@marvell.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
---
 include/asm-generic/io.h | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index dabf8cb7203b..9ea83d80eb6f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -911,18 +911,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 #include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
-#ifndef CONFIG_GENERIC_IOMAP
-struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
-
-#ifndef pci_iounmap
-#define pci_iounmap pci_iounmap
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
-{
-}
-#endif
-#endif /* CONFIG_GENERIC_IOMAP */
-
 /*
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
@@ -1016,6 +1004,16 @@ static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 	port &= IO_SPACE_LIMIT;
 	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
 }
+#define __pci_ioport_unmap __pci_ioport_unmap
+static inline void __pci_ioport_unmap(void __iomem *p)
+{
+	uintptr_t start = (uintptr_t) PCI_IOBASE;
+	uintptr_t addr = (uintptr_t) p;
+
+	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+		return;
+	iounmap(p);
+}
 #endif
 
 #ifndef ioport_unmap
@@ -1030,6 +1028,23 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
+#ifndef CONFIG_GENERIC_IOMAP
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+
+#ifndef __pci_ioport_unmap
+static inline void __pci_ioport_unmap(void __iomem *p) {}
+#endif
+
+#ifndef pci_iounmap
+#define pci_iounmap pci_iounmap
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+{
+	__pci_ioport_unmap(p);
+}
+#endif
+#endif /* CONFIG_GENERIC_IOMAP */
+
 /*
  * Convert a virtual cached pointer to an uncached pointer
  */
-- 
2.26.1

