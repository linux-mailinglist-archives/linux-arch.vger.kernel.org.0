Return-Path: <linux-arch+bounces-5442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF299336FD
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E901F23FCB
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC4156E4;
	Wed, 17 Jul 2024 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FQgOsYRw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9752FB6
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197572; cv=none; b=kqBLaXewdVtfBGE7J6Dv6TSgNSO1ofVsI/I2qyzwjYDISoQ4uMdK8Ps6G9isR4SAGlboI6AAXUYeSWRS11OWyvWD6e14M6XFDqgg6Ft0+exgxl6i8T789H7sk9CMlT3+qpkMOMGEu61FqFHO1VoWzIsqRCb0sVK4dIlCdi59lzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197572; c=relaxed/simple;
	bh=B1CnHSwQzyKmmdw+P7nNrDoltmKChpydt1ud39gLqxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvFxx/A/hvofrHoFe+lTeI/T1jmYh8vUwCo7nCQeHE0EiTNNKYpE9QAYvWYuaAp/oC3VVk0dKBJjAmOpVqGodqLs5qg8FVEfm6BT6h0NVDherrBbLNymWEdL3gfoTdinzaEZ714OzPyGB7A8xMazuxNU8MOMjBOuXWDujdXiDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FQgOsYRw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a183df54so4251890f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197568; x=1721802368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zMQJJ1+QlmFm418V6AGBGbWQY3rNoVY0h/UyfCjPDE=;
        b=FQgOsYRwvLW0Cu4ZvNaG5VIIAj9nXfg+4Vxz5MVKLHJGXYneZ5jZ09G6DFlGlwZQQO
         Y96ai4rvo3iqFPOamN2ubA4HbLsuGEFv1KylQ8xJo9WnOYi4zVCev7mqAgDEY9Y9vOi1
         T6WDpjCbV1gNEWZhwtkF6CGhEZQZbp9menI/4ieaykkk4UicX2bLv1Qb1YF5eoWj/tE2
         ZAa0ORNJ8b1GQpO/LOGZo3fTBHUPBsARKvjViKzZ+UquwosuFf9OQABeBIn/xOAyGicB
         vlvdDITzLP3subtegbjYr+e4wl91Pu/Tvd0cldkhG8jMzhMwh1uyg6Djq/YcNukH+boM
         UI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197568; x=1721802368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zMQJJ1+QlmFm418V6AGBGbWQY3rNoVY0h/UyfCjPDE=;
        b=lwjqy775S1H9KkrFvP9vYazV5NtiIk+MP9qugQkeb14LrPxQLoKaAWV6wO0/CqGwB7
         irq8KCazFPkz18OW+WCIp5lflWlICiV3X60IMDPvqCB8MB9uLJcLzsz2F0KjT1GmtiIN
         kU+x2FJrICTwkrcF1Nf9+XyjKzwrrzZYDyxjgOJ3Sk9/U1j0h4zmmf9y0L9nV+poST5p
         F52w7bNyCzUCmSnhLTE9EMRTjOwIqrip8omxfBq3DiVQSbG43AQA+4b0svtTGjh6kOX3
         JC0rRtLwv9rLENkxRXxIAEcV0QlUqPdhC51d3GmnhscHfl6wYNhAdnzWe9GEcRWSyEho
         lkJg==
X-Forwarded-Encrypted: i=1; AJvYcCWbXDWZS8rU+xtmiP0KqRiRbQr6/aLhM9Udi0hvOC1fI/mPHN3wNCosnaRtZAYEWTygq1b5zNqjOJB4UCvXqZBgAflKMLt0kaU1hQ==
X-Gm-Message-State: AOJu0YwdkFPfT6eFHo/kKb2TEtzVIRr2IVcestgQDgjA4w2vhQKk39kz
	sBOyxmuoBL4j0/9PJYNlt6tLtkaBXIDhuM2GTK/5njUpirJW5hZZxJEP7Izi+1w=
X-Google-Smtp-Source: AGHT+IE6uNjEd3rgzo2cnMZIenDe0Lf33upNb/sgH/fJlHpS9fKERnXLFFmQs0acmED+vAQAC04L2Q==
X-Received: by 2002:adf:e681:0:b0:368:3079:4277 with SMTP id ffacd0b85a97d-3683165b50amr545623f8f.28.1721197567667;
        Tue, 16 Jul 2024 23:26:07 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368111d3e7dsm10358022f8f.87.2024.07.16.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:26:07 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 06/11] riscv: Implement xchg8/16() using Zabha
Date: Wed, 17 Jul 2024 08:19:52 +0200
Message-Id: <20240717061957.140712-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717061957.140712-1-alexghiti@rivosinc.com>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in xchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 608d98522557..091e6612ddb3 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,8 +11,27 @@
 #include <asm/fence.h>
 #include <asm/alternative.h>
 
-#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
+			   swap_append, r, p, n)			\
 ({									\
+	__label__ no_zabha, end;					\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
+		asm goto(ALTERNATIVE("j %[no_zabha]", "nop", 0,		\
+				     RISCV_ISA_EXT_ZABHA, 1)		\
+			 : : : : no_zabha);				\
+									\
+		__asm__ __volatile__ (					\
+			prepend						\
+			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
+			swap_append					\
+			: "=&r" (r), "+A" (*(p))			\
+			: "rJ" (n)					\
+			: "memory");					\
+		goto end;						\
+	}								\
+									\
+no_zabha:;								\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -28,12 +47,14 @@
 	       "	or   %1, %1, %z3\n"				\
 	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
 	       "	bnez %1, 0b\n"					\
-	       append							\
+	       sc_append						\
 	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 	       : "rJ" (__newx), "rJ" (~__mask)				\
 	       : "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+									\
+end:;									\
 })
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
@@ -56,8 +77,13 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
+				   prepend, sc_append, swap_append,	\
+				   __ret, __ptr, __new);		\
+		break;							\
 	case 2:								\
-		__arch_xchg_masked(sc_sfx, prepend, sc_append,		\
+		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
+				   prepend, sc_append, swap_append,	\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-- 
2.39.2


