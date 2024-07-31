Return-Path: <linux-arch+bounces-5750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2E9427FB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E5228A948
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600921A7211;
	Wed, 31 Jul 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3QavZXbU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BF17580
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411081; cv=none; b=o1GjdDlYBR/hxVlspL4mnzYh7sQa81J1A4UksP2sYYp9y3Hbh8YMmgHo6Kc9uD0XfI8pVHFSZDkb13VoG0yu2kuEsb1ecpEeikL9orHYbhzQWFksvBqvLEqJPst9nz0gCVf/dvSitRqhR66S0pLWChNtT4OU7kQBuJb/is94ncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411081; c=relaxed/simple;
	bh=BVlRaG9oeJyaltVO2VfM7RNLo0pxUx9YDfxmMHqs3GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qX/MOTwFZVGMvlHBfhwmjp1BeYRMT659ILK695mwhwP0XR0YdqTVn1USrUJs2VazVMFxh76jRnbWnkdZ3llSrrmgHEjz1DhRi0MtEuxojU+2JzxmY1ACwwTwhiXIal8mpfJ7EBBJM6wXmt4DmCLlGC4bIlfcJMg0lOyRxxBeSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3QavZXbU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so35021495e9.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411077; x=1723015877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHoHYllmH7EYuYJy+Jv8B241H4q5/CnBJ4HnToKFT0c=;
        b=3QavZXbU6dp4/R6igZ+eopofuf9EhloOCsSGGSswHlTKDwTfYImHTyePbg5uq1ePxS
         lceCEQLiv7wbirFvlORY9RzcdA99BCs/QcthiT2BL46ZqSxRLqUbNS6kuhlwZSu6P9Mn
         HkvlottjQlVhkThOVzhITsn6PcvCxm6Lj000ZakiY05pQhs4Eywep8empxaBXm602anK
         wZaqvDSL+hqAefafL95sdXuTnE2uFAiCkSH4YBQsk8IEnMBRKOkXtLCGVWSsuz30otDk
         WT11uqkjfPXbiLu/tuBgZVCghF3flYVb5JodCejJ8GDRywqlB/YLW/5gQKlJkQrmuIuk
         172Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411077; x=1723015877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHoHYllmH7EYuYJy+Jv8B241H4q5/CnBJ4HnToKFT0c=;
        b=YFdRzp5RXztaj0BLWyRkZwn8jhGN+8iLRe2jlkrbmmpqOYOsQJlCo3RBJhZq4lXdGH
         ucQnogp009Hm27GQV16qC3lKA937BWaUbcCmSbQLPd3KgjH7k2lS5pBdcgmTp9eWbp6V
         hwyzxEc70Pn8Erm3/m8TbD7wBVOe37sQXthK1arpmrkd6cLsigEjnsCBjNrfpTqKtG3Y
         Vyz4WSXwryzBn+RyKrOuarA2PBhLTkONMgfQRDIRDXc2dtJWD1xE+dJG1c/nEFuPPAGA
         U3F0v2BOhFM0XC+HOGw9Q6CkwPblfVa0F3kGcM+TnlYCptsjRIoaomMmm6t2wblCtNKS
         7GFw==
X-Forwarded-Encrypted: i=1; AJvYcCXm6cwZRbn7eze0tbnr/p7H9t+61SnrvoY3pJU8gemIldVhWXAW7wop509McLL1/Fr5v4ZaIuSnEDouiy2AdJMa7gdz/zu47feT2w==
X-Gm-Message-State: AOJu0YzI9s9bM/MNZWYM2NVkwUvov4deXc2h0giNoMnV/OU4VOiYcx0v
	kU+58dz9NTrFsJ0nXIbltoIDgI/ZT4mHBiaHYnuoAsVvtzN4+1tA7slqer03d5E=
X-Google-Smtp-Source: AGHT+IFWKmJ8e4ndadH473CTdPU3AlRXobOboTCXTtcOkKGrZDLPp8Y0XiEkCzxGJJj4GbuZsEuDpQ==
X-Received: by 2002:a05:600c:4447:b0:426:5c34:b19b with SMTP id 5b1f17b1804b1-42811d9af49mr92305945e9.20.1722411076723;
        Wed, 31 Jul 2024 00:31:16 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac8069sm10520875e9.28.2024.07.31.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:31:16 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 07/13] riscv: Implement arch_cmpxchg128() using Zacas
Date: Wed, 31 Jul 2024 09:23:59 +0200
Message-Id: <20240731072405.197046-8-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that Zacas is supported in the kernel, let's use the double word
atomic version of amocas to improve the SLUB allocator.

Note that we have to select fixed registers, otherwise gcc fails to pick
even registers and then produces a reserved encoding which fails to
assemble.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 212ec2aab389..ef55ab94027e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,6 +111,7 @@ config RISCV
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 391730367213..ce9613516bbb 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -276,6 +276,44 @@
 	arch_cmpxchg_release((ptr), (o), (n));				\
 })
 
+#if defined(CONFIG_64BIT) && defined(CONFIG_RISCV_ISA_ZACAS)
+
+#define system_has_cmpxchg128()        riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)
+
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __arch_cmpxchg128(p, o, n, cas_sfx)					\
+({										\
+	__typeof__(*(p)) __o = (o);                                             \
+	union __u128_halves __hn = { .full = (n) };				\
+	union __u128_halves __ho = { .full = (__o) };				\
+	register unsigned long t1 asm ("t1") = __hn.low;			\
+	register unsigned long t2 asm ("t2") = __hn.high;			\
+	register unsigned long t3 asm ("t3") = __ho.low;			\
+	register unsigned long t4 asm ("t4") = __ho.high;			\
+										\
+	__asm__ __volatile__ (							\
+		 "       amocas.q" cas_sfx " %0, %z3, %2"			\
+		 : "+&r" (t3), "+&r" (t4), "+A" (*(p))				\
+		 : "rJ" (t1), "rJ" (t2)						\
+		 : "memory");							\
+										\
+		 ((u128)t4 << 64) | t3;						\
+})
+
+#define arch_cmpxchg128(ptr, o, n)						\
+	__arch_cmpxchg128((ptr), (o), (n), ".aqrl")
+
+#define arch_cmpxchg128_local(ptr, o, n)					\
+	__arch_cmpxchg128((ptr), (o), (n), "")
+
+#endif /* CONFIG_64BIT && CONFIG_RISCV_ISA_ZACAS */
+
 #ifdef CONFIG_RISCV_ISA_ZAWRS
 /*
  * Despite wrs.nto being "WRS-with-no-timeout", in the absence of changes to
-- 
2.39.2


