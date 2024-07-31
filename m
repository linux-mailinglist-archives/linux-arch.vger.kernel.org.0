Return-Path: <linux-arch+bounces-5751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EC99427FD
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014E2B21868
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF861A4B5F;
	Wed, 31 Jul 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JD3PgyJE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485F1A71E3
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411141; cv=none; b=BhaIj904rP96XPkbZGcrgZEp7N35xz5whGqOiJbgkbME1Yi+9konmC5UMGSJVAFG2hcAzcIncAWay9SbeegP1Z0vRVkFLqJ4wEgU9LlgXKYkIYmlVNf+G5ZXPIRI6Yo1Ik5fYp4zbp72EAo2hZNcfaqoMZCHWRPKZrQnbt1sV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411141; c=relaxed/simple;
	bh=ElHuB+Us1CB5OhEQMDfe5MJ5yu/cgxIM0wpfgWnYoF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZ5UHWZJKmH2fVTCnxTsAeaXMNYBwzJXs5zjxKzKxnWFbYzwk85jy+o2jn0cHRT8bZk7HIIXIBJ8739jXasruv9MQzWBPD0L7rPN49IoosOIrJFN1oGW9V6lUsKtkM5EN2nFZJB633011q7vOJcdkW/xmHGYfV9QDEbXHoDntGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JD3PgyJE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso3021804f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411138; x=1723015938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xze2cs107FZ3zEBdldNBuzUZPwt1bYMtkFI7VhzQeZI=;
        b=JD3PgyJEOW0qa5tSeQ3H9Nm0yuiIoXFnzPyCOZNqJHsjcfX0AWIi1Ew6RA5bzIP8yI
         8xIbrnzTW/PnvcDt32G2XHuujKyw4VEK3hM/N0UnTa0OHXSLY65fT7XKxG61jihjyzHg
         7n4PrLkm5ThmUY/gJKqEnFpdNlon6NHOmzymWPC+1x/ttSZz9fraM2SKTelY/YB+DB5V
         hgvY1Oldl7SDu4AWIMcoGFahvR8kIOAZJWMfXuD5AEVrLGOa9GjihKpnl8FFE5JODwoX
         41Q0rvCIPpBOgoVVyayvg5L96mdwYpiAAEgvfWy/i/w+29+vBXIuLzJai1PUTGvEiDxC
         nrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411138; x=1723015938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xze2cs107FZ3zEBdldNBuzUZPwt1bYMtkFI7VhzQeZI=;
        b=Bi8ziZx3vnL8SNrr7+40+NQJq2sstiXQuHAmXkvwjKalE4yRHypDvJEQ/FxzJyu+78
         6Et1TQFmQ1VqNPMqa+l124jb7Nyz1i1YGE3NDrC8c60OV0/0LpTw7QRG0i4h+VxYeXYu
         zx+N0Dy3V3Jd6tcGzCzi7UHtDu9T5IKnsLcsir7sQ8fVao7YlrrE7mlzgdOYbZ+HWceF
         4ABXFa2bmGEMlvWo41ftP+7H6ySoHqHUxA+ZfPBBoAFoe7rTt3JJmgnz9888hrsVDrsH
         nKKKEW24nWj0oVm5iaI9cIZOH7Z9EDJFHUJzETld3row4uYZoBx7/MV+6ka94P17myBt
         WCyw==
X-Forwarded-Encrypted: i=1; AJvYcCWuJaCSopegF38ZiDXy1n5aXV3lVsf2SUxrb8QbrfbgGOOrNxksO0uxvgqMzMQvuE/y1lQsfsj0+/pUMoqgsQYr0jPTZclBVgbQ8A==
X-Gm-Message-State: AOJu0YwnDf5gNlBigr5XFm5um4xg+unAA7VJvIa6ELLyq0aUsrqb/4/v
	SXGw+SPG53e3M0gyWvlfyGWzGAMFH7D8s/C0D1GhpFhcE3+s2JO1Hg6CF2WX0to=
X-Google-Smtp-Source: AGHT+IHQ02v4jgJ0i8k8ZC9oEkha1vnkq1LaDLws9riLxBs06x93VaBTTty+hQP6mbP1ktT3LB3TnA==
X-Received: by 2002:adf:e707:0:b0:367:9088:fecc with SMTP id ffacd0b85a97d-36b5d0b04a6mr9601634f8f.7.1722411137984;
        Wed, 31 Jul 2024 00:32:17 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c02casm16371948f8f.15.2024.07.31.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:32:17 -0700 (PDT)
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
Subject: [PATCH v4 08/13] riscv: Implement xchg8/16() using Zabha
Date: Wed, 31 Jul 2024 09:24:00 +0200
Message-Id: <20240731072405.197046-9-alexghiti@rivosinc.com>
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

This adds runtime support for Zabha in xchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 65 ++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ce9613516bbb..7484f063809e 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -14,29 +14,41 @@
 #include <asm/insn-def.h>
 #include <asm/cpufeature-macros.h>
 
-#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
-({									\
-	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
-	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
-			<< __s;						\
-	ulong __newx = (ulong)(n) << __s;				\
-	ulong __retx;							\
-	ulong __rc;							\
-									\
-	__asm__ __volatile__ (						\
-	       prepend							\
-	       "0:	lr.w %0, %2\n"					\
-	       "	and  %1, %0, %z4\n"				\
-	       "	or   %1, %1, %z3\n"				\
-	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
-	       "	bnez %1, 0b\n"					\
-	       append							\
-	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-	       : "rJ" (__newx), "rJ" (~__mask)				\
-	       : "memory");						\
-									\
-	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,		\
+			   swap_append, r, p, n)				\
+({										\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {		\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"	amoswap" swap_sfx " %0, %z2, %1\n"		\
+			swap_append						\
+			: "=&r" (r), "+A" (*(p))				\
+			: "rJ" (n)						\
+			: "memory");						\
+	} else {								\
+		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+				<< __s;						\
+		ulong __newx = (ulong)(n) << __s;				\
+		ulong __retx;							\
+		ulong __rc;							\
+										\
+		__asm__ __volatile__ (						\
+		       prepend							\
+		       "0:	lr.w %0, %2\n"					\
+		       "	and  %1, %0, %z4\n"				\
+		       "	or   %1, %1, %z3\n"				\
+		       "	sc.w" sc_sfx " %1, %1, %2\n"			\
+		       "	bnez %1, 0b\n"					\
+		       sc_append						\
+		       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+		       : "rJ" (__newx), "rJ" (~__mask)				\
+		       : "memory");						\
+										\
+		r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	}									\
 })
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
@@ -59,8 +71,13 @@
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


