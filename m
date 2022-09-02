Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDB5AA923
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIBHx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 03:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIBHx2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 03:53:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B64BADAA
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 00:53:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w19so1427880ljj.7
        for <linux-arch@vger.kernel.org>; Fri, 02 Sep 2022 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Zxo7GYPZhxL9s0ClL/mT7+wvS2c1Gq49I6buAQY2XCc=;
        b=VwxeKPE9b8jENECBBgdN59EkQTuRP9G9YhSsrLP1zwkQZmLw4u6GWew4gftApDykX2
         p+mU9GpvUWnedVObR1dY8WUfm/66sN4eKjdYWrmreac7SMG6VJ6RtdVNSw9L26vzAz01
         rZwadsB/cQTGBBEcqbFZ/ahSuzGECPHWzHGCnxB4DzkXO6aDLqXox9xPn50zbZIJe16f
         9O2cB2dwP63kYNEske1Guiz+VzpKj1jnXh2ONpnPDdFGiGuXOzSoxKqt23A8jVCqyD9d
         UgZAyMhvE+7yIj0yQRIIHYylJgP+76NSCXrnerMNdjezDC62BCfm8l06s0vEtUUE2Ir2
         MDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Zxo7GYPZhxL9s0ClL/mT7+wvS2c1Gq49I6buAQY2XCc=;
        b=6tQJOTb0Q+2CBEv6WHaNq0qLku1e9ajRSz743WUlc2QXY2o0fiG9HHX0ulcudoUuUf
         qb2PpuUYna3R0jqm4+AAdlkY0svEuOIj/FCDIe35eQCujinP/7s9tJLEwg8CJYKpAp2h
         kcrrKZmT1JDHksFQPGfE7Ive1f4OmZDRRsIUHplH5tcSeeewIEq0QXv2B0LpANKj3/m/
         QxvaDMbLtf90xw8yssXIEGq4XAFVVW6bU/wT5Vk0E4tpeDMF/U0Ka9fczpcsEZYXzczK
         aXa3D+xUt3ngqrQt/RT2AByq8SPTAXEhyYNJEPtJ+/HZWlYnYO7o9Wp3npGerUb4ikBq
         7XtQ==
X-Gm-Message-State: ACgBeo3DMHUjp6P/vAE2roCS3MQx5npih2LcKL+2xCaRB1w3ftBj9ZiE
        U5TcaMCJZPc5dbbTlnl6AkPCbg==
X-Google-Smtp-Source: AA6agR66wWw9lPLQOVrbAZ3qcTdQ3rP/UqPGazUT31BpGhW/LwaHQv/U5/4OYJAybbZg67thmb9msQ==
X-Received: by 2002:a05:651c:b0c:b0:268:dae4:9727 with SMTP id b12-20020a05651c0b0c00b00268dae49727mr965887ljr.526.1662105204991;
        Fri, 02 Sep 2022 00:53:24 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b004947844e277sm160863lfi.178.2022.09.02.00.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:53:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH 1/2 v3] parisc: Remove 64bit access on 32bit machines
Date:   Fri,  2 Sep 2022 09:51:21 +0200
Message-Id: <20220902075122.339753-1-linus.walleij@linaro.org>
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

The parisc was using some readq/writeq accessors without special
considerations as to what will happen on 32bit CPUs if you do
this. Maybe we have been lucky that it "just worked" on 32bit
due to the compiler behaviour, or the code paths were never
executed.

Fix the two offending code sites like this:

arch/parisc/lib/iomap.c:

- Put ifdefs around the 64bit accessors and make sure
  that ioread64, ioread64be, iowrite64 and iowrite64be
  are not available on 32bit builds.

- Also fold in a bug fix where 64bit access was by
  mistake using 32bit writel() accessors rather
  than 64bit writeq().

drivers/parisc/sba_iommu.c:

- Access any 64bit registers using ioread64_lo_hi()
  or iowrite64_lo_hi().

Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v0->v3:
- New patch fixing the use of IO accessors
- If the parisc people have no strong preference maybe Arnd
  can merge this through the arch tree with patch 2/2.
---
 arch/parisc/lib/iomap.c    | 24 ++++++++++++++++++++++--
 drivers/parisc/sba_iommu.c | 12 ++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 860385058085..d3d57119df64 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -48,15 +48,19 @@ struct iomap_ops {
 	unsigned int (*read16be)(const void __iomem *);
 	unsigned int (*read32)(const void __iomem *);
 	unsigned int (*read32be)(const void __iomem *);
+#ifdef CONFIG_64BIT
 	u64 (*read64)(const void __iomem *);
 	u64 (*read64be)(const void __iomem *);
+#endif
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
 	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
 	void (*write32be)(u32, void __iomem *);
+#ifdef CONFIG_64BIT
 	void (*write64)(u64, void __iomem *);
 	void (*write64be)(u64, void __iomem *);
+#endif
 	void (*read8r)(const void __iomem *, void *, unsigned long);
 	void (*read16r)(const void __iomem *, void *, unsigned long);
 	void (*read32r)(const void __iomem *, void *, unsigned long);
@@ -175,6 +179,7 @@ static unsigned int iomem_read32be(const void __iomem *addr)
 	return __raw_readl(addr);
 }
 
+#ifdef CONFIG_64BIT
 static u64 iomem_read64(const void __iomem *addr)
 {
 	return readq(addr);
@@ -184,6 +189,7 @@ static u64 iomem_read64be(const void __iomem *addr)
 {
 	return __raw_readq(addr);
 }
+#endif
 
 static void iomem_write8(u8 datum, void __iomem *addr)
 {
@@ -210,15 +216,17 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 	__raw_writel(datum, addr);
 }
 
+#ifdef CONFIG_64BIT
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
+#endif
 
 static void iomem_read8r(const void __iomem *addr, void *dst, unsigned long count)
 {
@@ -274,15 +282,19 @@ static const struct iomap_ops iomem_ops = {
 	.read16be = iomem_read16be,
 	.read32 = iomem_read32,
 	.read32be = iomem_read32be,
+#ifdef CONFIG_64BIT
 	.read64 = iomem_read64,
 	.read64be = iomem_read64be,
+#endif
 	.write8 = iomem_write8,
 	.write16 = iomem_write16,
 	.write16be = iomem_write16be,
 	.write32 = iomem_write32,
 	.write32be = iomem_write32be,
+#ifdef CONFIG_64BIT
 	.write64 = iomem_write64,
 	.write64be = iomem_write64be,
+#endif
 	.read8r = iomem_read8r,
 	.read16r = iomem_read16r,
 	.read32r = iomem_read32r,
@@ -332,6 +344,7 @@ unsigned int ioread32be(const void __iomem *addr)
 	return *((u32 *)addr);
 }
 
+#ifdef CONFIG_64BIT
 u64 ioread64(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
@@ -345,6 +358,7 @@ u64 ioread64be(const void __iomem *addr)
 		return iomap_ops[ADDR_TO_REGION(addr)]->read64be(addr);
 	return *((u64 *)addr);
 }
+#endif
 
 u64 ioread64_lo_hi(const void __iomem *addr)
 {
@@ -411,6 +425,7 @@ void iowrite32be(u32 datum, void __iomem *addr)
 	}
 }
 
+#ifdef CONFIG_64BIT
 void iowrite64(u64 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -428,6 +443,7 @@ void iowrite64be(u64 datum, void __iomem *addr)
 		*((u64 *)addr) = datum;
 	}
 }
+#endif
 
 void iowrite64_lo_hi(u64 val, void __iomem *addr)
 {
@@ -544,8 +560,10 @@ EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
+#ifdef CONFIG_64BIT
 EXPORT_SYMBOL(ioread64);
 EXPORT_SYMBOL(ioread64be);
+#endif
 EXPORT_SYMBOL(ioread64_lo_hi);
 EXPORT_SYMBOL(ioread64_hi_lo);
 EXPORT_SYMBOL(iowrite8);
@@ -553,8 +571,10 @@ EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
+#ifdef CONFIG_64BIT
 EXPORT_SYMBOL(iowrite64);
 EXPORT_SYMBOL(iowrite64be);
+#endif
 EXPORT_SYMBOL(iowrite64_lo_hi);
 EXPORT_SYMBOL(iowrite64_hi_lo);
 EXPORT_SYMBOL(ioread8_rep);
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 374b9199878d..79091a86103a 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -28,6 +28,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/iommu-helper.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -127,14 +128,21 @@ MODULE_PARM_DESC(sba_reserve_agpgart, "Reserve half of IO pdir as AGPGART");
 ** Superdome (in particular, REO) allows only 64-bit CSR accesses.
 */
 #define READ_REG32(addr)	readl(addr)
-#define READ_REG64(addr)	readq(addr)
 #define WRITE_REG32(val, addr)	writel((val), (addr))
-#define WRITE_REG64(val, addr)	writeq((val), (addr))
 
 #ifdef CONFIG_64BIT
+#define READ_REG64(addr)	readq(addr)
+#define WRITE_REG64(val, addr)	writeq((val), (addr))
 #define READ_REG(addr)		READ_REG64(addr)
 #define WRITE_REG(value, addr)	WRITE_REG64(value, addr)
 #else
+/*
+ * The semantics of 64 register access on 32bit systems i undefined in the
+ * C standard, we hop the _lo_hi() macros will behave as the default compiled
+ * from C raw assignment.
+ */
+#define READ_REG64(addr)	ioread64_lo_hi(addr)
+#define WRITE_REG64(val, addr)	iowrite64_lo_hi((val), (addr))
 #define READ_REG(addr)		READ_REG32(addr)
 #define WRITE_REG(value, addr)	WRITE_REG32(value, addr)
 #endif
-- 
2.37.2

