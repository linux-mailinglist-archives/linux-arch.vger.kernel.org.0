Return-Path: <linux-arch+bounces-10887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A515A62B8A
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5534019C0639
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12401FBEAB;
	Sat, 15 Mar 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUVpQhYu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D61F8736;
	Sat, 15 Mar 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036383; cv=none; b=ACj1C+Qb5MQsDLzRwSmbsXLN5iM45ZzBJEMpRBj4a/RymGIxYaPOGVnoZ3z1zJQKPch4CpplqU2qlJSbuBwLbAC/hzS/tQsrogZ6K/h/3TFo43Ep1kYjV9NOFm5Tcr6ah08vwPsSAJiKSW4+qrXwh3zjUByCJ4aXrpgw1oTLmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036383; c=relaxed/simple;
	bh=Ocgkmwh32rBMKgy+zdGqEw65Xp0hQcjH99SnZLPTggw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcJtRwbolp+g6onnbd46ph6ort0ZV65J+yvcCsdWGsVos+CrmBlNaSHzz82C6fBiW7G1biDM5rkFCMSeT9OiAfKYKLOHqKwbfjOjliWJs36yzOADmjKxtO9xNV8KfFKnJkHWfA2ephvoKl/sntw/Z4qbXUdKWMbFnlGr1GOKDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUVpQhYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30993C4CEEE;
	Sat, 15 Mar 2025 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036382;
	bh=Ocgkmwh32rBMKgy+zdGqEw65Xp0hQcjH99SnZLPTggw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUVpQhYuj8R5lbEwOh0aZKM4Y8Acv7xnv2sqN2YDbmHsBGQIRnSAadSmccWuUhLGT
	 B2zQQZNue12j7UVtiRIi3lBxv1XbGOrom+jZtkUzpJ2+deEiBODnn7W3QWKla3ceU1
	 GYV2/Na069BoOyrGstiOuC3wdYv0xUlIrPMg4kxEmnsRbUgLtVYe48rag7mxP2M5eB
	 axYdBBMZ0oVU9NtoXi+62zLwYFuKGxqZImpznW8I8d5jaTR1tEElytVzvke4ayUNlA
	 9dx74E971/xKPOLa+6rI3klRMrHQPi5ClKFesOM0BwTJhHjvhdSfgE8FtssAe++72I
	 tgEKi0ZB6SDtQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 5/6] mips: drop GENERIC_IOMAP wrapper
Date: Sat, 15 Mar 2025 11:59:06 +0100
Message-Id: <20250315105907.1275012-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250315105907.1275012-1-arnd@kernel.org>
References: <20250315105907.1275012-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All PIO on MIPS platforms is memory mapped, so there is no benefit in
the lib/iomap.c wrappers that switch between inb/outb and readb/writeb
style accessses.

In fact, the '#define PIO_RESERVED 0' setting completely disables
the GENERIC_IOMAP functionality, and the '#define PIO_OFFSET
mips_io_port_base' setting is based on a misunderstanding of what the
offset is meant to do.

MIPS started using GENERIC_IOMAP in 2018 with commit b962aeb02205 ("MIPS:
Use GENERIC_IOMAP") replacing a simple custom implementation of the same
interfaces, but at the time the asm-generic/io.h version was not usable
yet. Since the header is now always included, it's now possible to go
back to the even simpler version.

Use the normal GENERIC_PCI_IOMAP functionality for all mips platforms
without the hacky GENERIC_IOMAP, and provide a custom pci_iounmap()
for the CONFIG_PCI_DRIVERS_LEGACY case to ensure the I/O port base never
gets unmapped.

The readsl() prototype needs an extra 'const' keyword to make it
compatible with the generic ioread32_rep() alias.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/Kconfig          |  2 +-
 arch/mips/include/asm/io.h | 21 ++++++++-------------
 arch/mips/lib/iomap-pci.c  |  9 +++++++++
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1924f2d83932..2a2120a6d852 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -38,7 +38,6 @@ config MIPS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_ISA_DMA if EISA
@@ -47,6 +46,7 @@ config MIPS
 	select GENERIC_LIB_CMPDI2
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0bddb568af7c..1fe56d1870a6 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -66,17 +66,6 @@ static inline void set_io_port_base(unsigned long base)
 	mips_io_port_base = base;
 }
 
-/*
- * Provide the necessary definitions for generic iomap. We make use of
- * mips_io_port_base for iomap(), but we don't reserve any low addresses for
- * use with I/O ports.
- */
-
-#define HAVE_ARCH_PIO_SIZE
-#define PIO_OFFSET	mips_io_port_base
-#define PIO_MASK	IO_SPACE_LIMIT
-#define PIO_RESERVED	0x0UL
-
 /*
  * Enforce in-order execution of data I/O.  In the MIPS architecture
  * these are equivalent to corresponding platform-specific memory
@@ -397,8 +386,8 @@ static inline void writes##bwlq(volatile void __iomem *mem,		\
 	}								\
 }									\
 									\
-static inline void reads##bwlq(volatile void __iomem *mem, void *addr,	\
-			       unsigned int count)			\
+static inline void reads##bwlq(const volatile void __iomem *mem,	\
+			       void *addr, unsigned int count)		\
 {									\
 	volatile type *__addr = addr;					\
 									\
@@ -555,6 +544,12 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
+#ifdef CONFIG_PCI_DRIVERS_LEGACY
+struct pci_dev;
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
+#define pci_iounmap pci_iounmap
+#endif
+
 #include <asm-generic/io.h>
 
 static inline void *isa_bus_to_virt(unsigned long address)
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index a9cb28813f0b..2f82c776c6d0 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -43,4 +43,13 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
 	return (void __iomem *) (ctrl->io_map_base + port);
 }
 
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	struct pci_controller *ctrl = dev->bus->sysdata;
+	void __iomem *base = (void __iomem *)ctrl->io_map_base;
+
+	if (addr < base || addr > (base + resource_size(ctrl->io_resource)))
+		iounmap(addr);
+}
+
 #endif /* CONFIG_PCI_DRIVERS_LEGACY */
-- 
2.39.5


