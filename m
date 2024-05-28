Return-Path: <linux-arch+bounces-4556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF88D1FEC
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB4285F4F
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E00E172BBF;
	Tue, 28 May 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eJ7V4iUs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE282171071
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909119; cv=none; b=EOEbVKskIqN1sXLInffTTgLQ0H/2QB/tFafla1u9WOBDFDjXFO5Ql4VWzr7DgtomZ0SwW0ymb/GCkkvVukExxWYKw08YiueQtBUqiJJz0ocPFtbsXv6iDdQJg9pOXPXHtBO3HGKxJuajXeurRKK50cCvzPD7xQ+EXPRD3C5/LHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909119; c=relaxed/simple;
	bh=TEvDOfsnylXJLXAYcAcZM/8r3TjyXkyenEf233xm5J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zldx/efqWyOF/WGKZ/JH2zWxyJgSC5Z6/zd5Fx9SPIpotCTMixDDa2ZmoZDGehQdW5px+yJhFfWLYGi7e7YljlSGWYI8uJVN+b7I4N9IrHiQ5RHmb0hFGAIJAoWFOnBHPS+VjDe8QtBRTxUYHKH3gs2/uGDFY1l71r9H4PXv+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eJ7V4iUs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e9819a6327so11632871fa.1
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909116; x=1717513916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqY2tac92Zgdj6EN5vhDUCiGPySLtAUcYkNNT11YFiQ=;
        b=eJ7V4iUs+u1NnkYTGo24gwCYXi5U46c5IbP0vk+xe5wjvK9WZhT4O8+h54B5n919yV
         KSt9PnI+QF5HfDTN9dStse+LcOII6iQd993KmtNBFaOSehF1EPz9LwPriXx+4lqJMO6X
         /JhjXCSTZCK0d3XSuOs/M7ctdA0TIcqH92pDrqCfFakgs7pSktkTttAp416/XrjtosPu
         7U4Tk6r2udWMO0T5ddNP/aFYOMMc9l94F9QyLAhjv3PcKx5IsbZi4DoR4nRsMuKH6BsH
         4qlLpcBRqmWbFS579fZnSEkQcBXEiSxA45f7lq8QbCSEEuH5WL2aH5M8YoJshKkDQWfV
         a22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909116; x=1717513916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqY2tac92Zgdj6EN5vhDUCiGPySLtAUcYkNNT11YFiQ=;
        b=qKfAYRrXzpez/kp6MkTJeOaf9yJo32NaLSaHS6nFucA7vOjGM6r8u6IVJwTJKxnhIa
         jMK/ccls1SjnQ2i2aFB1JVn8eYYWOLMxHmhBv/6RdkgEIAyogvQFCJPhqt00Wm+2DV6G
         eL9dKOEeb8O00QlW6WCCRMxB8t/lfpqSEGHiAhpFHZ+I224vLvUyxW5frX1Nkf8P0MV+
         JJb4Y3upycSq4zjh7h+OrDhUs7CgayfFoeL/R4uvAROh7Ps+G3QoFWeAWYFvcw7f5iME
         r8G5tcbVzkV2KQDwl/fTQIxqM5mv7yab/EHh+nZvSkJSuaEnB46XBESp1eOOaS2HUUVx
         FuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwnloSlp+QZzSQ9GzRmWqMj32yLWuHpsFwEnmC4oJl1fXUIUaJQoi4jSpdDABpVEFddlHhXLy1Gy29Vv6LUnMqD0IhBLB012Ay1g==
X-Gm-Message-State: AOJu0YxtLnfTVK2Rb4Wwb8Bq5VIttc4ZxXYvL36FWyKNgXoRApEE2rTl
	bTqK1HwO+mucsbmVGIzYILD3s4+1aGwQupmdm4kHN1giCI3mriH2b4HQ0toXWvY=
X-Google-Smtp-Source: AGHT+IHCYhHKhCYiIOYwsJcUm7AY7hiBzh9j+j/t9IO5zqkvCwOqxf6clogJ5Pwo0VQvo1ymN8/SHQ==
X-Received: by 2002:a2e:b0ed:0:b0:2e7:28ea:3c9d with SMTP id 38308e7fff4ca-2e95b2792f6mr65981801fa.51.1716909115927;
        Tue, 28 May 2024 08:11:55 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ef1207sm176823805e9.10.2024.05.28.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:11:55 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/7] riscv: Implement cmpxchg32/64() using Zacas
Date: Tue, 28 May 2024 17:10:46 +0200
Message-Id: <20240528151052.313031-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528151052.313031-1-alexghiti@rivosinc.com>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zacas in cmpxchg operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               | 17 +++++++++++++++++
 arch/riscv/Makefile              | 11 +++++++++++
 arch/riscv/include/asm/cmpxchg.h | 23 ++++++++++++++++++++---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8a0f403432e8..b443def70139 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -579,6 +579,23 @@ config RISCV_ISA_V_PREEMPTIVE
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
 
+config TOOLCHAIN_HAS_ZACAS
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zacas)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zacas)
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZACAS
+	bool "Zacas extension support for atomic CAS"
+	depends on TOOLCHAIN_HAS_ZACAS
+	default y
+	help
+	  Adds support to use atomic CAS instead of LR/SC to implement kernel
+	  atomic cmpxchg operation.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5b3115a19852..d5b60b87998c 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -78,6 +78,17 @@ endif
 # Check if the toolchain supports Zihintpause extension
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
+# Check if the toolchain supports Zacas
+ifdef CONFIG_AS_IS_LLVM
+# Support for experimental Zacas was merged in LLVM 17, but the removal of
+# the "experimental" was merged in LLVM 19.
+KBUILD_CFLAGS += -menable-experimental-extensions
+KBUILD_AFLAGS += -menable-experimental-extensions
+riscv-march-y := $(riscv-march-y)_zacas1p0
+else
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
+endif
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4d23f0c35b94..1c50b4821ac8 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <asm/alternative.h>
 
 #define __arch_xchg_masked(prepend, append, r, p, n)			\
 ({									\
@@ -132,21 +133,37 @@
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
+#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
+	__label__ zacas, end;						\
 	register unsigned int __rc;					\
 									\
+	asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,			\
+			     RISCV_ISA_EXT_ZACAS, 1)			\
+			: : : : zacas);					\
+									\
 	__asm__ __volatile__ (						\
 		prepend							\
 		"0:	lr" lr_sfx " %0, %2\n"				\
 		"	bne  %0, %z3, 1f\n"				\
-		"	sc" sc_sfx " %1, %z4, %2\n"			\
+		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
 		"	bnez %1, 0b\n"					\
 		append							\
 		"1:\n"							\
 		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
 		: "rJ" (co o), "rJ" (n)					\
 		: "memory");						\
+	goto end;							\
+									\
+zacas:									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amocas" sc_cas_sfx " %0, %z2, %1\n"		\
+		append							\
+		: "+&r" (r), "+A" (*(p))				\
+		: "rJ" (n)						\
+		: "memory");						\
+end:									\
 })
 
 #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
@@ -154,7 +171,7 @@
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __old = (old);				\
 	__typeof__(*(__ptr)) __new = (new);				\
-	__typeof__(*(__ptr)) __ret;					\
+	__typeof__(*(__ptr)) __ret = (old);				\
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-- 
2.39.2


