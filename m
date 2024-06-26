Return-Path: <linux-arch+bounces-5141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE5918199
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B11F2391E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D717FABF;
	Wed, 26 Jun 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZNK+SJzL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2C17D34D
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407096; cv=none; b=DeHsteh7pjzotxsWGuKcAn0X0fPea5GfONLqWjUEfgMgF4iI0cfAB+FSVPlBAfTz8V+hSEcxbZI6mFNXxTXjUgy7TNw6WIhcqMW+VA4YH0GMdqrrkiXy4xG+HALnCbHQQHY52NmYbcuhrYKcwjDX+MCvs1UqzrIZ9US0HtYTo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407096; c=relaxed/simple;
	bh=A9Uqg4vTaom0SRJ8P/Ttrrx+YujCW1mkS/Zqcd4jDx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGYpiOD2RvjGFR5nfiBPvkgoLwkjdjDpKCZfvHtvxS9jY9QgJYuUOQ7v+rfMBoVjPS8GyqFXmiIAWN9sUdK0UGcdyAI3qdOrLF2qBYjHM7RilZyEbGLWA6WrLPimes64jgOo9JG7Bor7+A/20lXJyMH9yHMUaiyvcGjQYIBxaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZNK+SJzL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec1620a956so80187141fa.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407093; x=1720011893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhXCNVmR8P99l/LeuRhjy5KBZNQ4/EvtQCsDBcea+Tc=;
        b=ZNK+SJzLKFSgzvyxUkjQxUDR7o7piP4GoB+T9N3Sguqx3K0xQsC4SxTPoMFW540BFd
         QqlNEIBkE0xV/AY2c5wCkks+d3+XMdFSWD43srTrFVrUB+dloM1QUh4J9AiptgzJNVoW
         QmljUMlDHXqpQ6e8siqWm5/78g5jav65kdFEz8bOgCjB6bPKyUtIlVxQ/bw2Dhask1jq
         +jXAoX9ZTFpcNw7rmtEPJHx4qNmEeWWmHMV7sFUEvoe90nGtUcMpPOfVP3Qj+cdMq2gN
         oyJj9lRy6M2cLKbeD9SBrFZLXro4V9A+u3CXp0XITS/TvyQqIaBXlScGy7pQDNjlN+ES
         z6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407093; x=1720011893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhXCNVmR8P99l/LeuRhjy5KBZNQ4/EvtQCsDBcea+Tc=;
        b=t0k3phQ2sd9q0CwbBEx7l0gka0dVlZFDtcO9bvYOmdiyUtPuta1PITJJeMUSQgAvX1
         S5uWtYgCtPiKf4ZPPD81/IDs6VLu78GsYGLSU2fkIseMaV+1Bgp9UrgDiRPK2jgIUiRQ
         bq/9MwA9q6jhGHgVqbdrGs8PhD02OCPuqxyEntQ9dol3r3ED0/bjeMr0Y2IHhlc1YoFd
         mnr5XgTJS9djyebXljA7QMM7F8Y/a+8xoiGM9VatIkZUr0LrzaTfjbdwGeaeKhrKZXBe
         Ro0nMfAvWHpc5JKRLgo4l7vY70qTSAdFD8ZfWyWs060A59gtvY7rq7B62oaBrWIxU9aA
         EpkA==
X-Forwarded-Encrypted: i=1; AJvYcCUDFVT+y2mLu7IOrW/Ck1iapWgXLBDnS5nVAXyn/12HRLhMsBmTjkpxgIhVIMzuM+ItFhhP2BiY1uclHxgd1wj16BzRqbrFpbGAOA==
X-Gm-Message-State: AOJu0YxG5eG1dcsiPr0KUvkOtmfynbrklXbhi82KooTBgtzu9BJu9QQM
	tKb2m6FrmmSnzDFu9nxQFGsisvBx6d7XrCl3jlQzkTCmMXm15ygAgqSCqIRnK+Y=
X-Google-Smtp-Source: AGHT+IGXVzg0cT42nAZtoqYsiJZ5s31h9gkqhz8eo+Ns1Bzdpb6n1iQQeyrD5Jr8Y6qR9urf80as6w==
X-Received: by 2002:ac2:596e:0:b0:52c:db7b:b463 with SMTP id 2adb3069b0e04-52ce186459cmr6385178e87.61.1719407093047;
        Wed, 26 Jun 2024 06:04:53 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c842468dsm25643865e9.36.2024.06.26.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:04:52 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
Subject: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Date: Wed, 26 Jun 2024 15:03:38 +0200
Message-Id: <20240626130347.520750-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
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
 arch/riscv/Makefile              |  3 +++
 arch/riscv/include/asm/cmpxchg.h | 27 ++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 05ccba8ca33a..1caaedec88c7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -596,6 +596,23 @@ config RISCV_ISA_V_PREEMPTIVE
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
+	  Enable the use of the Zacas ISA-extension to implement kernel atomic
+	  cmpxchg operations when it is detected at boot.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 06de9d365088..9fd13d7a9cc6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -85,6 +85,9 @@ endif
 # Check if the toolchain supports Zihintpause extension
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
+# Check if the toolchain supports Zacas
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 808b4c78462e..a58a2141c6d3 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <asm/alternative.h>
 
 #define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
 ({									\
@@ -134,21 +135,41 @@
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
+#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
+	__label__ zacas, end;						\
 	register unsigned int __rc;					\
 									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
+		asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,		\
+				     RISCV_ISA_EXT_ZACAS, 1)		\
+			 : : : : zacas);				\
+	}								\
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
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
+		__asm__ __volatile__ (					\
+			prepend						\
+			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
+			append						\
+			: "+&r" (r), "+A" (*(p))			\
+			: "rJ" (n)					\
+			: "memory");					\
+	}								\
+end:;									\
 })
 
 #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
@@ -156,7 +177,7 @@
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


