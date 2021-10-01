Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B375741F497
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355892AbhJASPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhJASOm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F231AC061775;
        Fri,  1 Oct 2021 11:12:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s16so8696457pfk.0;
        Fri, 01 Oct 2021 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hccErX5nsuBThpX1Qxtkn5mCN3OYZEDoRlFj/Ybj3XY=;
        b=eNQv0zT9wFIYG2d9RSYmrbYF/9+gDMlyHEk2kCxhtt/BPba5Sa6Y5/Pfc21A6ZledH
         NtFvLtg8HbOvKS5ifSxU+3KRYS2usXEgtKbtZd+DX/QpMMZOK5UirtRqnYm5xg/23p+z
         6ogkTOE851LeQHkNWZYEVhX+qowpLguCDYor/H12IXwTFQhzwNx8YTvlRiEviEjX/eTm
         GyXPq3XvfYFNmGE6A2tVZkIAS67uVgKz5PysH0Fg53Obl0r1jf55RJNPaCmBjS/JUAu8
         b5HPVmRoG8a2lz+ORSVwDYeF11ChkSF2ZzOQmND+LCuidg42UMyCnQcOBSSviGD9wdBR
         G/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hccErX5nsuBThpX1Qxtkn5mCN3OYZEDoRlFj/Ybj3XY=;
        b=Sb7WoC1aKgPsxvcEC/Y9ZUxVTJmIxgYXZuoRSkyfIzDN12oJRe7HMCPPpPGB0Vtu+W
         vWWiFZ0bzJG69oUS4VxuooDLFzVmExBQbBVPBFXAfOpSxGdCm/pjG8ZtWOEfRH/3ZELs
         DPTZ0ppWSR1lKFVLj9KN0oPHe3pWw6VI+Qw4cWW2Xg3Qq4HOgih6WeczqBRIUMx5nKv4
         3AYZyq3CFsyJ05bJdAHngU+MchyY62hxkypPUVBGimheSa16/rCZokxXkQcZcjg9Eqeh
         cjVEphe36b7aFUgY3t+UxWFABXzYkkYPp9QViSwC9715trp6ipsJ/Ui2cNaWmMEEu3t3
         kpTw==
X-Gm-Message-State: AOAM531+VrlzzecfFzfMImSoFekv6jjj/XLEPaXqj6TbsnooPdgXqfOp
        D3cbzTxChE1IJarUEFE9n7w=
X-Google-Smtp-Source: ABdhPJxA5wXF+p/tCZI++lmXi6PcZUYKkyd8walyCE+sWHF8FNAQnVzD2aq4sck7AdI91wJlTtLa3A==
X-Received: by 2002:a62:1786:0:b0:445:1a9c:952a with SMTP id 128-20020a621786000000b004451a9c952amr11526450pfx.39.1633111977451;
        Fri, 01 Oct 2021 11:12:57 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q21sm6463234pgk.71.2021.10.01.11.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:57 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 04/16] arch: remove GENERIC_FIND_FIRST_BIT entirely
Date:   Fri,  1 Oct 2021 11:12:33 -0700
Message-Id: <20211001181245.228419-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Alexander Lobakin <alobakin@pm.me> (mips)
Reviewed-by: Alexander Lobakin <alobakin@pm.me> (mips)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
index 3a5a80f302e1..248389278e8f 100644
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
index 5c7ae4c3954b..abbd7b1e549f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -119,7 +119,6 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53af06d..0cf31a6cbee1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -32,7 +32,6 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b86de61b8caa..b0bb3aaec5f2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -127,7 +127,6 @@ config S390
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16e216b57863..8889bfa5597e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -134,7 +134,6 @@ config X86
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
index 5e7165e6a346..6a6ae5312fa0 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -65,9 +65,6 @@ config GENERIC_STRNLEN_USER
 config GENERIC_NET_UTILS
 	bool
 
-config GENERIC_FIND_FIRST_BIT
-	bool
-
 source "lib/math/Kconfig"
 
 config NO_GENERIC_PCI_IOPORT_MAP
-- 
2.30.2

