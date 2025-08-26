Return-Path: <linux-arch+bounces-13277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82BB35419
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A356A1B651B9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A82F6171;
	Tue, 26 Aug 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qt50fHhk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4r2qNWGA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3A2882D7;
	Tue, 26 Aug 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189103; cv=none; b=eQxos7/4YhmskqRLTrPC0rMKYVzq+yMMZYlpZT1WQmmpHlOwGX5PHwFAuLiTdwvLptzYZtMR+edmvZmts9STuQHf7f3o5wU+pmz0fhmGhitKf1HzsV7sJ+ZI6dZ1pAO1erF/qjyWDZ3z5531LDWGOaBg+D5v6WtA/Y/5eL74uaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189103; c=relaxed/simple;
	bh=jRrDQXs97w6WapLhaOa7Pkm+jLScLDYfjSl6yi3XN18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8eglTJuqYo+IJlfM9drigqDh3vHGkEFPBfAjJSxVwTnX6We9PSmPg0AaOdiRZTVXTxEbxF1bJaEsZ00o3ge7fbjGnzeS7WmarwH252une24rOMRd7ryJP1+X9zrfv4xumvoqn/SwmA0Bn8xzZNypaTU7qgFKj8KqcVQn9IZuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qt50fHhk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4r2qNWGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6H2kK7oB9XL3kf3qEPW1KLZGm1z/W4mCckKnzb/rKs=;
	b=qt50fHhkADqQAuGueYGo1TQTCS9pRKukjkJcKGMOVdY+09d6hUTKCyc1AyfhiAYF831YBL
	4q99aXnzXtByc6BFg3oxoOao3aYxAJC/4V4yv6pRmF5M82cdIFMVR2cYlHIKLsm2rpv9id
	oUjPKAO+oKu1SN3APxKQuqKX/DGssbMKCw4Xz2n4zZRJ7UN5maoM+zI/Lf0RlegSXAgyuq
	/yWxcu5VK+/r04Tbb+GtsRhZKDrv/mWRyQGwmgm3a7+vendx0i7Ty/I1Fshrv0+b0ZWwlG
	SH+n/VsvVlEtE2tm2DP+xUhGKNTJBp08j1K4fjgxsZPCn8yrdRPmmOis69Lp3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6H2kK7oB9XL3kf3qEPW1KLZGm1z/W4mCckKnzb/rKs=;
	b=4r2qNWGAXu/UOi8WftkYX57YkiorzJNR/wCQ1OowTx3aIeHRybvVVg1TQp7nZhB0xzChNO
	mlSahIjP53UFu/BQ==
Date: Tue, 26 Aug 2025 08:17:06 +0200
Subject: [PATCH 03/11] vdso: Move ENABLE_COMPAT_VDSO from core to arm64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-3-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
In-Reply-To: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=4201;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jRrDQXs97w6WapLhaOa7Pkm+jLScLDYfjSl6yi3XN18=;
 b=zVe/bWMXPBpBICIiM3Xs7CuOoAOqkdw7N9nfQnVMF1yQFhNpPWnyujMRcuO3pxZbGv51ey0DT
 uPROdPxZB3gDVO9rZsFSY0vOzcTTDPeOEOBO9SI9WjiLictQ4yCGkTS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The ENABLE_COMAPT_VDSO symbol is only used by arm64 and only for the
time-related functionality. There should be no new users, so it doesn't
need to be in the generic vDSO code.

Move the logic into arm64 architecture-specific code and replace the
explicit define by the standard '#ifdef __aarch64__'.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/compat_barrier.h      | 7 +++----
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 6 +++---
 arch/arm64/include/asm/vdso/gettimeofday.h        | 8 ++++++++
 arch/arm64/kernel/vdso32/Makefile                 | 1 -
 include/vdso/datapage.h                           | 4 ----
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index 3ac35f4a667cfc8c03fb6b6913c5a02b230a1659..6d75e03d38274a6b8549ab10a0f3c9732e7fae56 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -7,11 +7,10 @@
 
 #ifndef __ASSEMBLY__
 /*
- * Warning: This code is meant to be used with
- * ENABLE_COMPAT_VDSO only.
+ * Warning: This code is meant to be used from the compat vDSO only.
  */
-#ifndef ENABLE_COMPAT_VDSO
-#error This header is meant to be used with ENABLE_COMPAT_VDSO only
+#ifdef __arch64__
+#error This header is meant to be used with from the compat vDSO only
 #endif
 
 #ifdef dmb
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index d60ea7a72a9cb3457c412d0ece21ed76ae77782d..7d1a116549b1b98d6eb7a78d053958c6a71799ec 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2018 ARM Limited
  */
-#ifndef __ASM_VDSO_GETTIMEOFDAY_H
-#define __ASM_VDSO_GETTIMEOFDAY_H
+#ifndef __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
+#define __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
 
 #ifndef __ASSEMBLY__
 
@@ -163,4 +163,4 @@ static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 
 #endif /* !__ASSEMBLY__ */
 
-#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
+#endif /* __ASM_VDSO_COMPAT_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index da1ab87595925fdfa74fd10d0c9548f109970588..c59e84105b43cdb0c823da3dd793a83781f84302 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
+#ifdef __aarch64__
+
 #ifndef __ASSEMBLY__
 
 #include <asm/alternative.h>
@@ -96,4 +98,10 @@ static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(
 
 #endif /* !__ASSEMBLY__ */
 
+#else /* !__aarch64__ */
+
+#include "compat_gettimeofday.h"
+
+#endif /* __aarch64__ */
+
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index f2dfdc7dc8185bc045907283b68ab18fed980312..230fdc26796aa5ba561519bcf2de8ccd7ad3b9f8 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -59,7 +59,6 @@ VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
 VDSO_CAFLAGS += -march=armv8-a
 
 VDSO_CFLAGS := $(VDSO_CAFLAGS)
-VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 02533038640e53c40291c7e09139e0f9b32f502a..0b1982f15de427723c9ff8502ca1eaa195f9a6a1 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -196,11 +196,7 @@ enum vdso_pages {
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
-#ifdef ENABLE_COMPAT_VDSO
-#include <asm/vdso/compat_gettimeofday.h>
-#else
 #include <asm/vdso/gettimeofday.h>
-#endif /* ENABLE_COMPAT_VDSO */
 
 #else /* !__ASSEMBLY__ */
 

-- 
2.50.1


