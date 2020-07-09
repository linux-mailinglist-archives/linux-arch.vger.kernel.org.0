Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF821A8A8
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGIUI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgGIUIR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42895C08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so1460911pfq.11
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=QnurR7K6BPRfnTLUtwHY4Q88UHUkQ5JhJ6oRLe/Vy2I=;
        b=mUoQh16LfS76JjXiApvCLtUURIrln8QBy4z4KJ9cxNLpVN1HsGpQr1kBYvlfEpIda/
         LoU2sTePgiPsVUktY9PLay5T/LWuA3SDlvl4EC+tzu4MnafyF/ciaZHGkNU/HG8T9OpE
         KVzeCoEIRng2pW5XYTVTkZpES51Xe5P8EaOR57UDK6McQDJBkaQ7s22u07OnYIAhRxj3
         8Kym3DKDmDIbQhedwXAnH996hmuesUoUcKdZZw2jmgUP8rky9R9IycIEElXJJBJQ9h6D
         EwVHGVT8826dl07WOOq2aung0LV8qgk3FPr4NBe71Evllt8Mlkwq1HzZ++bm+1vYZdAP
         KcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=QnurR7K6BPRfnTLUtwHY4Q88UHUkQ5JhJ6oRLe/Vy2I=;
        b=Y3FHuI7MFrrY0z9IY28Dv+wDqouKJLwo7GqUUj2gGkWbYCZ8s+QYhcfr6D/hv3Std5
         qr80w59rqwj7mVD3qhC2bXvd+lJ/VvHDnKoalOsFZ20j0uv2/yKsydzuO92deSvvO4tE
         iBz6Uphkl2oHw9g1ke+a1ja/EzRMSLOehxmnGH+YPaDx+XIokfc5Msclsu0klZASdhNo
         1qhSU4NxyBmUui1xliQCxNBIS1gcXEuHljR6Hak8aJLAsmL8RgVNcJtytRKRZfmSwSa8
         LMotL+wCyXcpsCoNL2Bh+C2jszhi+vT+w+FyeePXe5L7L6np+LED8MF8ye6hQLif7DWA
         j2Cw==
X-Gm-Message-State: AOAM530g7H/BKcFBDF4+biRi0DrMfqCfxCf97qW+xAWe2EYfLutJOIcK
        3cciyvk1HFjrV/1nesqSq+rlpQ==
X-Google-Smtp-Source: ABdhPJxPyfDF7MMhraNjxGcxjmelZhmosqxz9Rr+wxAOwY45CYkRfCLmLvGQVfIwcidfX5xstsKX8g==
X-Received: by 2002:a62:2c48:: with SMTP id s69mr18582019pfs.63.1594325296622;
        Thu, 09 Jul 2020 13:08:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m9sm3442448pjs.18.2020.07.09.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:16 -0700 (PDT)
Subject: [PATCH 3/5] arm: Use the generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:50 -0700
Message-Id: <20200709200552.1910298-4-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, zong.li@sifive.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is exactly the same as the arm64 version, which I recently copied
into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm/Kconfig          |  1 +
 arch/arm/include/asm/io.h |  1 -
 arch/arm/mm/mmap.c        | 22 ----------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..0c9da68835c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -54,6 +54,7 @@ config ARM
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index ab2b654084fa..fc748122f1e0 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -441,7 +441,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
-extern int devmem_is_allowed(unsigned long pfn);
 #endif
 
 /*
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index b8d912ac9e61..a0f8a0ca0788 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -165,25 +165,3 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return (pfn + (size >> PAGE_SHIFT)) <= (1 + (PHYS_MASK >> PAGE_SHIFT));
 }
-
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain
- * address is valid. The argument is a physical page number.
- * We mimic x86 here by disallowing access to system RAM as well as
- * device-exclusive MMIO regions. This effectively disable read()/write()
- * on /dev/mem.
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

