Return-Path: <linux-arch+bounces-4558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366508D200A
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B9B1C231DF
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA3171E54;
	Tue, 28 May 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1SbsL9C+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4417167F
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909242; cv=none; b=Y7bKcwLVmObb5sItfzpjKmASXtAkDpqeCjAworei5VkaagoXE2pVnhoIi59/SMASqPfys4CqKRzgT1c6rDRKSEZ8rGxWcmtHtZLqGCNqFOa6Q5rHLiyP34w8f9V6viLqb++6A83x0Obm55dG2bZxsdJ3df1jxdadyF436vHaF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909242; c=relaxed/simple;
	bh=EjieqW/8+JJzLLoBTQFYN8FJzpAcjOBh3yjPb46+kqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hw/idvgxNkXnR7USKpO5HkyrSQSY21HPmW5Gt08USDy9VHSxHhKH+D8xl295RG2yX/56FhnpZBY0Om4HPe+TKKKS82uWyL5kXhPFQl9VsdiUf1tcYYfpugIququxHFJhZGw3CcnvnhN2bM9E8D+FJWkW/QEuEQQMagbUukH8IQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1SbsL9C+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354fb2d9026so833879f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909238; x=1717514038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+QNuMhUn/mhPs/6E1/sFkjL9Li5Z0ATbah2dvUIKDM=;
        b=1SbsL9C+aAEmI7DUG6TF8zOSrpOD5d/TBkCYFXAThbsUY9Dl4H0aorxErXDwgaPXRl
         DfvU4jc//kaQ3fw2I2mS5n98wDQm3XOwcF9hIaHO6z9WCZYi93oVyTtIJxiXmVJPXiwX
         2YeVHhxiQlXSEFpx4IYaADDq+VIOpWCcDH7OTJkXWx3rTjKc5fOQoZSmsLy048bUKKgl
         +PvbB830GO8KKlDZZHFTFShoC3lREJIMS4919Fdvsn2nmd4eIvajLXNbCvC3ZLb8HTev
         jWX8vwa6E6vOGFYidlE/c9Xxo28Y6Dc1U3BilZmDsgX5X2xBRnCIWNM0ADhoSO6Nushi
         f1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909238; x=1717514038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+QNuMhUn/mhPs/6E1/sFkjL9Li5Z0ATbah2dvUIKDM=;
        b=PeFpTx1E4t6tKUX801oLXk3FeqqkASHm/9ZUa32csX/LC4jhullm40WBBjYf5VFKDp
         d+Zpe+dDk5vIVpejG0mks8+EqOsj5mWgCj+54HyJBFPQ9NaJJeXeVaFH3hw2I+qM46/T
         EMcemfLAtpYaxrs85uHMcVsc89DsY+6xE5nlZsXN8M66zOYSDEe2qCF0bjVFSOGc3wqH
         vNg6m+aVgWEoCuSgX8YvES2YCLy3w04bOEYRxVdFNumuWZVavXYRD7/5Ovembr6ZLrjh
         dMdc84Je/yr5eAkv+cTSYd6GOYhOM/lwMQGU9dQwLPqaz1DApNEzkJd/4rj5jJsgdGbE
         NF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw8IRyUVIQ7NpAKcgJtk2WRUbjrs1HYNU7gBF5fxOea6FuiUFISvwS+LG1/leCRSLZCwHrQf6a7kRXReyhRGTwMY9p/GpsYtH9NQ==
X-Gm-Message-State: AOJu0YzVXrNEcIIseL14Plo7mI7yPzVi6JsEB72PEB93mtIAnnzpks+Z
	RHVX2qdIDlfjsYMtC5kpDxOMo13jkSscfW3xEl9XHzYTRrjhIiNZPIQhZzEfUOo=
X-Google-Smtp-Source: AGHT+IFax4v0kzQv5SDc3SAQTe47rQjW60kRd6Vmso4QAx01vZU4yzSYIPRZPjT4yaPXSVHdqYbyVw==
X-Received: by 2002:a5d:558d:0:b0:34d:74cb:c0be with SMTP id ffacd0b85a97d-35526c569cbmr8166449f8f.35.1716909238142;
        Tue, 28 May 2024 08:13:58 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0908e4sm12094483f8f.63.2024.05.28.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:13:57 -0700 (PDT)
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
Subject: [PATCH 3/7] riscv: Implement arch_cmpxchg128() using Zacas
Date: Tue, 28 May 2024 17:10:48 +0200
Message-Id: <20240528151052.313031-4-alexghiti@rivosinc.com>
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

Now that Zacas is supported in the kernel, let's use the double word
atomic version of amocas to improve the SLUB allocator.

Note that we have to select fixed registers, otherwise gcc fails to pick
even registers and then produces a reserved encoding which fails to
assemble.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 05597719bb1c..184a9edb04e0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -101,6 +101,7 @@ config RISCV
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 65de9771078e..0789fbe38b23 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -242,4 +242,45 @@ end:									\
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#ifdef CONFIG_RISCV_ISA_ZACAS
+
+#define system_has_cmpxchg128()						\
+			riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)
+
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __arch_cmpxchg128(p, o, n, prepend, append)			\
+({									\
+	__typeof__(*(p)) __o = (o);					\
+	union __u128_halves new = { .full = (n) };			\
+	union __u128_halves old = { .full = (__o) };			\
+	register unsigned long x6 asm ("x6") = new.low;			\
+	register unsigned long x7 asm ("x7") = new.high;		\
+	register unsigned long x28 asm ("x28") = old.low;		\
+	register unsigned long x29 asm ("x29") = old.high;		\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amocas.q %0, %z2, %1\n"				\
+		append							\
+		: "+&r" (x28), "+A" (*(p))				\
+		: "rJ" (x6)						\
+		: "memory");						\
+									\
+	__o;								\
+})
+
+#define arch_cmpxchg128(ptr, o, n)					\
+	__arch_cmpxchg128((ptr), (o), (n), "", "     fence rw, rw\n")
+
+#define arch_cmpxchg128_local(ptr, o, n)				\
+	__arch_cmpxchg128((ptr), (o), (n), "", "")
+
+#endif /* CONFIG_RISCV_ISA_ZACAS */
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.39.2


