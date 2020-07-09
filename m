Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2E21A8A4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGIUIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIUIU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35182C08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so1478647pfm.4
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Ei0TWvmSq4hVDTuU6LZYzruvqRF7MqwjJV4bz0WiKYA=;
        b=vtT5TnAiVeMv5AwYFOXrUp/RFcwllz1Ts2sQQMp1v6UHnsh+/l149KmZE9zelQji2P
         Wm8rWwY9hflE/9btdDlNCKnMrtEMHuhH17tW6kIO0swAvBwNc8EnAS5+lFIZd/s354VW
         DD7YgymIcJMir17cPMRtmC1k0f4A36wMdLDcxyujJjdABW0nyvD+niFSyHyeB9KBXhFr
         Yn8r0aG18vn2ZykWl99u77GpcsbG/IG7pEYVqSBJiu1TZz+E4zXsuO1TXr5+gtMuUA+V
         q17hKo54X627DvG3UEk1PJBK4gYKhzbiX+sg65RUeP+cdAICZuyQ1b4DCnDr+02afKg9
         U8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Ei0TWvmSq4hVDTuU6LZYzruvqRF7MqwjJV4bz0WiKYA=;
        b=M+VcQlQAeDEeEAcALlqsJIsyjxDcYZnSwrbLoHmZ+UJrjbWJNoAEZECeHY/0+HpgDg
         ifuYsAqH0sLbCYbmEjOMNzqgsK5q8neoVQM6u+vaHzU+x0rmrpYsRaav1n8IsSZMwjE7
         NROIPZ6f4g3BRCjx8zIvsTtmgRjPHONij+NzVsgc5vja1Wdf2aXdDJUom4obCRqe2v4A
         o1SoH9XPuv/M/M6GpHuaazvq3fizj/yQ9m4UJcudNiXWyYRpsEaLmATvFsNa+FIXOU81
         UCwqsxZtGFhQ84RSXUWhKPxD9kvkHVm3T2LFslleBtfoXKKGc8xH2yP80ig1D+85g5/O
         dNvA==
X-Gm-Message-State: AOAM533VvHVJ7DdN5ivk+owx15PkSP0rPAFiNnJlWM50GYGofmCnBP4D
        uOr2W6OYNRLQjk8zLE3c75USqw==
X-Google-Smtp-Source: ABdhPJzstPC+eyNkZHH2mSMbiN4JBEyCw7jM/7s8GEh2zAKiRjXBj/1M4nmOotoZA7M2JYQpI2qnvw==
X-Received: by 2002:a63:b18:: with SMTP id 24mr57916489pgl.406.1594325299526;
        Thu, 09 Jul 2020 13:08:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ji2sm3404749pjb.1.2020.07.09.13.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:18 -0700 (PDT)
Subject: [PATCH 5/5] unicore32: Use the generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:52 -0700
Message-Id: <20200709200552.1910298-6-palmer@dabbelt.com>
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

Aside from being inlineable, this is exactly the same as the arm64
version, which I recently copied into lib/ for use by the RISC-V port.

[I haven't even build tested this.  The lib/ patch is on riscv/for-next,
which I'm targeting for 5.9, so this won't work alone.  See the cover
letter for more details.]

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/unicore32/Kconfig          |  1 +
 arch/unicore32/include/asm/io.h | 23 -----------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 11ba1839d198..5334f51614a5 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -12,6 +12,7 @@ config UNICORE32
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

