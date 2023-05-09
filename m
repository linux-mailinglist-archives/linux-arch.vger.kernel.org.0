Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF086FBFF6
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjEIHFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjEIHFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 03:05:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2C09AD33;
        Tue,  9 May 2023 00:05:08 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxOuqj8FlkIt8GAA--.11313S3;
        Tue, 09 May 2023 15:05:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlrWf8FlkzT1SAA--.16926S2;
        Tue, 09 May 2023 15:05:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [RFC PATCH] asm-generic: Unify uapi bitsperlong.h
Date:   Tue,  9 May 2023 15:05:03 +0800
Message-Id: <1683615903-10862-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxlrWf8FlkzT1SAA--.16926S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfZFWUCF4DAw4DGFWUZry8AFb_yoW8KF17to
        WagF1jkrWxGa1rXan5WF47Gay5ZF1v9r4xJw1fJ3y5Ga4fCr17Gr48WayIv3ZxCrn3t34U
        WFWa9rZ8Xws2qwn3n29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YV
        CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO-B_UUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now we specify the minimal version of GCC as 5.1 and Clang/LLVM as 11.0.0
in Documentation/process/changes.rst, __CHAR_BIT__ and __SIZEOF_LONG__ are
usable, just define __BITS_PER_LONG as (__CHAR_BIT__ * __SIZEOF_LONG__) in
asm-generic uapi bitsperlong.h, simpler, works everywhere.

Remove all the arch specific uapi bitsperlong.h which will be generated as
arch/*/include/generated/uapi/asm/bitsperlong.h.

Suggested-by: Xi Ruoyao <xry111@xry111.site>
Link: https://lore.kernel.org/all/d3e255e4746de44c9903c4433616d44ffcf18d1b.camel@xry111.site/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This is based on 6.4-rc1

 arch/alpha/include/uapi/asm/bitsperlong.h          |  9 --------
 arch/arm64/include/uapi/asm/bitsperlong.h          | 24 -------------------
 arch/ia64/include/uapi/asm/bitsperlong.h           |  9 --------
 arch/loongarch/include/uapi/asm/bitsperlong.h      |  9 --------
 arch/mips/include/uapi/asm/bitsperlong.h           |  9 --------
 arch/parisc/include/uapi/asm/bitsperlong.h         | 13 -----------
 arch/powerpc/include/uapi/asm/bitsperlong.h        | 13 -----------
 arch/riscv/include/uapi/asm/bitsperlong.h          | 14 -----------
 arch/s390/include/uapi/asm/bitsperlong.h           | 14 -----------
 arch/sparc/include/uapi/asm/bitsperlong.h          | 14 -----------
 arch/x86/include/uapi/asm/bitsperlong.h            | 14 -----------
 include/uapi/asm-generic/bitsperlong.h             | 11 +--------
 tools/arch/alpha/include/uapi/asm/bitsperlong.h    |  9 --------
 tools/arch/arm64/include/uapi/asm/bitsperlong.h    | 24 -------------------
 tools/arch/hexagon/include/uapi/asm/bitsperlong.h  | 27 ----------------------
 tools/arch/ia64/include/uapi/asm/bitsperlong.h     |  9 --------
 .../arch/loongarch/include/uapi/asm/bitsperlong.h  |  9 --------
 .../arch/microblaze/include/uapi/asm/bitsperlong.h |  2 --
 tools/arch/mips/include/uapi/asm/bitsperlong.h     |  9 --------
 tools/arch/parisc/include/uapi/asm/bitsperlong.h   | 15 ------------
 tools/arch/powerpc/include/uapi/asm/bitsperlong.h  | 13 -----------
 tools/arch/riscv/include/uapi/asm/bitsperlong.h    | 14 -----------
 tools/arch/s390/include/uapi/asm/bitsperlong.h     | 13 -----------
 tools/arch/sparc/include/uapi/asm/bitsperlong.h    | 13 -----------
 tools/arch/x86/include/uapi/asm/bitsperlong.h      | 13 -----------
 tools/include/uapi/asm-generic/bitsperlong.h       | 12 ++--------
 tools/include/uapi/asm/bitsperlong.h               | 24 -------------------
 27 files changed, 3 insertions(+), 356 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/arm64/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/ia64/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/loongarch/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/mips/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/parisc/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/powerpc/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/riscv/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/s390/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/sparc/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/x86/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/alpha/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/arm64/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/hexagon/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/ia64/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/microblaze/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/mips/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/parisc/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/powerpc/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/riscv/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/s390/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/sparc/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/x86/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/include/uapi/asm/bitsperlong.h

diff --git a/arch/alpha/include/uapi/asm/bitsperlong.h b/arch/alpha/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 6c5bf7d..0000000
--- a/arch/alpha/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_BITSPERLONG_H
-#define __ASM_ALPHA_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_ALPHA_BITSPERLONG_H */
diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 485d60be..0000000
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_BITSPERLONG_H
-#define __ASM_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif	/* __ASM_BITSPERLONG_H */
diff --git a/arch/ia64/include/uapi/asm/bitsperlong.h b/arch/ia64/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 1146d55..0000000
--- a/arch/ia64/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_IA64_BITSPERLONG_H
-#define __ASM_IA64_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_IA64_BITSPERLONG_H */
diff --git a/arch/loongarch/include/uapi/asm/bitsperlong.h b/arch/loongarch/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 00b4ba1..0000000
--- a/arch/loongarch/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_LOONGARCH_BITSPERLONG_H
-#define __ASM_LOONGARCH_BITSPERLONG_H
-
-#define __BITS_PER_LONG (__SIZEOF_LONG__ * 8)
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
diff --git a/arch/mips/include/uapi/asm/bitsperlong.h b/arch/mips/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 7268380d..0000000
--- a/arch/mips/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_MIPS_BITSPERLONG_H
-#define __ASM_MIPS_BITSPERLONG_H
-
-#define __BITS_PER_LONG _MIPS_SZLONG
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_MIPS_BITSPERLONG_H */
diff --git a/arch/parisc/include/uapi/asm/bitsperlong.h b/arch/parisc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 307e2ef..0000000
--- a/arch/parisc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_PARISC_BITSPERLONG_H
-#define __ASM_PARISC_BITSPERLONG_H
-
-#if defined(__LP64__)
-#define __BITS_PER_LONG 64
-#else
-#define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_PARISC_BITSPERLONG_H */
diff --git a/arch/powerpc/include/uapi/asm/bitsperlong.h b/arch/powerpc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 46ece3e..0000000
--- a/arch/powerpc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_POWERPC_BITSPERLONG_H
-#define __ASM_POWERPC_BITSPERLONG_H
-
-#if defined(__powerpc64__)
-# define __BITS_PER_LONG 64
-#else
-# define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_POWERPC_BITSPERLONG_H */
diff --git a/arch/riscv/include/uapi/asm/bitsperlong.h b/arch/riscv/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 7d0b32e..0000000
--- a/arch/riscv/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- * Copyright (C) 2015 Regents of the University of California
- */
-
-#ifndef _UAPI_ASM_RISCV_BITSPERLONG_H
-#define _UAPI_ASM_RISCV_BITSPERLONG_H
-
-#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/arch/s390/include/uapi/asm/bitsperlong.h b/arch/s390/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index cceaf47..0000000
--- a/arch/s390/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_S390_BITSPERLONG_H
-#define __ASM_S390_BITSPERLONG_H
-
-#ifndef __s390x__
-#define __BITS_PER_LONG 32
-#else
-#define __BITS_PER_LONG 64
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_S390_BITSPERLONG_H */
-
diff --git a/arch/sparc/include/uapi/asm/bitsperlong.h b/arch/sparc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index cd9a432..0000000
--- a/arch/sparc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_BITSPERLONG_H
-#define __ASM_ALPHA_BITSPERLONG_H
-
-#if defined(__sparc__) && defined(__arch64__)
-#define __BITS_PER_LONG 64
-#else
-#define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_ALPHA_BITSPERLONG_H */
-
diff --git a/arch/x86/include/uapi/asm/bitsperlong.h b/arch/x86/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 5d72c845..0000000
--- a/arch/x86/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_X86_BITSPERLONG_H
-#define __ASM_X86_BITSPERLONG_H
-
-#if defined(__x86_64__) && !defined(__ILP32__)
-# define __BITS_PER_LONG 64
-#else
-# define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_X86_BITSPERLONG_H */
-
diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
index 693d9a4..a230ba3 100644
--- a/include/uapi/asm-generic/bitsperlong.h
+++ b/include/uapi/asm-generic/bitsperlong.h
@@ -2,15 +2,6 @@
 #ifndef _UAPI__ASM_GENERIC_BITS_PER_LONG
 #define _UAPI__ASM_GENERIC_BITS_PER_LONG
 
-/*
- * There seems to be no way of detecting this automatically from user
- * space, so 64 bit architectures should override this in their
- * bitsperlong.h. In particular, an architecture that supports
- * both 32 and 64 bit user space must not rely on CONFIG_64BIT
- * to decide it, but rather check a compiler provided macro.
- */
-#ifndef __BITS_PER_LONG
-#define __BITS_PER_LONG 32
-#endif
+#define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
 
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/arch/alpha/include/uapi/asm/bitsperlong.h b/tools/arch/alpha/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 6c5bf7d..0000000
--- a/tools/arch/alpha/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_BITSPERLONG_H
-#define __ASM_ALPHA_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_ALPHA_BITSPERLONG_H */
diff --git a/tools/arch/arm64/include/uapi/asm/bitsperlong.h b/tools/arch/arm64/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 485d60be..0000000
--- a/tools/arch/arm64/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_BITSPERLONG_H
-#define __ASM_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif	/* __ASM_BITSPERLONG_H */
diff --git a/tools/arch/hexagon/include/uapi/asm/bitsperlong.h b/tools/arch/hexagon/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 5adca0d..0000000
--- a/tools/arch/hexagon/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef __ASM_HEXAGON_BITSPERLONG_H
-#define __ASM_HEXAGON_BITSPERLONG_H
-
-#define __BITS_PER_LONG 32
-
-#include <asm-generic/bitsperlong.h>
-
-#endif
diff --git a/tools/arch/ia64/include/uapi/asm/bitsperlong.h b/tools/arch/ia64/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 1146d55..0000000
--- a/tools/arch/ia64/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_IA64_BITSPERLONG_H
-#define __ASM_IA64_BITSPERLONG_H
-
-#define __BITS_PER_LONG 64
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_IA64_BITSPERLONG_H */
diff --git a/tools/arch/loongarch/include/uapi/asm/bitsperlong.h b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 00b4ba1..0000000
--- a/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_LOONGARCH_BITSPERLONG_H
-#define __ASM_LOONGARCH_BITSPERLONG_H
-
-#define __BITS_PER_LONG (__SIZEOF_LONG__ * 8)
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
diff --git a/tools/arch/microblaze/include/uapi/asm/bitsperlong.h b/tools/arch/microblaze/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b..0000000
--- a/tools/arch/microblaze/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/bitsperlong.h>
diff --git a/tools/arch/mips/include/uapi/asm/bitsperlong.h b/tools/arch/mips/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 7268380d..0000000
--- a/tools/arch/mips/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_MIPS_BITSPERLONG_H
-#define __ASM_MIPS_BITSPERLONG_H
-
-#define __BITS_PER_LONG _MIPS_SZLONG
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_MIPS_BITSPERLONG_H */
diff --git a/tools/arch/parisc/include/uapi/asm/bitsperlong.h b/tools/arch/parisc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 23ac756..0000000
--- a/tools/arch/parisc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_PARISC_BITSPERLONG_H
-#define __ASM_PARISC_BITSPERLONG_H
-
-#if defined(__LP64__)
-#define __BITS_PER_LONG 64
-#define SHIFT_PER_LONG 6
-#else
-#define __BITS_PER_LONG 32
-#define SHIFT_PER_LONG 5
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_PARISC_BITSPERLONG_H */
diff --git a/tools/arch/powerpc/include/uapi/asm/bitsperlong.h b/tools/arch/powerpc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 46ece3e..0000000
--- a/tools/arch/powerpc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_POWERPC_BITSPERLONG_H
-#define __ASM_POWERPC_BITSPERLONG_H
-
-#if defined(__powerpc64__)
-# define __BITS_PER_LONG 64
-#else
-# define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_POWERPC_BITSPERLONG_H */
diff --git a/tools/arch/riscv/include/uapi/asm/bitsperlong.h b/tools/arch/riscv/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 0b9b58b..0000000
--- a/tools/arch/riscv/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Ltd.
- * Copyright (C) 2015 Regents of the University of California
- */
-
-#ifndef _UAPI_ASM_RISCV_BITSPERLONG_H
-#define _UAPI_ASM_RISCV_BITSPERLONG_H
-
-#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/tools/arch/s390/include/uapi/asm/bitsperlong.h b/tools/arch/s390/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index d2bb620..0000000
--- a/tools/arch/s390/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_S390_BITSPERLONG_H
-#define __ASM_S390_BITSPERLONG_H
-
-#ifndef __s390x__
-#define __BITS_PER_LONG 32
-#else
-#define __BITS_PER_LONG 64
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_S390_BITSPERLONG_H */
diff --git a/tools/arch/sparc/include/uapi/asm/bitsperlong.h b/tools/arch/sparc/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 3b4e617..0000000
--- a/tools/arch/sparc/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_BITSPERLONG_H
-#define __ASM_ALPHA_BITSPERLONG_H
-
-#if defined(__sparc__) && defined(__arch64__)
-#define __BITS_PER_LONG 64
-#else
-#define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_ALPHA_BITSPERLONG_H */
diff --git a/tools/arch/x86/include/uapi/asm/bitsperlong.h b/tools/arch/x86/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index f8a92e0..0000000
--- a/tools/arch/x86/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_X86_BITSPERLONG_H
-#define __ASM_X86_BITSPERLONG_H
-
-#if defined(__x86_64__) && !defined(__ILP32__)
-# define __BITS_PER_LONG 64
-#else
-# define __BITS_PER_LONG 32
-#endif
-
-#include <asm-generic/bitsperlong.h>
-
-#endif /* __ASM_X86_BITSPERLONG_H */
diff --git a/tools/include/uapi/asm-generic/bitsperlong.h b/tools/include/uapi/asm-generic/bitsperlong.h
index 23e6c41..a230ba3 100644
--- a/tools/include/uapi/asm-generic/bitsperlong.h
+++ b/tools/include/uapi/asm-generic/bitsperlong.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI__ASM_GENERIC_BITS_PER_LONG
 #define _UAPI__ASM_GENERIC_BITS_PER_LONG
 
-/*
- * There seems to be no way of detecting this automatically from user
- * space, so 64 bit architectures should override this in their
- * bitsperlong.h. In particular, an architecture that supports
- * both 32 and 64 bit user space must not rely on CONFIG_64BIT
- * to decide it, but rather check a compiler provided macro.
- */
-#ifndef __BITS_PER_LONG
-#define __BITS_PER_LONG 32
-#endif
+#define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
 
 #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index da52065..0000000
--- a/tools/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#if defined(__i386__) || defined(__x86_64__)
-#include "../../../arch/x86/include/uapi/asm/bitsperlong.h"
-#elif defined(__aarch64__)
-#include "../../../arch/arm64/include/uapi/asm/bitsperlong.h"
-#elif defined(__powerpc__)
-#include "../../../arch/powerpc/include/uapi/asm/bitsperlong.h"
-#elif defined(__s390__)
-#include "../../../arch/s390/include/uapi/asm/bitsperlong.h"
-#elif defined(__sparc__)
-#include "../../../arch/sparc/include/uapi/asm/bitsperlong.h"
-#elif defined(__mips__)
-#include "../../../arch/mips/include/uapi/asm/bitsperlong.h"
-#elif defined(__ia64__)
-#include "../../../arch/ia64/include/uapi/asm/bitsperlong.h"
-#elif defined(__riscv)
-#include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
-#elif defined(__alpha__)
-#include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
-#elif defined(__loongarch__)
-#include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
-#else
-#include <asm-generic/bitsperlong.h>
-#endif
-- 
2.1.0

