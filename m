Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762025A982F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiIANM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiIANMJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 09:12:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60846F7
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 06:08:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p16so6310135lfd.6
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SOxkCPfzq8DPdkfKA53CJ1HWoMAwuKH34eY3soWhU3c=;
        b=bUjhcXQ2sPqpOvR9RctdXX7K/X+LecDkn5GxKfyac7vzj4rsJk1Ku20e8LNC6MhJIb
         +nPo8BWTzaqNm0qxODMYsGInIJIMBriJrnI+A1b847cxijOvbG/C3Yl0/15XtNB5baRw
         WXObvTjHAtgCoY4Jr70Y4B+H8QQDQrXbIAvjMj8aN5bry+dPHzNpYkEq8dYwTEZqv7WU
         QrKg61R0QKlhflUvhkZLPoX4lwWeODjpURsFUoV9XHf176WWkEGfOVecsQxFP1Agk/Je
         dQLbkU/LyiTHKhNW5D4f8XXJmnFctEjeqGG3hOZtsQ0LN+7zbEeOKooPXh0kfe9eQuYz
         YCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SOxkCPfzq8DPdkfKA53CJ1HWoMAwuKH34eY3soWhU3c=;
        b=iH2hZnB3Ij62m/BgTZN98BzDjfF7CshwTxK55t6vRmsVPYo5KMAyCd2gGlnWja3P/v
         ftvGHiO+FvSIgV6HGSxoqdLzl6pwgIFwVhC1ySUjEQt3PAJMfb/ywpPIZc8FcjTnYSss
         UiD7hIDedlYBzm504IaSbGE01Oz+tJI9A997YRkqZVK2hPE3OOvOerU/wWGt+8JEfGnV
         ZbIM2I0779C+lfh42+knBqJY9KLc0GsYS3R6p6v7bkyBigl8esn40A3M/GiyZZ9l1yTf
         /p5ArK8xYWy11GGcm9f6yEneqnfQtcS2eYInUTMwUqCKg38cqekZb7pokTr1OO5dzrtM
         aIKg==
X-Gm-Message-State: ACgBeo2hYMSYLZhBhEIb8YvcDe6c9XkEe7u+kBNa6AlCwTzpTGpS44yb
        K+PmxaIGa7EYQJ2qdYivUS14RA==
X-Google-Smtp-Source: AA6agR7aCqR/lXwFPd44EzviJPYd71bqnHLZM8+OdVLR80Pes6qYsvzAOKgClbKLgrGMncait7bcqQ==
X-Received: by 2002:a05:6512:2216:b0:48b:3a34:d14a with SMTP id h22-20020a056512221600b0048b3a34d14amr11325141lfu.158.1662037737572;
        Thu, 01 Sep 2022 06:08:57 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e2f14000000b0025e60089f34sm2484690ljv.52.2022.09.01.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:08:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] parisc: Use the generic IO helpers
Date:   Thu,  1 Sep 2022 15:06:54 +0200
Message-Id: <20220901130654.177504-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

In arch/parisc/lib/iomap.c the .read64 and .read64be operations
were defined unconditionally using readq() and
drivers/parisc/sba_iommu.c also expect writeq to be available so add
parameterization to <asm-generic/io.h> to make sure we get these also
on 32bit parisc: platforms can now opt in for generic 64bit
IO operations even if they are not nativelt 64bit by definining
GENERIC_64BIT_IO before including <asm-generi/io.h>, while
these will still be default-enabled on CONFIG_64BIT systems.

During development an apparent bug was identified in
arch/parisc/lib/iomap.c where [__raw_]writel was used to access
a 64bit IO address, this was patched to use writeq().

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/62fcc351.hAyADB%2FY8JTxz+kh%25lkp@intel.com/
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
 arch/parisc/include/asm/io.h | 133 ++++++++++++-----------------------
 arch/parisc/lib/iomap.c      |   4 +-
 include/asm-generic/io.h     |  53 +++++++-------
 3 files changed, 75 insertions(+), 115 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 42ffb60a6ea9..a3454d0ee3ff 100644
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
+ * These get provided from <asm-generic/iomap.h> sinc parisc does not
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
@@ -316,4 +268,7 @@ extern void iowrite64be(u64 val, void __iomem *addr);
 
 extern int devmem_is_allowed(unsigned long pfn);
 
+#define GENERIC_64BIT_IO
+#include <asm-generic/io.h>
+
 #endif
diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 860385058085..29a81b06e5a8 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -212,12 +212,12 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 
 static void iomem_write64(u64 datum, void __iomem *addr)
 {
-	writel(datum, addr);
+	writeq(datum, addr);
 }
 
 static void iomem_write64be(u64 datum, void __iomem *addr)
 {
-	__raw_writel(datum, addr);
+	__raw_writeq(datum, addr);
 }
 
 static void iomem_read8r(const void __iomem *addr, void *dst, unsigned long count)
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..4e6986918255 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -7,6 +7,11 @@
 #ifndef __ASM_GENERIC_IO_H
 #define __ASM_GENERIC_IO_H
 
+/* Archs can also opt in for 64bit IO on non-64bit platforms */
+#ifdef CONFIG_64BIT
+#define GENERIC_64BIT_IO
+#endif
+
 #include <asm/page.h> /* I/O is all done through memory accesses */
 #include <linux/string.h> /* for memset() and memcpy() */
 #include <linux/types.h>
@@ -133,7 +138,7 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef __raw_readq
 #define __raw_readq __raw_readq
 static inline u64 __raw_readq(const volatile void __iomem *addr)
@@ -141,7 +146,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 	return *(const volatile u64 __force *)addr;
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef __raw_writeb
 #define __raw_writeb __raw_writeb
@@ -167,7 +172,7 @@ static inline void __raw_writel(u32 value, volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef __raw_writeq
 #define __raw_writeq __raw_writeq
 static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
@@ -175,7 +180,7 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 	*(volatile u64 __force *)addr = value;
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 /*
  * {read,write}{b,w,l,q}() access little endian memory and return result in
@@ -227,7 +232,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef readq
 #define readq readq
 static inline u64 readq(const volatile void __iomem *addr)
@@ -242,7 +247,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 	return val;
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef writeb
 #define writeb writeb
@@ -280,7 +285,7 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef writeq
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
@@ -292,7 +297,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 	log_post_write_mmio(value, 64, addr, _THIS_IP_);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
@@ -443,7 +448,7 @@ static inline void readsl(const volatile void __iomem *addr, void *buffer,
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef readsq
 #define readsq readsq
 static inline void readsq(const volatile void __iomem *addr, void *buffer,
@@ -459,7 +464,7 @@ static inline void readsq(const volatile void __iomem *addr, void *buffer,
 	}
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef writesb
 #define writesb writesb
@@ -506,7 +511,7 @@ static inline void writesl(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef writesq
 #define writesq writesq
 static inline void writesq(volatile void __iomem *addr, const void *buffer,
@@ -521,7 +526,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 	}
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef PCI_IOBASE
 #define PCI_IOBASE ((void __iomem *)0)
@@ -812,7 +817,7 @@ static inline u32 ioread32(const volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef ioread64
 #define ioread64 ioread64
 static inline u64 ioread64(const volatile void __iomem *addr)
@@ -820,7 +825,7 @@ static inline u64 ioread64(const volatile void __iomem *addr)
 	return readq(addr);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef iowrite8
 #define iowrite8 iowrite8
@@ -846,7 +851,7 @@ static inline void iowrite32(u32 value, volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef iowrite64
 #define iowrite64 iowrite64
 static inline void iowrite64(u64 value, volatile void __iomem *addr)
@@ -854,7 +859,7 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 	writeq(value, addr);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef ioread16be
 #define ioread16be ioread16be
@@ -872,7 +877,7 @@ static inline u32 ioread32be(const volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef ioread64be
 #define ioread64be ioread64be
 static inline u64 ioread64be(const volatile void __iomem *addr)
@@ -880,7 +885,7 @@ static inline u64 ioread64be(const volatile void __iomem *addr)
 	return swab64(readq(addr));
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef iowrite16be
 #define iowrite16be iowrite16be
@@ -898,7 +903,7 @@ static inline void iowrite32be(u32 value, volatile void __iomem *addr)
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef iowrite64be
 #define iowrite64be iowrite64be
 static inline void iowrite64be(u64 value, volatile void __iomem *addr)
@@ -906,7 +911,7 @@ static inline void iowrite64be(u64 value, volatile void __iomem *addr)
 	writeq(swab64(value), addr);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef ioread8_rep
 #define ioread8_rep ioread8_rep
@@ -935,7 +940,7 @@ static inline void ioread32_rep(const volatile void __iomem *addr,
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef ioread64_rep
 #define ioread64_rep ioread64_rep
 static inline void ioread64_rep(const volatile void __iomem *addr,
@@ -944,7 +949,7 @@ static inline void ioread64_rep(const volatile void __iomem *addr,
 	readsq(addr, buffer, count);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 
 #ifndef iowrite8_rep
 #define iowrite8_rep iowrite8_rep
@@ -976,7 +981,7 @@ static inline void iowrite32_rep(volatile void __iomem *addr,
 }
 #endif
 
-#ifdef CONFIG_64BIT
+#ifdef GENERIC_64BIT_IO
 #ifndef iowrite64_rep
 #define iowrite64_rep iowrite64_rep
 static inline void iowrite64_rep(volatile void __iomem *addr,
@@ -986,7 +991,7 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 	writesq(addr, buffer, count);
 }
 #endif
-#endif /* CONFIG_64BIT */
+#endif /* GENERIC_64BIT_IO */
 #endif /* CONFIG_GENERIC_IOMAP */
 
 #ifdef __KERNEL__
-- 
2.37.2

