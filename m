Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34F3EC568
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhHNVSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhHNVSV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:18:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7DC0613A3;
        Sat, 14 Aug 2021 14:17:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so26166487pjn.4;
        Sat, 14 Aug 2021 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=za+zWNJDU/3F0ZiEfFZ8ek3a7aWT/E1uFDJjU1HEbfc=;
        b=Em2OdIePOUYTYSsf2rAAY+I+24KTdEd/bl8Yc69dRglboswkDh4J3PbE7OMyEvjPGz
         uPCMDYN0EMHgmZHctr+o88JA4Ty1rKivAtLtir6MO1vWC9d3VgtEs0ngl3dyqdCQQCDI
         x3/USZ9Mry20Tj1EMiFTk8Dw63Ds7Q39f124M7WqjojCxBNImorH1wyfN6bJ4ZfdgZzg
         2EhPk7BKfUveDRWJK0rruSRMbhEG4CnBu430ws8PFH8P7F6TNxrUSi3lpIarYc4rgME3
         cyGRU4rYHQ78PGzwMWaL5RRReSJCfokQPzZr7zS0lFr0Or5LIPi1IUYwxqWrCWchaBc7
         Hwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za+zWNJDU/3F0ZiEfFZ8ek3a7aWT/E1uFDJjU1HEbfc=;
        b=sV4WM3f+K55xNSzEhBNRctYvq5L+D3F7SjiOq7xVAxwTRWqaf6s5XRPAj1T9ePKrmL
         ntZwhym1qqydj7i5O3O4ZQMjCy9gvhbGKIAxqIfqVlwZ3eJQ0tlyGlsnvOEZl9TciRuN
         JeJQbnAThf3db9q79SAZdw/829RCNKjou72j0Jof5silb3oP9nU6RKOarmv6YptgX3r6
         106jhHxEQ1uWWKiC0sB4ghjn3Ep47cZ/4uQjb2Y3A8RwlqMT5WjDsAYls0VZDBopqA6p
         qRCCfau+BtGO4yizhi8U14FIXu/wPrxRY6mNBgnmM/yVhXy4VnZYBs4NLNu8ySgwldK8
         mNzA==
X-Gm-Message-State: AOAM530v9d66ETu8AUna0wGcG7pF4sOCwf2U1k4dauy51WOdhzFYQF8N
        99iPGyMHwCFJ3nNVVWaskwE=
X-Google-Smtp-Source: ABdhPJxQZ9uTw/UwZstpMfHvv66bKP7iRO13IDSl+JxB6n9JLGqhrX5SU3PEKCUyAISjyxGlLasm4A==
X-Received: by 2002:a05:6a00:a94:b029:384:1dc6:7012 with SMTP id b20-20020a056a000a94b02903841dc67012mr8493709pfl.53.1628975871491;
        Sat, 14 Aug 2021 14:17:51 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id l126sm7733007pgl.14.2021.08.14.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:17:51 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 04/17] arch: remove GENERIC_FIND_FIRST_BIT entirely
Date:   Sat, 14 Aug 2021 14:17:00 -0700
Message-Id: <20210814211713.180533-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
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
index 53d143fc42fe..f35994edc165 100644
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
index fdcd54d39c1e..7b2269ad3e12 100644
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
index da874375fa4b..d7758c8f7e37 100644
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
index 92c0a1b4c528..7a3bbaf19640 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -126,7 +126,6 @@ config S390
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 45962aaf2b2c..7edce30dc214 100644
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
index 5c9c0687f76d..f8874240835b 100644
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

