Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32B53527F4
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhDBJGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:06:49 -0400
Received: from marcansoft.com ([212.63.210.85]:34460 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJGr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:06:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D634F4272F;
        Fri,  2 Apr 2021 09:06:37 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/18] asm-generic/io.h:  Add a non-posted variant of ioremap()
Date:   Fri,  2 Apr 2021 18:05:31 +0900
Message-Id: <20210402090542.131194-8-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM64 currently defaults to posted MMIO (nGnRE), but some devices
require the use of non-posted MMIO (nGnRnE). Introduce a new ioremap()
variant to handle this case. ioremap_np() returns NULL on arches that
do not implement this variant.

sparc64 is the only architecture that needs to be touched directly,
because it includes neither of the generic io.h or iomap.h headers.

This adds the IORESOURCE_MEM_NONPOSTED flag, which maps to this
variant and marks a given resource as requiring non-posted mappings.
This is implemented in the resource system because it is a SoC-level
requirement, so existing drivers do not need special-case code to pick
this ioremap variant.

Then this is implemented in devres by introducing devm_ioremap_np(),
and making devm_ioremap_resource() automatically select this variant
when the resource has the IORESOURCE_MEM_NONPOSTED flag set.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 arch/sparc/include/asm/io_64.h                |  4 ++++
 include/asm-generic/io.h                      | 22 ++++++++++++++++++-
 include/asm-generic/iomap.h                   |  9 ++++++++
 include/linux/io.h                            |  2 ++
 include/linux/ioport.h                        |  1 +
 lib/devres.c                                  | 22 +++++++++++++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index cd8b6e657b94..2f45877a539d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -309,6 +309,7 @@ IOMAP
   devm_ioremap()
   devm_ioremap_uc()
   devm_ioremap_wc()
+  devm_ioremap_np()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9bb27e5c22f1..9fbfc9574432 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -409,6 +409,10 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 #define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
+static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
+{
+	return NULL;
+}
 
 static inline void iounmap(volatile void __iomem *addr)
 {
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index c6af40ce03be..082e0c96db6e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -942,7 +942,9 @@ static inline void *phys_to_virt(unsigned long address)
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
  * for specific drivers if the architecture choses to implement them.  If they
- * are not implemented we fall back to plain ioremap.
+ * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
+ * can provide stricter non-posted write semantics if the architecture
+ * implements them.
  */
 #ifndef CONFIG_MMU
 #ifndef ioremap
@@ -993,6 +995,24 @@ static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
 {
 	return NULL;
 }
+
+/*
+ * ioremap_np needs an explicit architecture implementation, as it
+ * requests stronger semantics than regular ioremap(). Portable drivers
+ * should instead use one of the higher-level abstractions, like
+ * devm_ioremap_resource(), to choose the correct variant for any given
+ * device and bus. Portable drivers with a good reason to want non-posted
+ * write semantics should always provide an ioremap() fallback in case
+ * ioremap_np() is not available.
+ */
+#ifndef ioremap_np
+#define ioremap_np ioremap_np
+static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
+{
+	return NULL;
+}
+#endif
+
 #endif
 
 #ifdef CONFIG_HAS_IOPORT_MAP
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 649224664969..9b3eb6d86200 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -101,6 +101,15 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap
 #endif
 
+#ifndef ARCH_HAS_IOREMAP_NP
+/* See the comment in asm-generic/io.h about ioremap_np(). */
+#define ioremap_np ioremap_np
+static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
diff --git a/include/linux/io.h b/include/linux/io.h
index 8394c56babc2..d718354ed3e1 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -68,6 +68,8 @@ void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
+void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 55de385c839c..1de6c2e40c32 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -108,6 +108,7 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
+#define IORESOURCE_MEM_NONPOSTED	(1<<7)
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/lib/devres.c b/lib/devres.c
index 2a4ff5d64288..4679dbb1bf5f 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -10,6 +10,7 @@ enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
 	DEVM_IOREMAP_UC,
 	DEVM_IOREMAP_WC,
+	DEVM_IOREMAP_NP,
 };
 
 void devm_ioremap_release(struct device *dev, void *res)
@@ -42,6 +43,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 	case DEVM_IOREMAP_WC:
 		addr = ioremap_wc(offset, size);
 		break;
+	case DEVM_IOREMAP_NP:
+		addr = ioremap_np(offset, size);
+		break;
 	}
 
 	if (addr) {
@@ -98,6 +102,21 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap_wc);
 
+/**
+ * devm_ioremap_np - Managed ioremap_np()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed ioremap_np().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
+			      resource_size_t size)
+{
+	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NP);
+}
+EXPORT_SYMBOL(devm_ioremap_np);
+
 /**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
@@ -128,6 +147,9 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 		return IOMEM_ERR_PTR(-EINVAL);
 	}
 
+	if (type == DEVM_IOREMAP && res->flags & IORESOURCE_MEM_NONPOSTED)
+		type = DEVM_IOREMAP_NP;
+
 	size = resource_size(res);
 
 	if (res->name)
-- 
2.30.0

