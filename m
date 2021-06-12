Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556CE3A4ED1
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFLMit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhFLMis (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:38:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25BEC061767;
        Sat, 12 Jun 2021 05:36:48 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g12so17983248qvx.12;
        Sat, 12 Jun 2021 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWmR9xnLCR0JIMV3ii+ebP/b8UBEgIrSrewdZ3FdBGo=;
        b=DouvAjoSN/odoBBwhIDy47vckvOniU6CVuxAKnt2aO+rgNHQ/bPU3zWLnItoVqSVOJ
         ovtn8/nWVcGlTNrX3337AQE5TXmtngyLvl6pCikub+IxMUp7kPlXaiY1z+btYv3RUc7h
         RSdVRRhB3gvqHwSfCxLzr9b3wU7YUFMkdDZ51LOtHEJWtmIdJIkiBW3IKqfFsBRzpCZV
         WMW8mGU/LSihSUcPGz/ytvEuhwmnyWZfdurYUMUEq2inZ5AWvic+Fg4oPB3smUt3p2Lf
         fVJ3CbY3BskQWjJNdUnyR1dYeOopidZtBR0TSzyvdUTGHcJPfqX/TpspHSD2kJY1IPNz
         0p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWmR9xnLCR0JIMV3ii+ebP/b8UBEgIrSrewdZ3FdBGo=;
        b=Lk2N8caKyvHvtc9Uf7/0yiTyQoFBYHWabh6e1RCksMrJ6ucdUZemjnW59vpOFEoWlO
         r0iwjgZasiYoh5DZJFgbmj66YH8RpELvDivPE2Q2j2J4V27FRtaDM/ZdudO2UIN/smPD
         bBWKLXHHJVNjQScPryAOUjF0MVfoncHZiIuj2GloWMXe7XMX6zAjPEepZFjfZ/dr4tnb
         l4UcueNhjV9Y8KhH3eplx3/AErv7ZZca1U0UFiURnCBk+soKuxbF4aZgJtfBLfVdyACl
         8dTDt4fv/k98hqPHm90ux4uFkYAim1trYMaeGhlKZSRUqTsaVRKIVJxIttkQVQvX0pIq
         bNeA==
X-Gm-Message-State: AOAM533RReDsSiXEfV345sCdIl58ovabEM+JGWCwzxd/V/IwYx0QzUjy
        jdhQ6Ehk5m0VptSxxIHqW5Tk3V84s0GSyw==
X-Google-Smtp-Source: ABdhPJz6XK0I0gtPH2Jt9kYLdGSU9YAS5qcW8VdGt5LVxGk36u3Ttth0EbtasEnn2yBwSm2nVQAF1Q==
X-Received: by 2002:a0c:c390:: with SMTP id o16mr1900859qvi.16.1623501407573;
        Sat, 12 Jun 2021 05:36:47 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id a134sm6452095qkg.114.2021.06.12.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:47 -0700 (PDT)
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
Subject: [PATCH 3/8] include: move find.h from asm_generic to linux
Date:   Sat, 12 Jun 2021 05:36:34 -0700
Message-Id: <20210612123639.329047-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
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
index 88c2c4d1cfd0..1c648c18c567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3226,8 +3226,8 @@ M:	Yury Norov <yury.norov@gmail.com>
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
index fb98440c0bd4..0cc24ae6a8d9 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -369,7 +369,6 @@ static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/lock.h>
 
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
index 68da67d2c4c9..66839f352a5e 100644
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

