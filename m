Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA215AC1A3
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiICWrd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 18:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICWrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 18:47:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F84DF1F
        for <linux-arch@vger.kernel.org>; Sat,  3 Sep 2022 15:47:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v26so8233181lfd.10
        for <linux-arch@vger.kernel.org>; Sat, 03 Sep 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pyzrYCFsu3Tk+LfiPXHbfpCSpsNEhe4uYnmQekdTRlc=;
        b=StyNg8Odci9qoHo2+gz/asuc1mLOow0/KQ1X2kA5wr/CsP6NAS8WEicj7s0ylfxHRN
         3TPcxW+5JrfLJssKdObpBEtqY0n19OM4l2RmaIruSRYlCdirbAw6aHw3nOhWnn7BAr/z
         6hQ9Cahp8Cb3fGZLkY0wzqEhY147VzqJgXKL+YcMcstFpyXC9Pn6K2wPfDXbe1l47LVC
         roeXhw33CYXuIOEyIM9sFnrZ/p2yCgQQZtLEdy7UfY6Oc4ksgajEdSpIacw6QwabRFJh
         E3TcFaI+5X9tyJQDZchJcMPmN3UrafQV+YQ59M+Cm+oHXoZIDSH+X1VHu13mmue1qAch
         GuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pyzrYCFsu3Tk+LfiPXHbfpCSpsNEhe4uYnmQekdTRlc=;
        b=TMp9aKdj97v4TCiEFGGVgUp4/cxOxlkHcKxplxW3Co25vaXcLxTcTtr5o+9U5egiLX
         GAOcKujUKhQ7/VcSqhmGnXxFKSWb3bMwABNv6hwba2P0m60tyxpqylgiUY6lKWSd7n/I
         UhnGZtXtWrJU0BHFCBwfOhSMYVJOfht27X3DDc/cFrlt3TMqmRVKHh5Hr86XHifFMhic
         BR/MC6/zFZzBLzl4nVl1+JunKYZTKYGGNvRi56PL0qP8n1vyCLiRFooNCnqBD+/U9pUk
         LWwNqUV7nPZh2yscGiu5nbv6xe014gJDZjYZFczkGHBlYiW1mn5gQ1bGsCzaSwrFEOyT
         V3hQ==
X-Gm-Message-State: ACgBeo1rXoB7yKDtbX+3OYAcrNpbgWAuULLIRPnj+IqjR7vrIiTxzBQW
        nC+j8S7HlGfzCdJVlt8ubZLk5A==
X-Google-Smtp-Source: AA6agR56B8yb0smlgBSJIePviRf0M7WFWgul39Y8LBXeVBdMylGyIdvv5rAHq7ImsF1+ssWg+Y/7/A==
X-Received: by 2002:a05:6512:2525:b0:494:65be:f7c0 with SMTP id be37-20020a056512252500b0049465bef7c0mr10088855lfb.202.1662245249688;
        Sat, 03 Sep 2022 15:47:29 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r14-20020a2eb60e000000b00263f036b405sm673165ljn.70.2022.09.03.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:47:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH 1/2 v4] parisc: Remove 64bit access on 32bit machines
Date:   Sun,  4 Sep 2022 00:45:25 +0200
Message-Id: <20220903224526.553897-1-linus.walleij@linaro.org>
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

- Access any 64bit registers using _lo_hi-semantics by way
  of the readq and writeq operations provided by
  <linux/io-64-nonatomic-lo-hi.h>

Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Drop the explicit use of io[read|write]64_lo_hi() and just
  use readq/writeq provided from the include.
- Move and reword comment in the sba_iommu driver.
ChangeLog v0->v3:
- New patch fixing the use of IO accessors
- If the parisc people have no strong preference maybe Arnd
  can merge this through the arch tree with patch 2/2.
---
 arch/parisc/lib/iomap.c    | 24 ++++++++++++++++++++++--
 drivers/parisc/sba_iommu.c |  6 ++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

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
index 374b9199878d..ecd870087a3d 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -28,6 +28,12 @@
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/iommu-helper.h>
+/*
+ * The semantics of 64 register access on 32bit systems can't be guaranteed
+ * by the C standard, we hope the _lo_hi() macros defining readq and writeq
+ * here will behave as expected.
+ */
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
-- 
2.37.2

