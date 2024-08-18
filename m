Return-Path: <linux-arch+bounces-6291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE619955B71
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712D61F21BD0
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13BADF51;
	Sun, 18 Aug 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w7FGP3pO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0200DF59
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963253; cv=none; b=Pjzoph9i3exbgta8krG4PUWkQNntqYiGyjL+qptdc7waGT9AaU/+nj6a1qaQU8q+BpzzTAAOTfrTx7N/lrYoc0K6wH+hLJ4FeIbYn/H3Y9zRefHlbTUd1oLutZAfGnLfAQjOXcJgiEg/PXgsE6eDf4e2qbvhxblRUol5Y2blljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963253; c=relaxed/simple;
	bh=d146KF2PKTmU6liiBvLIfIT43KxtPmJKXqkUFUiewAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofX+Y7p0AG89Q61KJdXN/QlRPQE47co+/8ex0YjPMfkeUbzPxUYa29VoepLd2VtmGJJXOH5tj53n60QujVxyTWEAxn+T6AzBlsgeJGpJKz2YZ34KKC1TmbXdtX5TLrn9S9CTpxr9WtoDQm5tfKOUVXesXcMF+S4NpA/XkQvG/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w7FGP3pO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37189d8e637so1903106f8f.3
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963249; x=1724568049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZGnwjJ9zA50deMtasLoWGJlTqCTlw/AR/rhuAE8IZk=;
        b=w7FGP3pOgwZuG4ZS20G8DlEeLVtI6PMAXwNPp0g7XnKaoC3pb+z0P8jcgaEYx3ueSU
         f+S1vdz9MwcsBVZ8SbifPXHW4QLxFp4wSV3NqMN3qxuFvUJJpnEhU868KYU9ZIviOUOl
         roxa3MzpI3Q9L7S/sn19i0A4wZRvk0A6T+qBB1yCmhZXKnW/5sc88s/ZpLPb0sTH/C7Q
         HzBS6n13t8kli7vqfgxPHTyH59M3PAQbnjf3Kv56vaq2DMduR9Uiki9ch0il259tyFaT
         +jwxRBxbAS6mTGQ7gQqLDBTk+sm5dw5OH0jOnQFZiMvfMYolTG0WGKzmB2zhjHAD4PvI
         dW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963249; x=1724568049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZGnwjJ9zA50deMtasLoWGJlTqCTlw/AR/rhuAE8IZk=;
        b=qCcOzsU1q33sl0xLcMtfOK/mLNRKgZMRUPgd8MDo/uB+3otoFhlHRPY+5SxgoHSNkh
         0Kzl9+l7u13N8Q/nJz++99prFanxTppW7RacWQd7YF2f2p0c8LNHYTG3Dsj8wrDpB29E
         kpX7ITt5olDhawuhyy0YiGJQ74VNSk/4MX3TRChD7QiKcw6tKzL8B3PeISZGOh5NTRG0
         uz46h/gsAxf15KhXaQu9GkwrIivo/sO/cbNWECpHQ5O2UIxe7G69lnEZzV000jDgu7ep
         06Sf1WONyDRmhESMEoh/0HU34t64xTKutIe3xIa3jp0nP190ah0cd4A3HoYPXpEUqXGP
         8GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcD5+Ph+lfu+TCtJFcZnV5IQTEZ7us4LcksveHZjFEirzWOIq43c8BC7cNo9ouV/aV0iKwvAlxRWayUQJ/LdX8AZIGYYv5IM1fMQ==
X-Gm-Message-State: AOJu0YxFZKHUDjw8q0+ytPlws/tkRcHWr9YT6bWnrDEPF7ze2LHUUJbF
	dP/dW7GM9k/0jq9HVdbKFTd+zf1FvZpetJn7vmbhf/7+HT2f77k7OrXLmWXhSwY=
X-Google-Smtp-Source: AGHT+IH5q0bFu/E9vYl6O9ntKbWhfQ/kqCOKwUu/eU0CrpOWwaixsLysU9gopA/iIxfwBIo3S9Ykcw==
X-Received: by 2002:a5d:53c5:0:b0:371:7d84:9bef with SMTP id ffacd0b85a97d-37194651551mr4876064f8f.28.1723963249067;
        Sat, 17 Aug 2024 23:40:49 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabdesm7286232f8f.99.2024.08.17.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:40:48 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 05/13] riscv: Implement cmpxchg8/16() using Zabha
Date: Sun, 18 Aug 2024 08:35:30 +0200
Message-Id: <20240818063538.6651-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in cmpxchg8/16() operations.

Note that in the absence of Zacas support in the toolchain, CAS
instructions from Zabha won't be used.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/Kconfig               | 18 ++++++++
 arch/riscv/Makefile              |  3 ++
 arch/riscv/include/asm/cmpxchg.h | 78 ++++++++++++++++++++------------
 arch/riscv/include/asm/hwcap.h   |  1 +
 arch/riscv/kernel/cpufeature.c   |  1 +
 5 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d955c64d50c2..212ec2aab389 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -613,6 +613,24 @@ config RISCV_ISA_ZAWRS
 	  use of these instructions in the kernel when the Zawrs extension is
 	  detected at boot.
 
+config TOOLCHAIN_HAS_ZABHA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zabha)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zabha)
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZABHA
+	bool "Zabha extension support for atomic byte/halfword operations"
+	depends on TOOLCHAIN_HAS_ZABHA
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	  Enable the use of the Zabha ISA-extension to implement kernel
+	  byte/halfword atomic memory operations when it is detected at boot.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZACAS
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index f1788131d5fe..f6dc5ba7c526 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -85,6 +85,9 @@ endif
 # Check if the toolchain supports Zacas
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 
+# Check if the toolchain supports Zabha
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 39c1daf39f6a..1f4cd12e4664 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -108,34 +108,49 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
-({									\
-	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
-	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
-			<< __s;						\
-	ulong __newx = (ulong)(n) << __s;				\
-	ulong __oldx = (ulong)(o) << __s;				\
-	ulong __retx;							\
-	ulong __rc;							\
-									\
-	__asm__ __volatile__ (						\
-		prepend							\
-		"0:	lr.w %0, %2\n"					\
-		"	and  %1, %0, %z5\n"				\
-		"	bne  %1, %z3, 1f\n"				\
-		"	and  %1, %0, %z6\n"				\
-		"	or   %1, %1, %z4\n"				\
-		"	sc.w" sc_sfx " %1, %1, %2\n"			\
-		"	bnez %1, 0b\n"					\
-		append							\
-		"1:\n"							\
-		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-		: "rJ" ((long)__oldx), "rJ" (__newx),			\
-		  "rJ" (__mask), "rJ" (~__mask)				\
-		: "memory");						\
-									\
-	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
+({										\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
+	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA) &&		\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {		\
+		r = o;								\
+										\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"	amocas" cas_sfx " %0, %z2, %1\n"		\
+			append							\
+			: "+&r" (r), "+A" (*(p))				\
+			: "rJ" (n)						\
+			: "memory");						\
+	} else {								\
+		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			       << __s;						\
+		ulong __newx = (ulong)(n) << __s;				\
+		ulong __oldx = (ulong)(o) << __s;				\
+		ulong __retx;							\
+		ulong __rc;							\
+										\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"0:	lr.w %0, %2\n"					\
+			"	and  %1, %0, %z5\n"				\
+			"	bne  %1, %z3, 1f\n"				\
+			"	and  %1, %0, %z6\n"				\
+			"	or   %1, %1, %z4\n"				\
+			"	sc.w" sc_sfx " %1, %1, %2\n"			\
+			"	bnez %1, 0b\n"					\
+			append							\
+			"1:\n"							\
+			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+			: "rJ" ((long)__oldx), "rJ" (__newx),			\
+			  "rJ" (__mask), "rJ" (~__mask)				\
+			: "memory");						\
+										\
+		r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	}									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
@@ -177,8 +192,13 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_cmpxchg_masked(sc_cas_sfx, ".b" sc_cas_sfx,	\
+					prepend, append,		\
+					__ret, __ptr, __old, __new);    \
+		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_cas_sfx, prepend, append,	\
+		__arch_cmpxchg_masked(sc_cas_sfx, ".h" sc_cas_sfx,	\
+					prepend, append,		\
 					__ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5a0bd27fd11a..f5d53251c947 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,7 @@
 #define RISCV_ISA_EXT_ZCF		83
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_ZABHA		86
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b427188b28fc..67ebcc4c9424 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -322,6 +322,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
+	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.39.2


