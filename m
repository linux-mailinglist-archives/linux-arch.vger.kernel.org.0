Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53321A9AB
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 23:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGIVUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGIVUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423CC08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so1659360pjw.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=mwiqaheWU8Sd0guj2IwnvydGK+iHxoHpd+MuCk0aqII=;
        b=Uw061yOt7OeddQFKqaypRf5R2yIYdjOMOco3/+7Alxe2a1baKGudlPSVh2eRLk7Agm
         8GH7xetKjHjyKvOR1maVuUSTL0g9axXGDOKBsrj6j4djlKTpJrtJOkuLosO1YBecrWNf
         mKLBekf+OdiRN2/d4pLs5meFRu2mTzSdTIh2kYwSOvbK5XV6Qdk9hzMsOvWyOEwph0lY
         nZXbVUMuQnzuoK6DHvluQhnGwVAysRvICuO3JkkOnD44v6VSohj7e0RNS5pkqkHtbs4h
         VoMPZBsazXY/0R9hYqmSNyVteIruHr5UH6yb0Dbke9x+lreLXrYB9DXqqVEfOe+lUtGc
         GUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=mwiqaheWU8Sd0guj2IwnvydGK+iHxoHpd+MuCk0aqII=;
        b=riJDuVxcWfPkGLXXbaGwnbusZkMbcd5AMwULGUoAZeG2N5+cmGsU/1TnFZ/0FYtbZ7
         aded6ZFv37edtkabafA53MxVU/yCRflws5vicdilW36WCDa573DtX9zVXr3xzWd0YI+c
         s6Cj4i3s9Rj14kbW9jIsaKMe7csYb2q5GlWZQzI3sI/kGislXaour/nH2zosNNe2vW3L
         4tTu81TJpwVblXyn8ULpAEoB5yvUiJ81fFp//XciSHB8/gfLUKxiec0ofP2fLqJmCgPX
         VHQrxOaz3uRscypDeWy3S8NXSuq6hXsuOsDZ6DHUpMiH1MpUDXHbBCwNGmhG7wsHZceZ
         lVXw==
X-Gm-Message-State: AOAM530sBTS4w8XxbPdaRPa61Cts5yFjUzpIVkVQcW/yZL8n+TRBD/Zp
        MO/WttlcsAjW1qCHDivGMAjW/w==
X-Google-Smtp-Source: ABdhPJzLsRo3etfu0HhpC+DBT4gHVQ7ocsi70IQCb8hFwx9+nia8o+Hy+mBoiPb4zdhaZgAHcr7OEg==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr1955691pjb.21.1594329634168;
        Thu, 09 Jul 2020 14:20:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x7sm3694230pfp.96.2020.07.09.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:20:32 -0700 (PDT)
Subject: [PATCH v2 5/5] unicore32: Use the generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 14:19:25 -0700
Message-Id: <20200709211925.1926557-6-palmer@dabbelt.com>
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

Aside from being inlineable, this is exactly the same as the arm64
version, which I recently copied into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/unicore32/Kconfig          |  2 +-
 arch/unicore32/include/asm/io.h | 23 -----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 11ba1839d198..7610571044f4 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -2,7 +2,6 @@
 config UNICORE32
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -12,6 +11,7 @@ config UNICORE32
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PCI
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
index bd4e7c332f85..4560d2531655 100644
--- a/arch/unicore32/include/asm/io.h
+++ b/arch/unicore32/include/asm/io.h
@@ -42,28 +42,5 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
 #define PIO_MASK		(unsigned int)(IO_SPACE_LIMIT)
 #define PIO_RESERVED		(PIO_OFFSET + PIO_MASK + 1)
 
-#ifdef CONFIG_STRICT_DEVMEM
-
-#include <linux/ioport.h>
-#include <linux/mm.h>
-
-/*
- * devmem_is_allowed() checks to see if /dev/mem access to a certain
- * address is valid. The argument is a physical page number.
- * We mimic x86 here by disallowing access to system RAM as well as
- * device-exclusive MMIO regions. This effectively disable read()/write()
- * on /dev/mem.
- */
-static inline int devmem_is_allowed(unsigned long pfn)
-{
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
-		return 0;
-	if (!page_is_ram(pfn))
-		return 1;
-	return 0;
-}
-
-#endif /* CONFIG_STRICT_DEVMEM */
-
 #endif	/* __KERNEL__ */
 #endif	/* __UNICORE_IO_H__ */
-- 
2.27.0.383.g050319c2ae-goog

