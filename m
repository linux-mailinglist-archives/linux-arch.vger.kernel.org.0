Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15421A9A7
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGIVUe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGIVUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6403EC08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so1515616pgc.8
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=R0X1WZiPa2fv/zPPPrCWvHiss6LlgCawfrwgKo9wAMU=;
        b=gHoLY2mtRy2ScjxyuU7UsDUQjCloeYrxHdCuOW63TOSDuG02GQ35kF/ylikEl8Ya8V
         jbx3MsCzDDDcPG9nbR+Ddp8VGV5f+jDaUCgwrX/EDB9h4i2spUvJqaJDrO8f/G5mvWJE
         i/7qKFp3mlbDr7KLFASIIxN6vAzUqO7BlOBUMRzsCm9dCWViZWxg0yswjNw3vSlBTGWO
         G7bZj3dRDvqd1w+MrGemymGoAPVPlAFirxj3wssQCJvpPgcPzQ4YNOIDJKxJSrkgQXwf
         jp1ijvO5miBXTJ3Ri+lin++jIIdopk1Yq5ynG3ainRkBaa1s9vUBXdU8Di+fxe09sC+Z
         yfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=R0X1WZiPa2fv/zPPPrCWvHiss6LlgCawfrwgKo9wAMU=;
        b=UY04idvAT/loi6Si4vcI4CUxOilKnV38OvRRSpS96AM2D1yChPMjVVaC2jZE8auUs0
         KepW2Yz+eYfIle82URGrG3ZwwTv16N1FEcogPf9SqIWwJjJCFXdj2IGoVP+ULbyvoIh9
         DUNC6KOkQvMmbjDTqI3a7TqclI7s/o9WR7MVpNq+FcWB0nvgrA0oDjsxlhM5B4fIDbCk
         vzVPPgkIyYFabkLwncwCrS+P2gqyLCitJRVj7go3C3JcBETwQQjgJ8lwO5Qb4kFP4+bI
         Go/gMKO5w2R87+cr8fH2kSJLp2y9ygEG/vdvUnOhAlJQcCwakRgZhpx/sHZldq/CvW7e
         ruLA==
X-Gm-Message-State: AOAM530RD3gEmxdI/xldXuCbsYpZiwE3nzpRK0XBP8VJ8R5oZrylx/o2
        TZ/O0JwoZ/R+wJPWWApqra3YNQ==
X-Google-Smtp-Source: ABdhPJyOOQ3prvzFKDsLYd+p2HeWmGcehQ0vzPmqHYcXilIeLzPEBpHNjdro1JFnj0KAUzSGeeCVJw==
X-Received: by 2002:a62:a217:: with SMTP id m23mr28290249pff.291.1594329630762;
        Thu, 09 Jul 2020 14:20:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y19sm3926535pfc.135.2020.07.09.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:20:28 -0700 (PDT)
Subject: [PATCH v2 4/5] arm64: Use the generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 14:19:24 -0700
Message-Id: <20200709211925.1926557-5-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com,
        broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net,
        rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org,
        krzk@kernel.org, zaslonko@linux.ibm.com,
        matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org,
        clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I recently copied this into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm64/Kconfig          |  2 +-
 arch/arm64/include/asm/io.h |  2 --
 arch/arm64/mm/mmap.c        | 21 ---------------------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..0682672cb244 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -13,7 +13,6 @@ config ARM64
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
-	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_FAST_MULTIPLIER
@@ -110,6 +109,7 @@ config ARM64
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ff50dd731852..c53eba1a7fd2 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -200,6 +200,4 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
-extern int devmem_is_allowed(unsigned long pfn);
-
 #endif	/* __ASM_IO_H */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 3028bacbc4e9..07937b49cb88 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,24 +47,3 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
 }
-
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain address
- * is valid. The argument is a physical page number.  We mimic x86 here by
- * disallowing access to system RAM as well as device-exclusive MMIO regions.
- * This effectively disable read()/write() on /dev/mem.
- */
-int devmem_is_allowed(unsigned long pfn)
-{
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
-		return 0;
-	if (!page_is_ram(pfn))
-		return 1;
-	return 0;
-}
-
-#endif
-- 
2.27.0.383.g050319c2ae-goog

