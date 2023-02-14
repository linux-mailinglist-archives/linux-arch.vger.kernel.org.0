Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC56965B0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjBNOCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 09:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjBNOBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 09:01:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4326CE8;
        Tue, 14 Feb 2023 06:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF47FB81DAF;
        Tue, 14 Feb 2023 14:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA14DC4339E;
        Tue, 14 Feb 2023 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676383287;
        bh=342zi7MEWsj7/lDCSvCJ+labpXMYUi8EQs0i5hRM0Dk=;
        h=From:To:Cc:Subject:Date:From;
        b=mmfQLdVx91NQE6lB5dtbHDXa9bcKcIDXg4ijH/ZbJ7h/71Y81AZzfLw0Z1OeDh0qR
         60tfJCrqA+Bv6CD0AxuFUxazB9AfKrqBICDDFXZbUs/1+5SQ3Z3/cPaIPaZ6KjN1kN
         LPXnPLwgacBoI3+E4VqTXEyHsjsXXNowqKU0Ika4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [PATCH] dma-mapping: no need to pass a bus_type into get_arch_dma_ops()
Date:   Tue, 14 Feb 2023 15:01:21 +0100
Message-Id: <20230214140121.131859-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5743; i=gregkh@linuxfoundation.org; h=from:subject; bh=342zi7MEWsj7/lDCSvCJ+labpXMYUi8EQs0i5hRM0Dk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmvpxjwVfOYxDPv/u1hVin4IpN32rO65gh5806rrx+sJS5V TjnZEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABN5UcewYO9NztTkbdkal2eFvxd49k nd7PjBOwwLdq3/Yfh1S4EE95rJmQ5By5dsvrl5OQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The get_arch_dma_ops() arch-specific function never does anything with
the struct bus_type that is passed into it, so remove it entirely as it
is not needed.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: linux-arch@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note: Unless someone objects, I would like to take this through the
driver-core tree, as further bus_type cleanups depend on it, and it's
stand-alone from everyone else's tree at the moment from what I can
determine.

 arch/alpha/include/asm/dma-mapping.h  | 2 +-
 arch/ia64/include/asm/dma-mapping.h   | 2 +-
 arch/mips/include/asm/dma-mapping.h   | 2 +-
 arch/parisc/include/asm/dma-mapping.h | 2 +-
 arch/sparc/include/asm/dma-mapping.h  | 2 +-
 arch/x86/include/asm/dma-mapping.h    | 2 +-
 include/asm-generic/dma-mapping.h     | 2 +-
 include/linux/dma-map-ops.h           | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 0ee6a5c99b16..6ce7e2041685 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -4,7 +4,7 @@
 
 extern const struct dma_map_ops alpha_pci_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 #ifdef CONFIG_ALPHA_JENSEN
 	return NULL;
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index a5d9d788eede..af6fa8e1597c 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -8,7 +8,7 @@
  */
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 	return dma_ops;
 }
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 34de7b17b41b..0fee561ac796 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -6,7 +6,7 @@
 
 extern const struct dma_map_ops jazz_dma_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 #if defined(CONFIG_MACH_JAZZ)
 	return &jazz_dma_ops;
diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index d5bd94247371..635665004fe6 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -21,7 +21,7 @@
 
 extern const struct dma_map_ops *hppa_dma_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 	return hppa_dma_ops;
 }
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 2f051343612e..55c12fc2ba63 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -4,7 +4,7 @@
 
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 	/* sparc32 uses per-device dma_ops */
 	return IS_ENABLED(CONFIG_SPARC64) ? dma_ops : NULL;
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 1c66708e3062..d1dac96ee30b 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -4,7 +4,7 @@
 
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 	return dma_ops;
 }
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index c13f46109e88..46a0016efd81 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_DMA_MAPPING_H
 #define _ASM_GENERIC_DMA_MAPPING_H
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+static inline const struct dma_map_ops *get_arch_dma_ops(void)
 {
 	return NULL;
 }
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d678afeb8a13..41bf4bdb117a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -90,7 +90,7 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
 	if (dev->dma_ops)
 		return dev->dma_ops;
-	return get_arch_dma_ops(dev->bus);
+	return get_arch_dma_ops();
 }
 
 static inline void set_dma_ops(struct device *dev,
-- 
2.39.1

