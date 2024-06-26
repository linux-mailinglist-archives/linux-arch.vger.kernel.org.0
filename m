Return-Path: <linux-arch+bounces-5145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957949181FB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46B7B285C5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799391836E2;
	Wed, 26 Jun 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3EsF6Hbk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196B187336
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407341; cv=none; b=LzIcgSGReQ2nV4CKuWj/etNDvpNQsUOZur83HdtJzn/LholohD/GiRNP8k7pXq220IY8Oyy9mQwL4P9KGX9wBmy+3KEFvwrWWXHjV25Asn7yIBMEgQ25wiY98NSb+utIa2f8mBd9R8auE+ZB1hFzKnTWr3rbZNSIqW1cHg/anQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407341; c=relaxed/simple;
	bh=n6pkAuT24rtEoXNw0ZKKew3iM/VuDUjre3EgSariM/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DONWwYrdSnxR/hZuUsk+jAAp1SaUG4JIm7MBo16yhhFRlYlePQcodWfMCFQt4zZJRnZuTSmKWiqAYzKWGAJIiQ/lFltjXhlPXFepnJ4kbxXD/9A0joyzBkvx0rbYalUCzNeUaKQpgaZLXkRHhpiHdA2vc2EEj0gvhCuKfBnzsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3EsF6Hbk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e72224c395so77364281fa.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407338; x=1720012138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAwsmjkuECiz/mPkaZn9ympydsm9zMlHdoAoEYhhRo8=;
        b=3EsF6HbkdjpczwL8z8ejw1byJWZxllkKXdUXAx++G6KlBPycETsXvkXXq1jtTqGjj4
         QZyadlgwdf3xLQtRKzSOw7gZpdVraL3uLs8PoEhek0nm/ZWPnL1AnfpeeO+7c4Jce0Pu
         oX228uHyHwgh8LKeYAEwisMNGvNAhEG1wVpBz9nfy+hAy9lUSc7PUF1wcnFSEiIetNss
         RwhfW8eb//MwqgOFmamG2i8KrV6KH+OPcLFERbRDrlqHjwxd710Lxb7G7hKfYyY6/adK
         tp2JEhQ7KznT/UNrX3V7dIobuE0qgz0xQ527yyJveOolrFxVOiSIEsCGA3NOADFS63gU
         blrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407338; x=1720012138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAwsmjkuECiz/mPkaZn9ympydsm9zMlHdoAoEYhhRo8=;
        b=M4YMIGVOak2GvZJ8M/YOuM6fip/aW1XzBmVWmuaNXItl72qlwyWQhat1zVvrvq/2hp
         LOdO4sHSxhqFZMaRtBn8Sd1gcUyv3yDS7Z5I/KqZcyh3peulApNpjIeVnZsTB2Piae6B
         o2xjAhH+W4W8/WSrWgdD3ALB0E6KjUXlOVGY+9msJRTcQxthvOmDEm/CgrZksZKq+3R+
         RZ09gPCYTUqDij7nNCt6ZU8t2Dv2QM5kUzTDHHI3iViN3Y+XOZ4ioN1NhCuqpBZggPvw
         MZrNOkeJ+msU+b07K+8/lqSQkBztZMLoy6BeNKbkQmTPRyQ3mZiIA1E1/d4SkbfTJ1NW
         nX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW7M89t5SnUzdyQgjDySAuU+JcB02qEjBbqNo1mK9RzvvD/kEUS0wBXD80UJwnf5f+XiOeruuitJQ/LEHYxfrNqVr5HPOmyYK8DA==
X-Gm-Message-State: AOJu0YylvK2e+FCAhaKvN6Q58JcO/aaA7nKeqpA/NI2i9BADLFaOqR/q
	CNDnlk7XO+3O3KVnwy/+cPmhkO0RiICcFcRCV1eyY+vNwHwVCClSZZGsqybBZdg=
X-Google-Smtp-Source: AGHT+IE6IYtOzpJIWWby5oBtItvoKm+O8WuyMECCoA3dQcwC4BqVw/peghmNdO01PLv674LqbGf4lw==
X-Received: by 2002:a05:6512:6ce:b0:52d:b1bb:370 with SMTP id 2adb3069b0e04-52db1bb0490mr1964462e87.23.1719407337732;
        Wed, 26 Jun 2024 06:08:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8266bd5sm25627705e9.26.2024.06.26.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:08:57 -0700 (PDT)
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
Subject: [PATCH v2 05/10] riscv: Implement arch_cmpxchg128() using Zacas
Date: Wed, 26 Jun 2024 15:03:42 +0200
Message-Id: <20240626130347.520750-6-alexghiti@rivosinc.com>
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

Now that Zacas is supported in the kernel, let's use the double word
atomic version of amocas to improve the SLUB allocator.

Note that we have to select fixed registers, otherwise gcc fails to pick
even registers and then produces a reserved encoding which fails to
assemble.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d3b0f92f92da..0bbaec0444d0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -104,6 +104,7 @@ config RISCV
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
+	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 3c65b00a0d36..da42f32ea53d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -280,4 +280,43 @@ end:;									\
 	arch_cmpxchg_release((ptr), (o), (n));				\
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
+#define __arch_cmpxchg128(p, o, n, cas_sfx)					\
+({										\
+	__typeof__(*(p)) __o = (o);						\
+	union __u128_halves __hn = { .full = (n) };				\
+	union __u128_halves __ho = { .full = (__o) };				\
+	register unsigned long x6 asm ("x6") = __hn.low;			\
+	register unsigned long x7 asm ("x7") = __hn.high;			\
+	register unsigned long x28 asm ("x28") = __ho.low;			\
+	register unsigned long x29 asm ("x29") = __ho.high;			\
+										\
+	__asm__ __volatile__ (							\
+		"	amocas.q" cas_sfx " %0, %z3, %2"			\
+		: "+&r" (x28), "+&r" (x29), "+A" (*(p))				\
+		: "rJ" (x6), "rJ" (x7)						\
+		: "memory");							\
+										\
+	((u128)x29 << 64) | x28;						\
+})
+
+#define arch_cmpxchg128(ptr, o, n)						\
+	__arch_cmpxchg128((ptr), (o), (n), ".aqrl")
+
+#define arch_cmpxchg128_local(ptr, o, n)					\
+	__arch_cmpxchg128((ptr), (o), (n), "")
+
+#endif /* CONFIG_RISCV_ISA_ZACAS */
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.39.2


