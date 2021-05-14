Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB33806A8
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhENKD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhENKDz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBB0B613BC;
        Fri, 14 May 2021 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986564;
        bh=pCXYqLZ28sSsmACkyB/zu1x4PG/CldD4oipWSFzWEJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFbGPOW+RkAAcg2nK4kZlPRkXeqPrjX/9SXsr9jAduQhPD/O9XpSs/HTvrbjiGQJ7
         8zosPhKmCuvFpE1QQEP064kCk4vl0Ajf7AXy9DDAnhNBmcNo5idvR6NYGpUrBMEiND
         slQGB84OuaxRZHGEnVMIBM2kqkrfvGzQk0uckAYSvkXpvBFeUJ1LDV2AJ766h5zcQJ
         VXSa+cjBgaNWNdGYi3OHD57n5N6rd7D2ekhEaKZ08uOGZ8fpdQ7Ua4QCTKBEtrvpJ1
         e6iQXy0Yt4ssy2B8TXD+9oZb4Z+SmkbgJi7UWxY3F6WIM180FXisawZKFBhxSSSoQ8
         RtDOL3lQfwjXw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 01/13] asm-generic: use asm-generic/unaligned.h for most architectures
Date:   Fri, 14 May 2021 12:00:49 +0200
Message-Id: <20210514100106.3404011-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are several architectures that just duplicate the contents
of asm-generic/unaligned.h, so change those over to use the
file directly, to make future modifications easier.

The exceptions are:

- arm32 sets HAVE_EFFICIENT_UNALIGNED_ACCESS, but wants the
  unaligned-struct version

- ppc64le disables HAVE_EFFICIENT_UNALIGNED_ACCESS but includes
  the access-ok version

- most m68k also uses the access-ok version without setting
  HAVE_EFFICIENT_UNALIGNED_ACCESS.

- sh4a has a custom inline asm version

- openrisc is the only one using the memmove version that
  generally leads to worse code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/include/asm/unaligned.h      | 12 ----------
 arch/ia64/include/asm/unaligned.h       | 12 ----------
 arch/m68k/include/asm/unaligned.h       |  9 +-------
 arch/microblaze/include/asm/unaligned.h | 27 -----------------------
 arch/parisc/include/asm/unaligned.h     |  6 +----
 arch/sparc/include/asm/unaligned.h      | 11 ----------
 arch/x86/include/asm/unaligned.h        | 15 -------------
 arch/xtensa/include/asm/unaligned.h     | 29 -------------------------
 8 files changed, 2 insertions(+), 119 deletions(-)
 delete mode 100644 arch/alpha/include/asm/unaligned.h
 delete mode 100644 arch/ia64/include/asm/unaligned.h
 delete mode 100644 arch/microblaze/include/asm/unaligned.h
 delete mode 100644 arch/sparc/include/asm/unaligned.h
 delete mode 100644 arch/x86/include/asm/unaligned.h
 delete mode 100644 arch/xtensa/include/asm/unaligned.h

diff --git a/arch/alpha/include/asm/unaligned.h b/arch/alpha/include/asm/unaligned.h
deleted file mode 100644
index 863c807b66f8..000000000000
--- a/arch/alpha/include/asm/unaligned.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_ALPHA_UNALIGNED_H
-#define _ASM_ALPHA_UNALIGNED_H
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned __get_unaligned_le
-#define put_unaligned __put_unaligned_le
-
-#endif /* _ASM_ALPHA_UNALIGNED_H */
diff --git a/arch/ia64/include/asm/unaligned.h b/arch/ia64/include/asm/unaligned.h
deleted file mode 100644
index 328942e3cbce..000000000000
--- a/arch/ia64/include/asm/unaligned.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_UNALIGNED_H
-#define _ASM_IA64_UNALIGNED_H
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
-
-#endif /* _ASM_IA64_UNALIGNED_H */
diff --git a/arch/m68k/include/asm/unaligned.h b/arch/m68k/include/asm/unaligned.h
index 98c8930d3d35..84e437337344 100644
--- a/arch/m68k/include/asm/unaligned.h
+++ b/arch/m68k/include/asm/unaligned.h
@@ -2,15 +2,8 @@
 #ifndef _ASM_M68K_UNALIGNED_H
 #define _ASM_M68K_UNALIGNED_H
 
-
 #ifdef CONFIG_CPU_HAS_NO_UNALIGNED
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
+#include <asm-generic/unaligned.h>
 #else
 /*
  * The m68k can do unaligned accesses itself.
diff --git a/arch/microblaze/include/asm/unaligned.h b/arch/microblaze/include/asm/unaligned.h
deleted file mode 100644
index 448299beab69..000000000000
--- a/arch/microblaze/include/asm/unaligned.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2006 Atmark Techno, Inc.
- */
-
-#ifndef _ASM_MICROBLAZE_UNALIGNED_H
-#define _ASM_MICROBLAZE_UNALIGNED_H
-
-# ifdef __KERNEL__
-
-#  ifdef __MICROBLAZEEL__
-#   include <linux/unaligned/le_struct.h>
-#   include <linux/unaligned/be_byteshift.h>
-#   define get_unaligned	__get_unaligned_le
-#   define put_unaligned	__put_unaligned_le
-#  else
-#   include <linux/unaligned/be_struct.h>
-#   include <linux/unaligned/le_byteshift.h>
-#   define get_unaligned	__get_unaligned_be
-#   define put_unaligned	__put_unaligned_be
-#  endif
-
-# include <linux/unaligned/generic.h>
-
-# endif	/* __KERNEL__ */
-#endif /* _ASM_MICROBLAZE_UNALIGNED_H */
diff --git a/arch/parisc/include/asm/unaligned.h b/arch/parisc/include/asm/unaligned.h
index e9029c7c2a69..3bda16773ba6 100644
--- a/arch/parisc/include/asm/unaligned.h
+++ b/arch/parisc/include/asm/unaligned.h
@@ -2,11 +2,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H
 #define _ASM_PARISC_UNALIGNED_H
 
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#include <asm-generic/unaligned.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
diff --git a/arch/sparc/include/asm/unaligned.h b/arch/sparc/include/asm/unaligned.h
deleted file mode 100644
index 7971d89d2f54..000000000000
--- a/arch/sparc/include/asm/unaligned.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_SPARC_UNALIGNED_H
-#define _ASM_SPARC_UNALIGNED_H
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif /* _ASM_SPARC_UNALIGNED_H */
diff --git a/arch/x86/include/asm/unaligned.h b/arch/x86/include/asm/unaligned.h
deleted file mode 100644
index 9c754a7447aa..000000000000
--- a/arch/x86/include/asm/unaligned.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_UNALIGNED_H
-#define _ASM_X86_UNALIGNED_H
-
-/*
- * The x86 can do unaligned accesses itself.
- */
-
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned __get_unaligned_le
-#define put_unaligned __put_unaligned_le
-
-#endif /* _ASM_X86_UNALIGNED_H */
diff --git a/arch/xtensa/include/asm/unaligned.h b/arch/xtensa/include/asm/unaligned.h
deleted file mode 100644
index 8e7ed046bfed..000000000000
--- a/arch/xtensa/include/asm/unaligned.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Xtensa doesn't handle unaligned accesses efficiently.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-#ifndef _ASM_XTENSA_UNALIGNED_H
-#define _ASM_XTENSA_UNALIGNED_H
-
-#include <asm/byteorder.h>
-
-#ifdef __LITTLE_ENDIAN
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#else
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#endif
-
-#endif	/* _ASM_XTENSA_UNALIGNED_H */
-- 
2.29.2

