Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633D5A8723
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiHaT6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiHaT6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 15:58:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844EEEF0D
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 12:57:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so21458331lfr.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QVTNaIYBhiuycd3PwwoP/BD0jxZNuHmPig2lyVhzDnw=;
        b=l8850VPsSeXsvFGYgMio5LFv6TIM0tsuqOkGpkq7ma5M47ovkCvzbWgezqUWxRkLny
         bg6EEoNyDWCH9cp/jMXHPZJ/Xoffw71XsYXDqRFy0qFNx98fzsMUaPFic18wFpqvH8Bm
         KsxxoAhH5ub8ylMWuUnznWAq2C8wIXf6pUaoi1xublrXxmpJHO6Rtqhu6Bto7As2HrOT
         pIC3kkQ1PZ3raMd9fCQpqipPpdfYXReARAD2idfKh0NqbppkKe8e39QgTdpkYIvPU+HA
         an1C3nDHN87K7+ztWgA2jPkfTTJBPuU08Eg+gtUmUUEHMrRhP/AtEBoSbRx/0xUagRF4
         YzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QVTNaIYBhiuycd3PwwoP/BD0jxZNuHmPig2lyVhzDnw=;
        b=IsKmCfkavue2sKup9sGWM+GCZssWqy2L0q0NHGjcBtQrRUQFwctl9S+6u3v+8eO18o
         IdZN2ne33HQbcTZUPoZbF+OkNYwNJnJ+LnisE8Hhj/e7QD2eG/YrHrCHn+aZ6Hy/QnoZ
         +aSVmGuxPYdSmbyYMzMS4fqI1KZPXtmtU1VCjqM7Ee4qbq8gYFHPH5XXwP2dndBhncQm
         AzbVlxjuNXPqKKKivFTEsiKe2z6c1bTinfgjuem1yzb7L70HYZLl1S/M0qBwvX6jjrri
         OWlU0Vj55urqnEagW6/RfWD2D824t2I9z89r+i3m6/nuy5CJGb+I9z/fWjhcFJKe8L1U
         PoDA==
X-Gm-Message-State: ACgBeo2c27YGtZhdqeWWZ6pfQ4jgOAcRFmyzFCxOZV/FM6V65uRe+msC
        UB/OouvO4GigdlMGJKWc9mZJcw==
X-Google-Smtp-Source: AA6agR7WW9WUzcNpYPnkKDIbXUbn0iXKOUbJbtfLt9BaQbOkMUrTQ64CmqPlNmHQraXRfDBrfQIN8Q==
X-Received: by 2002:a05:6512:a88:b0:492:ea6a:12bc with SMTP id m8-20020a0565120a8800b00492ea6a12bcmr9483482lfu.229.1661975876821;
        Wed, 31 Aug 2022 12:57:56 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e6e08000000b0025fe7f33bc4sm2223068ljc.49.2022.08.31.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:57:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] sparc: Fix the generic IO helpers
Date:   Wed, 31 Aug 2022 21:55:53 +0200
Message-Id: <20220831195553.129866-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This enables the Sparc to use <asm-generic/io.h> to fill in the
missing (undefined) [read|write]sq I/O accessor functions.

This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
which has been patches to use accelerated _noinc accessors
such as readsq/writesq that Sparc64, while being a 64bit platform,
as of now not yet provide.

This comes with the requirement that everything the architecture
already provides needs to be defined, rather than just being,
say, static inline functions.

Bite the bullet and just provide the definitions and make it work.
Compile-tested on sparc32 and sparc64.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move defines in proximity of defined functions
- Test compile also on sparc32
---
 arch/sparc/include/asm/io.h    |  2 ++
 arch/sparc/include/asm/io_64.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
index 2eefa526b38f..2dad9be9ec75 100644
--- a/arch/sparc/include/asm/io.h
+++ b/arch/sparc/include/asm/io.h
@@ -19,4 +19,6 @@
 #define writel_be(__w, __addr)	__raw_writel(__w, __addr)
 #define writew_be(__l, __addr)	__raw_writew(__l, __addr)
 
+#include <asm-generic/io.h>
+
 #endif
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 5ffa820dcd4d..9303270b22f3 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -9,6 +9,7 @@
 #include <asm/page.h>      /* IO address mapping routines need this */
 #include <asm/asi.h>
 #include <asm-generic/pci_iomap.h>
+#define pci_iomap pci_iomap
 
 /* BIO layer definitions. */
 extern unsigned long kern_base, kern_size;
@@ -239,38 +240,51 @@ static inline void outl(u32 l, unsigned long addr)
 void outsb(unsigned long, const void *, unsigned long);
 void outsw(unsigned long, const void *, unsigned long);
 void outsl(unsigned long, const void *, unsigned long);
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
 void insb(unsigned long, void *, unsigned long);
 void insw(unsigned long, void *, unsigned long);
 void insl(unsigned long, void *, unsigned long);
+#define insb insb
+#define insw insw
+#define insl insl
 
 static inline void readsb(void __iomem *port, void *buf, unsigned long count)
 {
 	insb((unsigned long __force)port, buf, count);
 }
+#define readsb readsb
+
 static inline void readsw(void __iomem *port, void *buf, unsigned long count)
 {
 	insw((unsigned long __force)port, buf, count);
 }
+#define readsw readsw
 
 static inline void readsl(void __iomem *port, void *buf, unsigned long count)
 {
 	insl((unsigned long __force)port, buf, count);
 }
+#define readsl readsl
 
 static inline void writesb(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsb((unsigned long __force)port, buf, count);
 }
+#define writesb writesb
 
 static inline void writesw(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsw((unsigned long __force)port, buf, count);
 }
+#define writesw writesw
 
 static inline void writesl(void __iomem *port, const void *buf, unsigned long count)
 {
 	outsl((unsigned long __force)port, buf, count);
 }
+#define writesl writesl
 
 #define ioread8_rep(p,d,l)	readsb(p,d,l)
 #define ioread16_rep(p,d,l)	readsw(p,d,l)
@@ -344,6 +358,7 @@ static inline void memset_io(volatile void __iomem *dst, int c, __kernel_size_t
 		d++;
 	}
 }
+#define memset_io memset_io
 
 static inline void sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
 				      __kernel_size_t n)
@@ -369,6 +384,7 @@ static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
 		src++;
 	}
 }
+#define memcpy_fromio memcpy_fromio
 
 static inline void sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 				    __kernel_size_t n)
@@ -395,6 +411,7 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 		d++;
 	}
 }
+#define memcpy_toio memcpy_toio
 
 #ifdef __KERNEL__
 
@@ -412,7 +429,9 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
 {
 	return NULL;
+
 }
+#define ioremap_np ioremap_np
 
 static inline void iounmap(volatile void __iomem *addr)
 {
@@ -432,10 +451,13 @@ static inline void iounmap(volatile void __iomem *addr)
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
+#define ioport_map ioport_map
+#define ioport_unmap ioport_unmap
 
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
 void pci_iounmap(struct pci_dev *dev, void __iomem *);
+#define pci_iounmap pci_iounmap
 
 static inline int sbus_can_dma_64bit(void)
 {
-- 
2.37.2

