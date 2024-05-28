Return-Path: <linux-arch+bounces-4559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8038D2013
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D76A1C23230
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4F172BD5;
	Tue, 28 May 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yntQABQd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C917082D
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909302; cv=none; b=mpHmuxW/724QC3G/kpFkEOHW1XMVu2AHmMVmVTdJtOxm8iXbGfFNxcyC4dUbpZkwvZZMphmYKzsfeatL2k16aQgrwhGRddXL+PFEfL9Ep0Y0B3NX7c/qYcrsSHxlFgYUkxR7H+KTQEyCRqgwR78uHI0s4ShDQ396f8vpJx1K/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909302; c=relaxed/simple;
	bh=byVCn7vyyoWVCExOcLktbP9jgpsI9hB8fTXW6dyI5l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbUfbkl9n6ls4n9qUtgEx0yrDC2sI0G6uM0tfC9nCrvPe1ypSXiMDE+lGhNyJ+WQJQeuuviL3tOQRDjNlcYhRL1ti2dcJhY+aVrdjYw8/qYrnD7CHAABW9HOK2e4LUpY5v82GmatxOELDYgNDUeY6V85HbG6C4NZaXnDpgUEe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yntQABQd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso12972581fa.3
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909299; x=1717514099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ9jfwQtVSCqEew5FGQUfrRX44QJ3TNBiU9EdF5jARo=;
        b=yntQABQd2Un8Wr1ZeQtRfwEySXNs4PXXc/bgKeXzgUEt1lh/x8IbAJLtmuIRWveMrI
         dKQkyxJ3VIo2a0vAt5uDvuhz6zyhhA2RNlNP/eW+BWUVr5rT0Ww02jxkXbdFQR+Q8yx4
         raDEp09sVL4gbBA1DccmNWhyl7gTdZXJvbzruYtfURxWL+hMZc6CcpOf09ku3qW6Cwtu
         aZoJ1pnA3C1kztX0H8fCuHbLIBtxvZv8Bw/w5xr378I3F4yLwuNSPJzcxSSHH5EMM2Xx
         IZKSVfSsogKL7bB73qRmhm7xTNzRnMgfVIPLjDylZX4XTRfQ8OesccCwwMZKIXZXlWZ8
         93sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909299; x=1717514099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ9jfwQtVSCqEew5FGQUfrRX44QJ3TNBiU9EdF5jARo=;
        b=XwfbvzknEJi60E47sSKyOqwjVSsMnbkL7au1HpDqZM9W1Iu0Uhqq2rgwpYUijQvo5h
         8TbUrsv0pcIFwgiUHj7I63QyfJ9HwqjZ2gxEahT+BTrhA/uS73CtldoJyMKuoSPna4z5
         +hIXNJWBF/2Y2a1BjnM4eReBir8+GJOkn27zKV8LXn5xeE3QlWIlfLJMJMSJ9Of8lWGt
         6K55RWWF4KgdI65MAdRCjEwi3QQZ2/4NMF8/790TPRX1caA4/nqleAA2DA5ElSnCLeH3
         OhjKLdAiOooHyavJSpuliCzRH+0HDB4Rh3bpRpynB9Wo/DxuvKFkO/wnLTC+e1JN89rO
         2FNg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjhYEUWykVfaJ2dk5EXaXQfTkwj5+e7RAzaeOxjicuRmCjQ++ftg+kMaU1hM1Yiw44JBS3YffuytDO0XMk6uIT3wVF0AoQQfvsw==
X-Gm-Message-State: AOJu0YxQlVWH1+M0cxp9oGvfPWQwxiW8det+ymdWAu1PkkNGNbpGxBsF
	WBu4ZrGizlWFM4INLn21hD+40EIglgFa3zulL8llHXyZHYeUY0PIVh/bthtqfi0=
X-Google-Smtp-Source: AGHT+IE9xnl9B6iLJUPGftImcREYfkzUqsxyaCtbYNOO7bdA0+3T64EEnX3IW7R8WIRTpy4sMb+IqA==
X-Received: by 2002:a2e:a7c3:0:b0:2e9:546c:544a with SMTP id 38308e7fff4ca-2e95b28ae5emr87639391fa.34.1716909299278;
        Tue, 28 May 2024 08:14:59 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089708f8sm143918715e9.20.2024.05.28.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:14:58 -0700 (PDT)
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
Subject: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
Date: Tue, 28 May 2024 17:10:49 +0200
Message-Id: <20240528151052.313031-5-alexghiti@rivosinc.com>
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

This adds runtime support for Zabha in xchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 24 ++++++++++++++++++++++--
 arch/riscv/include/asm/hwcap.h   |  1 +
 arch/riscv/kernel/cpufeature.c   |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 0789fbe38b23..43696d9e13aa 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,8 +11,14 @@
 #include <asm/fence.h>
 #include <asm/alternative.h>
 
-#define __arch_xchg_masked(prepend, append, r, p, n)			\
+#define __arch_xchg_masked(swap_sfx, prepend, append, r, p, n)		\
 ({									\
+	__label__ zabha, end;						\
+									\
+	asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,			\
+			     RISCV_ISA_EXT_ZABHA, 1)			\
+			: : : : zabha);					\
+									\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -34,6 +40,17 @@
 	       : "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	goto end;							\
+									\
+zabha:									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amoswap" swap_sfx " %0, %z2, %1\n"		\
+		append							\
+		: "=&r" (r), "+A" (*(p))				\
+		: "rJ" (n)						\
+		: "memory");						\
+end:									\
 })
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
@@ -55,8 +72,11 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_xchg_masked(".b" sfx, prepend, append,		\
+				   __ret, __ptr, __new);		\
+		break;							\
 	case 2:								\
-		__arch_xchg_masked(prepend, append,			\
+		__arch_xchg_masked(".h" sfx, prepend, append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..f71ddd2ca163 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZABHA		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..8d0f56dd2f53 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
-- 
2.39.2


