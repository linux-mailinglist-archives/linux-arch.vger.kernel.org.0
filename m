Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4E21A8A5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGIUIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgGIUIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B0C08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so1472549pfc.6
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=yWhgfwfFiWb3PPj/shWsgqQNA2FBCAQDX3yO4Pd/fvs=;
        b=UidihMQgn2FU6yC2vnYywcLHy80gmEP9wasmFMA2FlkEOEYTxHQih0uQR6O7Clo+mX
         0vBe960gmixo51qTavUcsu7f79VBEK4Ea1o8CWFjYkwORC6cCPO9tlF95AOw76zlUqXG
         Wfgx4JfueZJ9c3aHa6PuHQZfF1qkaR/A8oUxBKoggm4NiQSkC5yZUVIZHjXnzNPJR4+g
         DpZHy1v1JfLzUmZT4WnmjLIiiDne7KMbo5woYP8NSZP1K5U3Dth0aVUglHKD1Bj0E5Jg
         Phtv3EtzK3PPX/5tDAhceOtP3IYeciop4OaIcjUai+E/BfoTXjh4QYa6Ppdda/hyZcQd
         jW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=yWhgfwfFiWb3PPj/shWsgqQNA2FBCAQDX3yO4Pd/fvs=;
        b=OfKKrua/xWlEQyNRZlyDpKAqK5eZ1eynSGlTLFV0J5qdpUT/U4XdTkjjh/fL81xDm1
         sd61QRWgElQgCX7sxJppVf83qCyP7cbKVaiGPZ+UJVXhQVuWsSmNpYzh1JuzpwqGGQQT
         Vwf8+Zdkmnrr0liveu5rO7Y4bKqatt5sOCBjUbMdBs14nBhi9e65pRpGag2G/OE/WkD4
         7tUuiUXiZVExBNjyIRz2KtdWdwMdbn6s1aHqo1dk0/OBWtUzBbp3zR986paGxJqfgysp
         VXOUHdMQcPADMgp+b2eOuUlJtXZW7ljmLQdn1qZgtQjX6Er0Vewoo99/Ey16P2SsCoBP
         KaiQ==
X-Gm-Message-State: AOAM533SqUiFOI4H0U+OoJvjwbBrAcB58tXH04IdNJJyWmeKZho3d+H+
        FABI/okSfqc/TrmfU5rpf4050A==
X-Google-Smtp-Source: ABdhPJw9INn3TgtDhWTqhvvgdVynTI7UXM1Nes0eUQhBvbIdfIkX0ekLoOzvL8jdp0+OswC8wE+weQ==
X-Received: by 2002:a63:6c1:: with SMTP id 184mr57192840pgg.262.1594325298146;
        Thu, 09 Jul 2020 13:08:18 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y65sm3499465pfb.75.2020.07.09.13.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:17 -0700 (PDT)
Subject: [PATCH 4/5] arm64: Use the generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:51 -0700
Message-Id: <20200709200552.1910298-5-palmer@dabbelt.com>
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

I recently copied this into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/include/asm/io.h |  2 --
 arch/arm64/mm/mmap.c        | 21 ---------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..0770ed21a8c4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
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

