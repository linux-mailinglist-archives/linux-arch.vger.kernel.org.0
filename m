Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B92421E1E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhJEFnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhJEFm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:42:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054DC061755;
        Mon,  4 Oct 2021 22:41:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk10so3935489pjb.1;
        Mon, 04 Oct 2021 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+gtm0FLiMCt+Nb3OshbuVKuaLsIbndL4E6g0IJn8HQ=;
        b=L8xA9w4w8Rd7cNvQadVMnTrZvaZFgxRq7dW6P1GadvxJGr/nfOKQTf9ec/x8hzjuZm
         5Y4hRjmqlq9CQn/t0FKiap8tey2OfdEKflaN50VfBolwx/xZDgWNyqCsDGxmqYa0HLRo
         APx4sQzVHNf0/of3cwjbHfOSJW6XqLKYW9CZJDCvMcUCiY0B5YxJG+FwJ1a2R0K3NR11
         JqLzhCXpv+HqluHVJ09H52c2JD3WAbRqfoSDUHWXLmUcunTA/GaKa3t6ch9FL1uZxwzC
         5vOmyW0i0EYnkJV8h103u1aEsJf7bdZkkVcaHemEuBmaA3oTa/SBNUrKrWqrHB7/kXgC
         fqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+gtm0FLiMCt+Nb3OshbuVKuaLsIbndL4E6g0IJn8HQ=;
        b=J1ZtHsj3LoIKzZII/mt/cKdWskLygP9w14muiwSDji11ZkjD5BX4X+GJhBxQ3G2s63
         cO3e4aVqSzEB+EtizIIkGSaAn9am3gicOyN4iV3m64/KPdVLtgGboWpefNPIf3eDQxEa
         AryRpZuEMVtjkWSZQVw5QY4mrAOJqq+4eI1oNheRozUX685jhm6HbgkuPYvTWAk8lB7q
         mW4S+tx17jIg7jUtj7Kr8vvp8L4SCQuxnCeu+JqCwnWybSsEHhr7jeyIdtVyFcSQw8ps
         ZiEbxKTDUy3Wta/iDWoBe5eVbPMlo4CR7UR69CU4Hl/fG/XYx/dv4lkjC7F2Z428pbbP
         EtjQ==
X-Gm-Message-State: AOAM5330kKUFpIX35HjqdJi/rEv0TEs9nqYxsNXfu1NKn6sc7CwLon0u
        1qdmKfJ0phodoJsZsuODYOQ=
X-Google-Smtp-Source: ABdhPJxvGk07vscajxuvSw6VrQ8+TooSl11ye1kjtzPBe1RxEq/KwMNNWd+616JmBDxJHW3IuMqN8A==
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id w2-20020a170902a702b029012baa0fd553mr3492706plq.3.1633412469416;
        Mon, 04 Oct 2021 22:41:09 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id e22sm15695744pfn.101.2021.10.04.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:09 -0700 (PDT)
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
Date:   Mon,  4 Oct 2021 22:40:47 -0700
Message-Id: <20211005054059.475634-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
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
index ab83c22d274e..8a2c61f732ee 100644
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

