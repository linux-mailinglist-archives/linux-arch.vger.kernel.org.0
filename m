Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8958F3EC564
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhHNVST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhHNVSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:18:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6604C0617AE;
        Sat, 14 Aug 2021 14:17:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso15254080pjb.1;
        Sat, 14 Aug 2021 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zjHjMKSUrYafXQBIfrva8S6a35AyfuRK8qg7Rl0polw=;
        b=lJIaNFjwUWv7fuUBudkGt6mc8waeCb9aceY4G3QPFUb3iS96/W9yVkabexSGwy65F3
         jrSbsnprb8Rg9BlCrU5ApkLr/5vIaQ9mcwlaM1B+H61hFGwDUimOcKjWRCXXAi330zFq
         M2raPGH+NmrrfZWE+OOUbhrC8snbRo+eKSyJjrUkWmpfPtGCQ/lBSAYAN63oeWxXjUR/
         0mXl7t3S+NF3uGulXtjIjLxbeHi6+4Wjw4WLY8f5MgrT94AZh6gEkJx04H0+V1+R7NJE
         73ho5Sh4k56pCMEwMRMQ5JtylcKuHxfNdo5nc9cqxgiowEEQm9db3K9Yh5IhQbTsM78s
         TFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjHjMKSUrYafXQBIfrva8S6a35AyfuRK8qg7Rl0polw=;
        b=cI3Lo7Ehy66sN0ODsusUOD0XEcKOQBTdI0hlDl6rC0v+3H7nf9HxUz8xgVhhrmpxn9
         beCcE19gOG9P/A8X6NYbEYofSuqZTnDr0zQwnHMkElaQTdcgyb5DUlOCGLeI9hpnaSnU
         YGdanGJyGrG7oaagZOsU/A/v5rPYgPh54oOAufyRSvvC3Emk9sDpkzDvEvAg4J2pNAKL
         MBVC10t5pEgO4Fcxe79M1BTkzQSxiRKMZ1cq82ELidSYj0w3uqoPmQATJZ/vsIAZYE1b
         8zPbjEnqhvYDb+xJkIpb7bwDe/yaTpPfDsVmc3Jbh5eKsfbcmq/bbN+oih9KNMx7o8Sn
         0tOA==
X-Gm-Message-State: AOAM533Ax/QqfW6LZPWCBcjAKxxtet6wQ+T4hlZpRn8pMcfErSH1p5Zh
        abCSRm2DrX86hyeZ2rJS8+8=
X-Google-Smtp-Source: ABdhPJwPX2r6DjNrwVNs5c+ziMYGwjNbMhwwwoIF9vZmYZBLoeOOsAEtOV5d7k6Hegpz8QWRUbEHmA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr8161035pgq.313.1628975864111;
        Sat, 14 Aug 2021 14:17:44 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id d22sm7480503pgi.73.2021.08.14.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:17:43 -0700 (PDT)
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
Subject: [PATCH 03/17] include: move find.h from asm_generic to linux
Date:   Sat, 14 Aug 2021 14:16:59 -0700
Message-Id: <20210814211713.180533-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_bit API and bitmap API are closely related, but inclusion paths
are different - include/asm-generic and include/linux, correspondingly.
In the past it made a lot of troubles due to circular dependencies
and/or undefined symbols. Fix this by moving find.h under include/linux.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS                                  |  2 +-
 arch/alpha/include/asm/bitops.h              |  2 --
 arch/arc/include/asm/bitops.h                |  1 -
 arch/arm/include/asm/bitops.h                |  1 -
 arch/arm64/include/asm/bitops.h              |  1 -
 arch/csky/include/asm/bitops.h               |  1 -
 arch/h8300/include/asm/bitops.h              |  1 -
 arch/hexagon/include/asm/bitops.h            |  1 -
 arch/ia64/include/asm/bitops.h               |  2 --
 arch/m68k/include/asm/bitops.h               |  2 --
 arch/mips/include/asm/bitops.h               |  1 -
 arch/openrisc/include/asm/bitops.h           |  1 -
 arch/parisc/include/asm/bitops.h             |  2 --
 arch/powerpc/include/asm/bitops.h            |  2 --
 arch/riscv/include/asm/bitops.h              |  1 -
 arch/s390/include/asm/bitops.h               |  1 -
 arch/sh/include/asm/bitops.h                 |  1 -
 arch/sparc/include/asm/bitops_32.h           |  1 -
 arch/sparc/include/asm/bitops_64.h           |  2 --
 arch/x86/include/asm/bitops.h                |  2 --
 arch/xtensa/include/asm/bitops.h             |  1 -
 include/asm-generic/bitops.h                 |  1 -
 include/linux/bitmap.h                       |  1 +
 include/{asm-generic/bitops => linux}/find.h | 12 +++++++++---
 24 files changed, 11 insertions(+), 32 deletions(-)
 rename include/{asm-generic/bitops => linux}/find.h (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b63403793c81..9b62293f7b72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3271,8 +3271,8 @@ M:	Yury Norov <yury.norov@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
-F:	include/asm-generic/bitops/find.h
 F:	include/linux/bitmap.h
+F:	include/linux/find.h
 F:	lib/bitmap.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 5adca78830b5..e1d8483a45f2 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -430,8 +430,6 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index a7daaf64ae34..bdb7e190a294 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -189,7 +189,6 @@ static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 #include <asm-generic/bitops/atomic.h>
 #include <asm-generic/bitops/non-atomic.h>
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index c92e42a5c8f7..8e94fe7ab5eb 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -264,7 +264,6 @@ static inline int find_next_bit_le(const void *p, int size, int offset)
 
 #endif
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
 
 /*
diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 81a3e519b07d..9b3c787132d2 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -18,7 +18,6 @@
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index 91818787d860..9604f47bd850 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -59,7 +59,6 @@ static __always_inline unsigned long __fls(unsigned long x)
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index c867a80cab5b..4489e3d6edd3 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -168,7 +168,6 @@ static inline unsigned long __ffs(unsigned long word)
 	return result;
 }
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 71429f756af0..75d6ba3643b8 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -271,7 +271,6 @@ static inline unsigned long __fls(unsigned long word)
 }
 
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/find.h>
 
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 2f24ee6459d2..577be93c0818 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -441,8 +441,6 @@ static __inline__ unsigned long __arch_hweight64(unsigned long x)
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/le.h>
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 7b414099e5fc..f551a2160294 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -529,6 +529,4 @@ static inline int __fls(int x)
 #include <asm-generic/bitops/le.h>
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/find.h>
-
 #endif /* _M68K_BITOPS_H */
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index dc2a6234dd3c..c09d57f907f7 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -446,7 +446,6 @@ static inline int ffs(int word)
 }
 
 #include <asm-generic/bitops/ffz.h>
-#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
diff --git a/arch/openrisc/include/asm/bitops.h b/arch/openrisc/include/asm/bitops.h
index 7f1ca35213d8..d773ed938acb 100644
--- a/arch/openrisc/include/asm/bitops.h
+++ b/arch/openrisc/include/asm/bitops.h
@@ -30,7 +30,6 @@
 #include <asm/bitops/fls.h>
 #include <asm/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
index aa4e883431c1..c7a9997ac9cb 100644
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -208,8 +208,6 @@ static __inline__ int fls(unsigned int x)
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/le.h>
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 299ab33505a6..ce2c1fa1a45d 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -255,8 +255,6 @@ unsigned long __arch_hweight64(__u64 w);
 #include <asm-generic/bitops/hweight.h>
 #endif
 
-#include <asm-generic/bitops/find.h>
-
 /* wrappers that deal with KASAN instrumentation */
 #include <asm-generic/bitops/instrumented-atomic.h>
 #include <asm-generic/bitops/instrumented-lock.h>
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 396a3303c537..3540b690944b 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -20,7 +20,6 @@
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index fd149480b6e2..f7cefdde7c24 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -387,7 +387,6 @@ static inline int fls(unsigned int word)
 #endif /* CONFIG_HAVE_MARCH_Z9_109_FEATURES */
 
 #include <asm-generic/bitops/ffz.h>
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 3b6c7b5b7ec9..10ceb0d6b5a9 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -68,6 +68,5 @@ static inline unsigned long __ffs(unsigned long word)
 #include <asm-generic/bitops/fls64.h>
 
 #include <asm-generic/bitops/le.h>
-#include <asm-generic/bitops/find.h>
 
 #endif /* __ASM_SH_BITOPS_H */
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
index 0ceff3b915a8..889afa9f990f 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -100,7 +100,6 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 
diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index ca7ea5913494..005a8ae858f1 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -52,8 +52,6 @@ unsigned int __arch_hweight8(unsigned int w);
 #include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/find.h>
-
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/le.h>
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 0367efdc5b7a..a288ecd230ab 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -380,8 +380,6 @@ static __always_inline int fls64(__u64 x)
 #include <asm-generic/bitops/fls64.h>
 #endif
 
-#include <asm-generic/bitops/find.h>
-
 #include <asm-generic/bitops/sched.h>
 
 #include <asm/arch_hweight.h>
diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
index 3f71d364ba90..cd225896c40f 100644
--- a/arch/xtensa/include/asm/bitops.h
+++ b/arch/xtensa/include/asm/bitops.h
@@ -205,7 +205,6 @@ BIT_OPS(change, "xor", )
 #undef BIT_OP
 #undef TEST_AND_BIT_OP
 
-#include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index df9b5bc3d282..a47b8a71d6fe 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -20,7 +20,6 @@
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index a36cfcec4e77..3f7c6731b203 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/find.h>
 #include <linux/limits.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/include/asm-generic/bitops/find.h b/include/linux/find.h
similarity index 97%
rename from include/asm-generic/bitops/find.h
rename to include/linux/find.h
index 91b1b23f2b0c..c5410c243e04 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/linux/find.h
@@ -1,6 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_BITOPS_FIND_H_
-#define _ASM_GENERIC_BITOPS_FIND_H_
+#ifndef __LINUX_FIND_H_
+#define __LINUX_FIND_H_
+
+#ifndef __LINUX_BITMAP_H
+#error only <linux/bitmap.h> can be included directly
+#endif
+
+#include <linux/bitops.h>
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
@@ -259,4 +265,4 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 #error "Please fix <asm/byteorder.h>"
 #endif
 
-#endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
+#endif /*__LINUX_FIND_H_ */
-- 
2.30.2

