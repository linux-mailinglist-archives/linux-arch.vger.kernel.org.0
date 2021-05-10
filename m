Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A49379AC5
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 01:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEJXff (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 19:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJXfd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 19:35:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71BC061574;
        Mon, 10 May 2021 16:34:26 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f8so9180189qth.6;
        Mon, 10 May 2021 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBkKGU/ki1TRk8sMHAAIgbib+6nzNUIdtQYyvnJ5USQ=;
        b=CxW+dEAVXDk0b2mz4xXAAOo7sYkrFcE5NyMGbLT9v+fVGYHFySZSszVTHx4H/liqji
         Xeq5aF0hmaVzNedK+/d1+rTH5aIzQVpZxviWs9tQSVhAQHdsHYpsiGrXFh9u5DhT9Zdg
         UOLuhNpNuPl6307+StHDNUrYjsb6XR8CheLiAeP54NkA0/tKve4OYAUOIvtsTBmfYqfX
         HaUySPfTrhoIhD7m1OE4acogxJl33PpXBFRPV5BXoAowrb44D61fGrkf9BsTxNXaH0w4
         Q3sirpM2o1JXsSpmWHU/B7y+310h8D691jnYP+y8aTs+tcl8mr76M1RU+hghStXgptK/
         m1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBkKGU/ki1TRk8sMHAAIgbib+6nzNUIdtQYyvnJ5USQ=;
        b=QLT8TjWGD9WqHlkyHuC2lzMYLc1Cd0gzazxwpTVwQbo/CU9q51N9HXY3gUvjkeKqv/
         WjWMDXeepjubPeXq+m00+xFoGUtVlf46hrVkOMDUsi/wBVWNjuRW3ImDKp3mgMNkeDFX
         tE1uHh8uQPriAI2FebSJf2IncdwZ3xKTIMKmjkJAqxW7MXkaKUyIDhCXgMzImP1y75BA
         z81pQB4YG00NkH9Azf14dUJYOS3DwMovzZzivf2Mix3BfRoTbo/0gPA6VFcJz/pkdIkK
         0FGqk4KKMJ4ZpwbemEQd5Wk+L7gGZvXGzlbxZjcjT8Lee84kMciPoQ3ZkUH6a4uXzJSk
         E/+Q==
X-Gm-Message-State: AOAM5339LvzZLcI3Mm+43JJQCIKNgLeLyVNs2dny/9gay5c/6Ujc2mUE
        ektDForauqgi7zWj12NY7SEXxrGpkhdVDA==
X-Google-Smtp-Source: ABdhPJx3h/hkHoHuys3vF3Pv9tha50NlDAjZ7yH2vb6gQ0kPvY6LQcUL8DPQUTXcb5C3DWHyADBvBg==
X-Received: by 2002:a05:622a:2c9:: with SMTP id a9mr10456062qtx.38.1620689665622;
        Mon, 10 May 2021 16:34:25 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id z4sm12639919qtv.7.2021.05.10.16.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:34:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nick Terrell <terrelln@fb.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, Yogesh Lal <ylal@codeaurora.org>
Subject: [PATCH] all: remove GENERIC_FIND_FIRST_BIT
Date:   Mon, 10 May 2021 16:34:21 -0700
Message-Id: <20210510233421.18684-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the 5.12 cycle we enabled the GENERIC_FIND_FIRST_BIT config option
for ARM64 and MIPS. It increased performance and shrunk .text size; and
so far I didn't receive any negative feedback on the change.

https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gmail.com/

I think it's time to make all architectures use find_{first,last}_bit()
unconditionally and remove the corresponding config option.

This patch doesn't introduce functional changes for arc, arm64, mips,
s390 and x86 because they already enable GENERIC_FIND_FIRST_BIT. There
will be no changes for arm because it implements find_{first,last}_bit
in arch code. For other architectures I expect improvement both in
performance and .text size.

It would be great if people with an access to real hardware would share
the output of bloat-o-meter and lib/find_bit_benchmark.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/arc/Kconfig                  |  1 -
 arch/arm64/Kconfig                |  1 -
 arch/mips/Kconfig                 |  1 -
 arch/s390/Kconfig                 |  1 -
 arch/x86/Kconfig                  |  1 -
 arch/x86/um/Kconfig               |  1 -
 include/asm-generic/bitops/find.h | 12 ------------
 lib/Kconfig                       |  3 ---
 8 files changed, 21 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index bc8d6aecfbbd..9c991ba50db3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -19,7 +19,6 @@ config ARC
 	select COMMON_CLK
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
-	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e09a9591af45..9d5b36f7d981 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,7 +108,6 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b72458215d20..3ddae7918386 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -27,7 +27,6 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c1ff874e6c2e..3a10ceb8a097 100644
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
index b83364a15d34..6a7d8305365e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,7 +123,6 @@ config X86
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
diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 0d132ee2a291..8a7b70c79e15 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -95,8 +95,6 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 }
 #endif
 
-#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -136,16 +134,6 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_zero_bit(addr, size);
 }
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
 
 #ifndef find_last_bit
 /**
diff --git a/lib/Kconfig b/lib/Kconfig
index a38cc61256f1..8346b3181214 100644
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
2.25.1

