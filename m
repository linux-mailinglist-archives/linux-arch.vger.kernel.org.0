Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1765AA948
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiIBH6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiIBH6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 03:58:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A24BD4CC
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 00:58:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v26so2113783lfd.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Sep 2022 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wJsuXubiSrrKsQ0a8Bxt6sIQLuN35QHxFqe9t4uVspE=;
        b=TcI23U+oeoB1ixiOpoCT+LonW8d848LDbsv+01/0gGfiLfyqRS6dkkwS6dPC98GsY7
         WjKkjCHsU2nNEEZhbFTe2iCz9XEiaIpC+7cSIybxhmj3VLDI02AsFhaLEMtDvET++MLs
         0BVL45QLwU1F4M/eRsokbESq+0MEeIDN1GVtFl8wm9N76UGf+SKLj7mWWNEs8ev9XO3c
         GCsjqbwA82ybj1EKV+PER9rUdjbjRMw7XXX3NNaJgCNguxSm/7wz+DPAWsqi43R31u9q
         aUMk6X/hiG9Nn0JCNnwX8f0LQNfXF2BlFB7eauPeR28AH2/WGlF5X52d2DYCjKIxn7KG
         5Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wJsuXubiSrrKsQ0a8Bxt6sIQLuN35QHxFqe9t4uVspE=;
        b=Z4Lg3RD/6/MuTjzYYvF+rYM5vV7taV12QaRycws+lyJ1lM5zUMu7/bFoTMHmc4OeKq
         lH4jaLWMjQ5bEeFDZrAR+FAGeu58ucjZ6fxjUu3rbiNTjhGtSfBIsslAPs4CerTwmh7Y
         qyVGeEf+b81BXqDrJLEnCFga0Nn2GrbtnOvEVJ1zA9VHdGGhihj5NWZkD+0AVmWOFe5C
         nyKVWUxwE3yPA2FgkiBwPJD65IJQyw/ht18+d85DBTMTym3jZx5mt3D9+JCXkVS7ZGGn
         yzmOsD9MW09wj/KnHIakMCf00roRBdi1Jwp1Knals2/t8jQb/dmMAAKph3iijDN4DtdP
         ZDgg==
X-Gm-Message-State: ACgBeo0/vDbHiVLXmR98p44fU4qIeLVAgOqzh9NHz2F9bwRHW5wCZ9yk
        0dwy20mqG7fK/H8TWMpqboXmlg==
X-Google-Smtp-Source: AA6agR7WeEE5ZgzmKiZK8G8jHoLwahh9vpQ7QiiwUSUbNxkRx3/VqRQDep4C6yrsDJtNpVpK+bVlsw==
X-Received: by 2002:ac2:4c47:0:b0:494:9b99:bd29 with SMTP id o7-20020ac24c47000000b004949b99bd29mr1955485lfk.240.1662105509715;
        Fri, 02 Sep 2022 00:58:29 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b004947844e277sm160863lfi.178.2022.09.02.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:58:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH 2/2 v3] parisc: Use the generic IO helpers
Date:   Fri,  2 Sep 2022 09:51:22 +0200
Message-Id: <20220902075122.339753-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902075122.339753-1-linus.walleij@linaro.org>
References: <20220902075122.339753-1-linus.walleij@linaro.org>
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

This enables the parisc to use <asm-generic/io.h> to fill in the
missing (undefined) [read|write]sq I/O accessor functions.

This is needed if parisc[64] ever wants to uses CONFIG_REGMAP_MMIO
which has been patches to use accelerated _noinc accessors
such as readsq/writesq that parisc64, while being a 64bit platform,
as of now not yet provide.

This comes with the requirement that everything the architecture
already provides needs to be defined, rather than just being,
say, static inline functions.

Bite the bullet and just provide the definitions and make it work.
Compile-tested on parisc32 and parisc64. Drop some of the __raw
functions that now get implemented in <asm-generic/io.h>.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/62fcc351.hAyADB%2FY8JTxz+kh%25lkp@intel.com/
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Prepend a patch removing all 64bit accessor use before the
  conversion.
- Drop the idea to create 64bit accesories on 32bit systems.
ChangeLog v1->v2:
- Missed a dangling onelineer adding pci_iounmap in my tree.
- Just drop all the __raw_read[b|w|l|q] and __raw_write[b|w|l|q]
  as these are identical to what <asm-generic/io.h> provides.
- Just drop the local read[b|w|l|q] and write[b|w|l|q] as well
  as the generic versions probably do a better job: this adds
  the __io_ar()/__io_bw() barriers as they should probably be
  there, we have just been lucky.
- Drop a comment that parisc does not select GENERIC_IOMAP.
- In arch/parisc/lib/iomap.c the .read64 and .read64be operations
  were defined unconditionally and drivers/parisc/sba_iommu.c
  also expect readq/writeq to be available so add a special
  parameter to <asm-generic/io.h> to make sure we get these
  also on 32bit parisc.
- The changes to <asm-generic/io.h> probably makes this patch
  a candidate for the arch tree rather than parisc.
---
 arch/parisc/include/asm/io.h | 132 ++++++++++++-----------------------
 1 file changed, 43 insertions(+), 89 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 42ffb60a6ea9..37580ad8d5bd 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -128,98 +128,16 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 void __iomem *ioremap(unsigned long offset, unsigned long size);
 #define ioremap_wc			ioremap
 #define ioremap_uc			ioremap
+#define pci_iounmap			pci_iounmap
 
 extern void iounmap(const volatile void __iomem *addr);
 
-static inline unsigned char __raw_readb(const volatile void __iomem *addr)
-{
-	return (*(volatile unsigned char __force *) (addr));
-}
-static inline unsigned short __raw_readw(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned short __force *) addr;
-}
-static inline unsigned int __raw_readl(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned int __force *) addr;
-}
-static inline unsigned long long __raw_readq(const volatile void __iomem *addr)
-{
-	return *(volatile unsigned long long __force *) addr;
-}
-
-static inline void __raw_writeb(unsigned char b, volatile void __iomem *addr)
-{
-	*(volatile unsigned char __force *) addr = b;
-}
-static inline void __raw_writew(unsigned short b, volatile void __iomem *addr)
-{
-	*(volatile unsigned short __force *) addr = b;
-}
-static inline void __raw_writel(unsigned int b, volatile void __iomem *addr)
-{
-	*(volatile unsigned int __force *) addr = b;
-}
-static inline void __raw_writeq(unsigned long long b, volatile void __iomem *addr)
-{
-	*(volatile unsigned long long __force *) addr = b;
-}
-
-static inline unsigned char readb(const volatile void __iomem *addr)
-{
-	return __raw_readb(addr);
-}
-static inline unsigned short readw(const volatile void __iomem *addr)
-{
-	return le16_to_cpu((__le16 __force) __raw_readw(addr));
-}
-static inline unsigned int readl(const volatile void __iomem *addr)
-{
-	return le32_to_cpu((__le32 __force) __raw_readl(addr));
-}
-static inline unsigned long long readq(const volatile void __iomem *addr)
-{
-	return le64_to_cpu((__le64 __force) __raw_readq(addr));
-}
-
-static inline void writeb(unsigned char b, volatile void __iomem *addr)
-{
-	__raw_writeb(b, addr);
-}
-static inline void writew(unsigned short w, volatile void __iomem *addr)
-{
-	__raw_writew((__u16 __force) cpu_to_le16(w), addr);
-}
-static inline void writel(unsigned int l, volatile void __iomem *addr)
-{
-	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
-}
-static inline void writeq(unsigned long long q, volatile void __iomem *addr)
-{
-	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
-}
-
-#define	readb	readb
-#define	readw	readw
-#define	readl	readl
-#define readq	readq
-#define writeb	writeb
-#define writew	writew
-#define writel	writel
-#define writeq	writeq
-
-#define readb_relaxed(addr)	readb(addr)
-#define readw_relaxed(addr)	readw(addr)
-#define readl_relaxed(addr)	readl(addr)
-#define readq_relaxed(addr)	readq(addr)
-#define writeb_relaxed(b, addr)	writeb(b, addr)
-#define writew_relaxed(w, addr)	writew(w, addr)
-#define writel_relaxed(l, addr)	writel(l, addr)
-#define writeq_relaxed(q, addr)	writeq(q, addr)
-
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
 
 /* Port-space IO */
 
@@ -241,10 +159,15 @@ extern void eisa_out32(unsigned int data, unsigned short port);
 extern unsigned char inb(int addr);
 extern unsigned short inw(int addr);
 extern unsigned int inl(int addr);
-
 extern void outb(unsigned char b, int addr);
 extern void outw(unsigned short b, int addr);
 extern void outl(unsigned int b, int addr);
+#define inb inb
+#define inw inw
+#define inl inl
+#define outb outb
+#define outw outw
+#define outl outl
 #elif defined(CONFIG_EISA)
 #define inb eisa_in8
 #define inw eisa_in16
@@ -270,7 +193,9 @@ static inline int inl(unsigned long addr)
 	BUG();
 	return -1;
 }
-
+#define inb inb
+#define inw inw
+#define inl inl
 #define outb(x, y)	({(void)(x); (void)(y); BUG(); 0;})
 #define outw(x, y)	({(void)(x); (void)(y); BUG(); 0;})
 #define outl(x, y)	({(void)(x); (void)(y); BUG(); 0;})
@@ -285,7 +210,12 @@ extern void insl (unsigned long port, void *dst, unsigned long count);
 extern void outsb (unsigned long port, const void *src, unsigned long count);
 extern void outsw (unsigned long port, const void *src, unsigned long count);
 extern void outsl (unsigned long port, const void *src, unsigned long count);
-
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
 
 /* IO Port space is :      BBiiii   where BB is HBA number. */
 #define IO_SPACE_LIMIT 0x00ffffff
@@ -307,6 +237,28 @@ extern void iowrite64(u64 val, void __iomem *addr);
 extern void iowrite64be(u64 val, void __iomem *addr);
 
 #include <asm-generic/iomap.h>
+/*
+ * These get provided from <asm-generic/iomap.h> since parisc does not
+ * select GENERIC_IOMAP.
+ */
+#define ioport_map ioport_map
+#define ioport_unmap ioport_unmap
+#define ioread8 ioread8
+#define ioread16 ioread16
+#define ioread32 ioread32
+#define ioread16be ioread16be
+#define ioread32be ioread32be
+#define iowrite8 iowrite8
+#define iowrite16 iowrite16
+#define iowrite32 iowrite32
+#define iowrite16be iowrite16be
+#define iowrite32be iowrite32be
+#define ioread8_rep ioread8_rep
+#define ioread16_rep ioread16_rep
+#define ioread32_rep ioread32_rep
+#define iowrite8_rep iowrite8_rep
+#define iowrite16_rep iowrite16_rep
+#define iowrite32_rep iowrite32_rep
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
@@ -316,4 +268,6 @@ extern void iowrite64be(u64 val, void __iomem *addr);
 
 extern int devmem_is_allowed(unsigned long pfn);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.37.2

