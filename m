Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078F5A8853
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiHaVqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaVqx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 17:46:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4919F4CAD
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 14:46:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so21798504lfr.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+AxJz6xaOklSdHPDOyGIV9Mb8mD/r0pmAcZhKRsxq8w=;
        b=viGfKdGbKbZIu6Om704a59MNo3wPJty0aVUdS0WofbnHSvWk9unOywt0hO568MGfXw
         w3gDf6RvDVZhBWLzxdmvzMPWU6WzJxFPYokUoH6zbWyFWm/ePg27u4rwrlKXqgj9R8oa
         tN93UEVR2LzsDXDVjIRgjDoGJnUm8mXJeJPe5RAwEWLt4W24PjKqC6YIRHob3U5DbsMD
         TXrFggxzGBUkmoZFZnOtUp/qvQhNP+tHhN886IHq0PjZWwHIoFZlhvDKK4pkgECqaGmA
         AYULEu5bzhLLXs9HOUJgRfAjMH3g7MypjcV6yc2Yh6pzElvEDAUUD/ETl80BW/cIWFgs
         oNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+AxJz6xaOklSdHPDOyGIV9Mb8mD/r0pmAcZhKRsxq8w=;
        b=nCCGEN8FMmxoAS1OU7fHxK8RnyvSABtprOqcO25fxL82Y5oRMOHg+TW//TQzA2lbSx
         uUL6RKucsGeJEFek77hj74B9maXlX/BdHy1/lksGSSXHKAVSLRVcnKISScsmT/L4V8aD
         XQLBpMP7C90a+g1mIcLEf9dVieW7enS4n8/Zf8V1YGfBd60fqfR4MGJ1rhHN1VvObC0z
         nEk8Qyw9Kpwp4ON7pGoNyTnmJ0CR2ljzn38tqni0kiAPo5TUFWl3YwqOhw5TpS5z/4NW
         +M3ZA/YvpVQ5foN/5X4yl9clQj0WRBhk9YJbDd+2pUAKdpKvYNgD5KM1Uj3KdU5t99Uv
         Wrog==
X-Gm-Message-State: ACgBeo221e/Z2lvyG9qf5FG9YKIBQbO6zFEjNGK+8I1MgTZFvJqfSX6M
        U/jfiXbpC2vSCc12qsocfjsTYw==
X-Google-Smtp-Source: AA6agR7VtndXY0stYAXOiBVV39V61KbHhOUCKP0WoEIopqb1h7kCDjz0lLEHGdRMV2nW4gspjbdOxQ==
X-Received: by 2002:ac2:44a3:0:b0:494:6c0e:5468 with SMTP id c3-20020ac244a3000000b004946c0e5468mr4615867lfm.425.1661982410011;
        Wed, 31 Aug 2022 14:46:50 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512114300b00492d7a7b4e3sm1080752lfg.4.2022.08.31.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:46:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] parisc: Use the generic IO helpers
Date:   Wed, 31 Aug 2022 23:44:47 +0200
Message-Id: <20220831214447.273178-1-linus.walleij@linaro.org>
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
Compile-tested on parisc32 and parisc64.

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
 arch/parisc/include/asm/io.h | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 42ffb60a6ea9..2b04473c97e3 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -135,35 +135,43 @@ static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
 	return (*(volatile unsigned char __force *) (addr));
 }
+#define __raw_readb __raw_readb
 static inline unsigned short __raw_readw(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned short __force *) addr;
 }
+#define __raw_readw __raw_readw
 static inline unsigned int __raw_readl(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned int __force *) addr;
 }
+#define __raw_readl __raw_readl
 static inline unsigned long long __raw_readq(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned long long __force *) addr;
 }
+#define __raw_readq __raw_readq
 
 static inline void __raw_writeb(unsigned char b, volatile void __iomem *addr)
 {
 	*(volatile unsigned char __force *) addr = b;
 }
+#define __raw_writeb __raw_writeb
 static inline void __raw_writew(unsigned short b, volatile void __iomem *addr)
 {
 	*(volatile unsigned short __force *) addr = b;
 }
+#define __raw_writew __raw_writew
 static inline void __raw_writel(unsigned int b, volatile void __iomem *addr)
 {
 	*(volatile unsigned int __force *) addr = b;
 }
+#define __raw_writel __raw_writel
 static inline void __raw_writeq(unsigned long long b, volatile void __iomem *addr)
 {
 	*(volatile unsigned long long __force *) addr = b;
 }
+#define __raw_writeq __raw_writeq
 
 static inline unsigned char readb(const volatile void __iomem *addr)
 {
@@ -193,6 +201,7 @@ static inline void writew(unsigned short w, volatile void __iomem *addr)
 static inline void writel(unsigned int l, volatile void __iomem *addr)
 {
 	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
+
 }
 static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 {
@@ -220,6 +229,9 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
 
 /* Port-space IO */
 
@@ -241,10 +253,15 @@ extern void eisa_out32(unsigned int data, unsigned short port);
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
@@ -270,7 +287,9 @@ static inline int inl(unsigned long addr)
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
@@ -285,7 +304,12 @@ extern void insl (unsigned long port, void *dst, unsigned long count);
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
@@ -307,6 +331,25 @@ extern void iowrite64(u64 val, void __iomem *addr);
 extern void iowrite64be(u64 val, void __iomem *addr);
 
 #include <asm-generic/iomap.h>
+/* These get provided from <asm-generic/iomap.h> */
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
@@ -316,4 +359,6 @@ extern void iowrite64be(u64 val, void __iomem *addr);
 
 extern int devmem_is_allowed(unsigned long pfn);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.37.2

