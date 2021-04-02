Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C270D35280A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhDBJHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhDBJHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 05:07:23 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662ACC0613E6;
        Fri,  2 Apr 2021 02:07:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B558B4272F;
        Fri,  2 Apr 2021 09:07:11 +0000 (UTC)
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
Subject: [PATCH v4 12/18] of/address: Add infrastructure to declare MMIO as non-posted
Date:   Fri,  2 Apr 2021 18:05:36 +0900
Message-Id: <20210402090542.131194-13-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This implements the 'nonposted-mmio' boolean property. Placing this
property in a bus marks all direct child devices as requiring
non-posted MMIO mappings. If no such property is found, the default
is posted MMIO.

of_mmio_is_nonposted() performs this check to determine if a given
device has requested non-posted MMIO.

of_address_to_resource() uses this to set the IORESOURCE_MEM_NONPOSTED
flag on resources that require non-posted MMIO.

of_iomap() and of_io_request_and_map() then use this flag to pick the
correct ioremap() variant.

This mechanism is currently restricted to builds that support Apple ARM
platforms, as an optimization.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/of/address.c       | 43 ++++++++++++++++++++++++++++++++++++--
 include/linux/of_address.h |  1 +
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3f..6485cc536e81 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -847,6 +847,9 @@ static int __of_address_to_resource(struct device_node *dev,
 		return -EINVAL;
 	memset(r, 0, sizeof(struct resource));
 
+	if (of_mmio_is_nonposted(dev))
+		flags |= IORESOURCE_MEM_NONPOSTED;
+
 	r->start = taddr;
 	r->end = taddr + size - 1;
 	r->flags = flags;
@@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	if (of_address_to_resource(np, index, &res))
 		return NULL;
 
-	return ioremap(res.start, resource_size(&res));
+	if (res.flags & IORESOURCE_MEM_NONPOSTED)
+		return ioremap_np(res.start, resource_size(&res));
+	else
+		return ioremap(res.start, resource_size(&res));
 }
 EXPORT_SYMBOL(of_iomap);
 
@@ -928,7 +934,11 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
 	if (!request_mem_region(res.start, resource_size(&res), name))
 		return IOMEM_ERR_PTR(-EBUSY);
 
-	mem = ioremap(res.start, resource_size(&res));
+	if (res.flags & IORESOURCE_MEM_NONPOSTED)
+		mem = ioremap_np(res.start, resource_size(&res));
+	else
+		mem = ioremap(res.start, resource_size(&res));
+
 	if (!mem) {
 		release_mem_region(res.start, resource_size(&res));
 		return IOMEM_ERR_PTR(-ENOMEM);
@@ -1094,3 +1104,32 @@ bool of_dma_is_coherent(struct device_node *np)
 	return false;
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
+
+/**
+ * of_mmio_is_nonposted - Check if device uses non-posted MMIO
+ * @np:	device node
+ *
+ * Returns true if the "nonposted-mmio" property was found for
+ * the device's bus.
+ *
+ * This is currently only enabled on builds that support Apple ARM devices, as
+ * an optimization.
+ */
+bool of_mmio_is_nonposted(struct device_node *np)
+{
+	struct device_node *parent;
+	bool nonposted;
+
+	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
+		return false;
+
+	parent = of_get_parent(np);
+	if (!parent)
+		return false;
+
+	nonposted = of_property_read_bool(parent, "nonposted-mmio");
+
+	of_node_put(parent);
+	return nonposted;
+}
+EXPORT_SYMBOL_GPL(of_mmio_is_nonposted);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 88bc943405cd..88f6333fee6c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -62,6 +62,7 @@ extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
 extern bool of_dma_is_coherent(struct device_node *np);
+extern bool of_mmio_is_nonposted(struct device_node *np);
 #else /* CONFIG_OF_ADDRESS */
 static inline void __iomem *of_io_request_and_map(struct device_node *device,
 						  int index, const char *name)
-- 
2.30.0

