Return-Path: <linux-arch+bounces-5147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4291820C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F10DB28D4E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4F184105;
	Wed, 26 Jun 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IEtghVvX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E2184109
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407463; cv=none; b=XuRT+JR/PjAbKRw5YqPNYowwYsIb7YDwIsSblG+hpNZkxqtKyoTtUl5Qm8DByO0KY+IcALrqYayrXXkYR6IunHZO+otqo4KdB2kDxEjY8ciIXBk7MbVU7AELkkKYsomfuwXzD/GQ4BuIs0baDc1TtLG8CjrO7XFaVVEhiRjvd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407463; c=relaxed/simple;
	bh=D53uFKdbu0rUSjZO/RVlECC1r3Mb1FnxEodoilYhPC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVTXSKlno8t6P4HgR7scjcJQgsBtr8AlY8htqmcEPLTxGqg5SPTJlcnp8oqFTU78/KZoycTT7fpoJgg9/DBpK/YwBUAu/opmBmybij69ZhfSfO7x4O98uaaHvhlt99xWpeEXiT7JtkCNAVndfGwQ9pxt8xbfBzxzBjCHOXXOr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IEtghVvX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso5177105e87.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407460; x=1720012260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6cx0+kPy/mr4m8koR629ifIafAeU6/dHlLYYLSwNIk=;
        b=IEtghVvXiJf7ehJl2QugBxx8rwqTEU/FoFwTu+EgEkg5IA8ns6Le5fKDbQPapjTG/L
         r2MQTVXcpCJgmTLTqWK2icY++f32/F6/Zrcha9Q24EJzkuAvS2KhgzxgFBsfjWmTV8Qn
         bMI/rXJTtRW2Li+XFCVYWx/QRCHvMG1BypF3l7SYTyNV1AP4AJZfeCrQT7A24lqlIO5M
         Zmig65N6w/50aqfXmpH/m3nSoWsGm7SqvIR+M/2l1JKHLX2vEQxDDyI0FI89/XO20faL
         dDQVRd+5Mcv78XSAzhPZlBbEUZHr2ZoUCa0ZWpX7ndtqwaGdfNx6w4eLE5UOyFLFx5wf
         Wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407460; x=1720012260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6cx0+kPy/mr4m8koR629ifIafAeU6/dHlLYYLSwNIk=;
        b=gw3xezELFCiT0l0PddsgRGlAvz2g/vpdaOoiGuEj/U4gRL16WFwM4iFga7ufWVWKUG
         P3gQ35RGSEFTC5YWqteEDJMP1jOlRU8bbn5deqkJ7WJw+Obb12xtf9iJTA4ueu+t93Ap
         OswigatH38uCHR1y8Jwmer3PrHkMiKOBWB86HM5gScpnvByWcgV0dCNFgAtds+OloPDq
         0t90xmJ8+mKJpIkoHyBGzJ6Kag9FmDzZkO9AN5VyXkzVShtzZq47a64slAfNR9Z5Xg2n
         yWVfsu770YyQvZ+xt1uItqrrevuX4dJM+xU2txBnqdjgK4BDpy7AshiUu95OLoPKTRMe
         A7Og==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9xzlMrFsrOGA28YRQsO6Tq5YJCoP5117E1DS0RjE4UQ5JKeUvELGh5+sW4N+PUOhg0lFdkwCXGjjeNAlGETlX0tg8N43jN6Sfw==
X-Gm-Message-State: AOJu0YzwG9JgeNtwgmZskp0kUiceOYu9MRPpNH2euLgY9yyC4aHAc5J5
	mEfPhdVBU3Lmu4MKTrlHX0FGRFD8BgYGaXybDdlUaxDRRqgTwFkUAULdahcelsA=
X-Google-Smtp-Source: AGHT+IEtNRZjWCdEzOhHydNYZbdtsSBOyhgctkoqWdBmAHXNA7jMkTIIYGJ6ebJAtMiVgYJ66wbTgg==
X-Received: by 2002:a05:6512:1cd:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-52ce18324ebmr7017333e87.13.1719407460052;
        Wed, 26 Jun 2024 06:11:00 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c824eef1sm24890125e9.14.2024.06.26.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:10:59 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <andrea@rivosinc.com>
Subject: [PATCH v2 07/10] riscv: Improve amoswap.X use in xchg()
Date: Wed, 26 Jun 2024 15:03:44 +0200
Message-Id: <20240626130347.520750-8-alexghiti@rivosinc.com>
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

xchg() uses amoswap.X instructions from Zabha but still uses
the LR/SC acquire/release semantics which require barriers.

Let's improve that by using proper amoswap acquire/release semantics in
order to avoid any of those barriers.

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 35 +++++++++++++-------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index eb35e2d30a97..0e57d5fbf227 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,8 +11,8 @@
 #include <asm/fence.h>
 #include <asm/alternative.h>
 
-#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
-			   swap_append, r, p, n)			\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, sc_prepend, sc_append,	\
+			   r, p, n)					\
 ({									\
 	__label__ zabha, end;						\
 									\
@@ -31,7 +31,7 @@
 	ulong __rc;							\
 									\
 	__asm__ __volatile__ (						\
-	       prepend							\
+	       sc_prepend							\
 	       "0:	lr.w %0, %2\n"					\
 	       "	and  %1, %0, %z4\n"				\
 	       "	or   %1, %1, %z3\n"				\
@@ -48,9 +48,7 @@
 zabha:									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
 		__asm__ __volatile__ (					\
-			prepend						\
 			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
-			swap_append						\
 			: "=&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -58,19 +56,17 @@ zabha:									\
 end:;									\
 })
 
-#define __arch_xchg(sfx, prepend, append, r, p, n)			\
+#define __arch_xchg(sfx, r, p, n)					\
 ({									\
 	__asm__ __volatile__ (						\
-		prepend							\
 		"	amoswap" sfx " %0, %2, %1\n"			\
-		append							\
 		: "=r" (r), "+A" (*(p))					\
 		: "r" (n)						\
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
-		   sc_append, swap_append)				\
+#define _arch_xchg(ptr, new, sc_sfx, swap_sfx,				\
+		   sc_prepend, sc_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -79,21 +75,19 @@ end:;									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
 		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 2:								\
 		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".w" swap_sfx,  __ret, __ptr, __new);	\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".d" swap_sfx,  __ret, __ptr, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -102,17 +96,16 @@ end:;									\
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "", "", "")
+	_arch_xchg(ptr, x, "", "", "", "")
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "",					\
-		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, "", ".aq", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
+	_arch_xchg(ptr, x, "", ".rl", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
+	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER)
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.39.2


