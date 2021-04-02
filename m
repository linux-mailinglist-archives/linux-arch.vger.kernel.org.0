Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA46352804
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhDBJHS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhDBJHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 05:07:14 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C9C06178A;
        Fri,  2 Apr 2021 02:07:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0F19242725;
        Fri,  2 Apr 2021 09:07:04 +0000 (UTC)
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
Subject: [PATCH v4 11/18] asm-generic/io.h: implement pci_remap_cfgspace using ioremap_np
Date:   Fri,  2 Apr 2021 18:05:35 +0900
Message-Id: <20210402090542.131194-12-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that we have ioremap_np(), we can make pci_remap_cfgspace() default
to it, falling back to ioremap() on platforms where it is not available.

Remove the arm64 implementation, since that is now redundant. Future
cleanups should be able to do the same for other arches, and eventually
make the generic pci_remap_cfgspace() unconditional.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/include/asm/io.h | 10 ----------
 include/linux/io.h          | 21 +++++++++++++--------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 953b8703af60..7fd836bea7eb 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -171,16 +171,6 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
-/*
- * PCI configuration space mapping function.
- *
- * The PCI specification disallows posted write configuration transactions.
- * Add an arch specific pci_remap_cfgspace() definition that is implemented
- * through nGnRnE device memory attribute as recommended by the ARM v8
- * Architecture reference manual Issue A.k B2.8.2 "Device memory".
- */
-#define pci_remap_cfgspace(addr, size) __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
-
 /*
  * io{read,write}{16,32,64}be() macros
  */
diff --git a/include/linux/io.h b/include/linux/io.h
index d718354ed3e1..6f6b9233f2c3 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -82,20 +82,25 @@ void devm_memunmap(struct device *dev, void *addr);
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
- * Posting") mandate non-posted configuration transactions. There is
- * no ioremap API in the kernel that can guarantee non-posted write
- * semantics across arches so provide a default implementation for
- * mapping PCI config space that defaults to ioremap(); arches
- * should override it if they have memory mapping implementations that
- * guarantee non-posted writes semantics to make the memory mapping
- * compliant with the PCI specification.
+ * Posting") mandate non-posted configuration transactions. This default
+ * implementation attempts to use the ioremap_np() API to provide this
+ * on arches that support it, and falls back to ioremap() on those that
+ * don't. Overriding this function is deprecated; arches that properly
+ * support non-posted accesses should implement ioremap_np() instead, which
+ * this default implementation can then use to return mappings compliant with
+ * the PCI specification.
  */
 #ifndef pci_remap_cfgspace
 #define pci_remap_cfgspace pci_remap_cfgspace
 static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
 					       size_t size)
 {
-	return ioremap(offset, size);
+	void __iomem *ret = ioremap_np(offset, size);
+
+	if (!ret)
+		ret = ioremap(offset, size);
+
+	return ret;
 }
 #endif
 #endif
-- 
2.30.0

