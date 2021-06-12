Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23D33A4ED6
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhFLMjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhFLMjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:39:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E75C061767;
        Sat, 12 Jun 2021 05:36:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v6so4794786qta.9;
        Sat, 12 Jun 2021 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSNF8nbe1+6ZsC7OdwqwTkbXa4vxQZ6BP8CxfFwPpEA=;
        b=adum1IKzOGmQJOJBAsISKtvTNWcH+jDyt+IcIQHxl52VuQYxbTLBw3SrK7Pxagcvy9
         LVlxV9r3078ugf9RSZbepZk5L6La9CO6zhcsjCHHMYm/keEkd6+K0glqhysmHQs2E0Z2
         f/mb/baheYr3lshTj/zsonVjZqKcBG8RcVlu2KIN22jWx+YnTxf1893laD9OjosWJvq2
         XlEwO6fDdmF3f9feG4/IDC4rmdBQD5cKKlu0dhlzcNnt/+tuEXEfCWAIJVkn8kRrd2mW
         /GPqcYdsvYmYZT7Ym0Ru0CKMhfGUjrOBq5ApQw2UjU+62Iojx2MSZPvBT/9yO8Zddlaf
         vGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSNF8nbe1+6ZsC7OdwqwTkbXa4vxQZ6BP8CxfFwPpEA=;
        b=Xcllp0zqrfPcK7eEtVqYYvkO5wncdNAv84y165sPT+Gfo5s/Y7nfiy5/GQ9CnXJ/0v
         hbKxOPjtY4RRTEsZ6IPHqLfSYsygpFA/NVH3fSjBxA8MJfzzQnWyKmh2Vd7hiOh1I1uC
         mCxxaFmOlVKLNWM13iU2acm7Y4/0ox47DK1SuTYqM7OX/AEW7J4EI80JTQfwpIfA3nDD
         LY7iXzyYW2BGtf/niPrma2fWp819ZQW9o9SMzW2pyJo5j+ZN8XDjfwzr4uiWVO9T9Qmd
         sCLa2Qm2EiZhJ2iUSs1/7nes+o4EJSFlwqHx3b3/WNAhI1/qiZkft70kvaUinvMWV8lQ
         zwzg==
X-Gm-Message-State: AOAM530t+BWEraDU8vZspPN64VIorr13K1OEisloiKeqapSN8Y+8urXp
        TAnKxPRPiS4P+7+mF4A+cwuy7DUxs/7KJA==
X-Google-Smtp-Source: ABdhPJzQzLkEWBTBUcCNhE51h8gFTVtm+VQttQxpy62bTweZ57EM1YGGpIRRfE3wSt31jPBsYUMpSA==
X-Received: by 2002:ac8:44c8:: with SMTP id b8mr8065811qto.191.1623501408930;
        Sat, 12 Jun 2021 05:36:48 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id h14sm6072134qtp.46.2021.06.12.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:48 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH RESEND 4/8] arch: remove GENERIC_FIND_FIRST_BIT entirely
Date:   Sat, 12 Jun 2021 05:36:35 -0700
Message-Id: <20210612123639.329047-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In 5.12 cycle we enabled GENERIC_FIND_FIRST_BIT config option for ARM64
and MIPS. It increased performance and shrunk .text size; and so far
I didn't receive any negative feedback on the change.

https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gmail.com/

Now I think it's a good time to switch all architectures to use
find_{first,last}_bit() unconditionally, and so remove corresponding
config option.

The patch does't introduce functioal changes for arc, arm, arm64, mips,
m68k, s390 and x86, for other architectures I expect improvement both in
performance and .text size.

Tested-by: Alexander Lobakin <alobakin@pm.me> (mips)
Reviewed-by: Alexander Lobakin <alobakin@pm.me> (mips)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arc/Kconfig     |  1 -
 arch/arm64/Kconfig   |  1 -
 arch/mips/Kconfig    |  1 -
 arch/s390/Kconfig    |  1 -
 arch/x86/Kconfig     |  1 -
 arch/x86/um/Kconfig  |  1 -
 include/linux/find.h | 13 -------------
 lib/Kconfig          |  3 ---
 8 files changed, 22 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2d98501c0897..aa1ce528ae23 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -20,7 +20,6 @@ config ARC
 	select COMMON_CLK
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
-	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7c17f03e99a1..207e6fce26d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -118,7 +118,6 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ef5dd91e83b4..5d5adf63005b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -30,7 +30,6 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8de7b3150e93..996cee2b7a3d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -125,7 +125,6 @@ config S390
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39175aa072e2..fd6bbbdc2f7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -133,7 +133,6 @@ config X86
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK	if SMP
 	select GENERIC_IRQ_MATRIX_ALLOCATOR	if X86_LOCAL_APIC
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 95d26a69088b..40d6a06e41c8 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -8,7 +8,6 @@ endmenu
 
 config UML_X86
 	def_bool y
-	select GENERIC_FIND_FIRST_BIT
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
diff --git a/include/linux/find.h b/include/linux/find.h
index c5410c243e04..ea57f7f38c49 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -101,8 +101,6 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 }
 #endif
 
-#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-
 #ifndef find_first_bit
 /**
  * find_first_bit - find the first set bit in a memory region
@@ -147,17 +145,6 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
-#else /* CONFIG_GENERIC_FIND_FIRST_BIT */
-
-#ifndef find_first_bit
-#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
-#endif
-#ifndef find_first_zero_bit
-#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
-#endif
-
-#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
-
 #ifndef find_last_bit
 /**
  * find_last_bit - find the last set bit in a memory region
diff --git a/lib/Kconfig b/lib/Kconfig
index ac3b30697b2b..2663c36a6220 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -59,9 +59,6 @@ config GENERIC_STRNLEN_USER
 config GENERIC_NET_UTILS
 	bool
 
-config GENERIC_FIND_FIRST_BIT
-	bool
-
 source "lib/math/Kconfig"
 
 config NO_GENERIC_PCI_IOPORT_MAP
-- 
2.30.2

