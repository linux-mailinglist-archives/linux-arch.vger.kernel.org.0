Return-Path: <linux-arch+bounces-5440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4569A9336EB
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0302814A6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563112E48;
	Wed, 17 Jul 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CfRoQnke"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C16125DB
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197448; cv=none; b=KvfJWdLy9bcbMVbsWtH6CugM0TgTdSb+HRxD6TMvBAuKjVxG8WqWXKS0zbpIqgt68SDH3nQXdq4vuLK6QpwO7P1XfyUYnlPYCxebwnFjWC45RCp5uKhOijwrxRdM2PdzxaMRQDBo10E+5S1SkkupoyEbh0uPj60kJN6AICCsh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197448; c=relaxed/simple;
	bh=W3ZbUrXKMQk615ONwljbbIROXFCdQYzyCE9meMsyGpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZVqkQsbCtuCvO4YCKzJdLKkQ1VM+oeyLFLvxd5eJOrhBzb/CzepTazYrQb+EXQaQJa3xfJt6/H/vX++UlB47ejpcAw5uNV2sPP7OTyKS45ORMOpq34hRYCabzyj3Hqn8tUGrS0/vkiZnMx6p3FIHhyJxt+pw/Ud0Xdo0nR2ieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CfRoQnke; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so43715605e9.3
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197445; x=1721802245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds1f3nvde/2kobU8ZNZg62T2Qi5mJIAm9dc1xPbfhas=;
        b=CfRoQnkeRpoGzFiYfi6InQC0w6ja+pTl8/iannG30wLicWgyIvZwjwgySEkmIg/18y
         NuRpsbsM5X2vjutJtdsDadV5iZol124BfslIWUUhsBVVMBUVJDl+GuHHlxviIqCRCaIn
         nbl/xDU7oA2WfW8Nf6ugfACV76jmV3FUcauXrFTy5pj+ZJesHqtVp4BBHvv0BB5MJVYs
         C9ToNTUH1DimQjmb6g3Rb+lbm5kG0yje99R/z1SfTKEGG7U1KtBe5fps3pmmu7A8wakk
         0RTw0mnjjZSyyw/QgkPjP8MZE64gNFGE+jDr+EF5ZfF5yRqqtYCXk3M1k521Z+jFrRgA
         e2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197445; x=1721802245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds1f3nvde/2kobU8ZNZg62T2Qi5mJIAm9dc1xPbfhas=;
        b=Mxufp4m/GEcscD41KMSjlOs7NwHKxNfgpdU/qplWsSXJu8OSChwdf6tOufW3cK0EAx
         R+HAIp+by6C8NdXdfBTjoEvm2AptYJfJI41ypqhAqlpbHmue/cewKu06guGR/a7KvKDe
         HVvMD1YXdZe5qIFLSFBCWdvJl64Rmi5B4M0ZoZoIXUDi4EHHSbTSw9h3wkKqB1v5OP4a
         IjifIBRB2eszFgjcQ3qDwFODMxsAre91SkS38PQaAJKZE81uSr73w1Xe3oLnLStFDnxZ
         uTTg8KJ+BM0BYkXelZ7Zxl2Tx3xlAfRbIJHw3JSG2d2k0+cmzeXlOW3BaQEvj7HlaXbC
         XUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG+Q5VCivhJrivdPIfKCTRT4dbwMx9pgRmHk28pUIjzz3Lsr0ebaCmdNrl5j1Vlgv63M5Ao0aJZTYKadpWvISWDbrVS9rlPTHCtw==
X-Gm-Message-State: AOJu0YzIyrbeHClVPslrBxd/Jftb4a/R5wXOy4s6gVtf4LDxuXw9bU+Z
	XKANZojuH3JS4NfxTbZ9X7jzUXbcRetwtv+hX2L6c7rnNDRpGlOLTPy02+scZco=
X-Google-Smtp-Source: AGHT+IEIXpdS+STkowwy/Wm5vUbJoSbRCAM24AYCj9d6c8yOJneivGu6HLD2duOFWquiyMpaznkmeg==
X-Received: by 2002:a5d:6b8d:0:b0:368:75:26e5 with SMTP id ffacd0b85a97d-368316003e7mr683121f8f.1.1721197444910;
        Tue, 16 Jul 2024 23:24:04 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafba03sm10826606f8f.76.2024.07.16.23.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:24:04 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <andrea@rivosinc.com>
Subject: [PATCH v3 04/11] riscv: Improve zacas fully-ordered cmpxchg()
Date: Wed, 17 Jul 2024 08:19:50 +0200
Message-Id: <20240717061957.140712-5-alexghiti@rivosinc.com>
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

The current fully-ordered cmpxchgXX() implementation results in:

  amocas.X.rl     a5,a4,(s1)
  fence           rw,rw

This provides enough sync but we can actually use the following better
mapping instead:

  amocas.X.aqrl   a5,a4,(s1)

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 71 ++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index c86722a101d0..97b24da38897 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -105,7 +105,10 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,				\
+			      sc_prepend, sc_append,			\
+			      cas_prepend, cas_append,			\
+			      r, p, o, n)				\
 ({									\
 	__label__ no_zabha_zacas, end;					\
 									\
@@ -119,9 +122,9 @@
 			 : : : : no_zabha_zacas);			\
 									\
 		__asm__ __volatile__ (					\
-			prepend						\
+			cas_prepend					\
 			"	amocas" cas_sfx " %0, %z2, %1\n"	\
-			append						\
+			cas_append					\
 			: "+&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -139,7 +142,7 @@ no_zabha_zacas:;							\
 	ulong __rc;							\
 									\
 	__asm__ __volatile__ (						\
-		prepend							\
+		sc_prepend						\
 		"0:	lr.w %0, %2\n"					\
 		"	and  %1, %0, %z5\n"				\
 		"	bne  %1, %z3, 1f\n"				\
@@ -147,7 +150,7 @@ no_zabha_zacas:;							\
 		"	or   %1, %1, %z4\n"				\
 		"	sc.w" sc_sfx " %1, %1, %2\n"			\
 		"	bnez %1, 0b\n"					\
-		append							\
+		sc_append						\
 		"1:\n"							\
 		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 		: "rJ" ((long)__oldx), "rJ" (__newx),			\
@@ -159,7 +162,10 @@ no_zabha_zacas:;							\
 end:;									\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
+#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
+		       sc_prepend, sc_append,				\
+		       cas_prepend, cas_append,				\
+		       r, p, co, o, n)					\
 ({									\
 	__label__ no_zacas, end;					\
 	register unsigned int __rc;					\
@@ -170,9 +176,9 @@ end:;									\
 			 : : : : no_zacas);				\
 									\
 		__asm__ __volatile__ (					\
-			prepend						\
-			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
-			append						\
+			cas_prepend					\
+			"	amocas" cas_sfx " %0, %z2, %1\n"	\
+			cas_append					\
 			: "+&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -181,12 +187,12 @@ end:;									\
 									\
 no_zacas:								\
 	__asm__ __volatile__ (						\
-		prepend							\
+		sc_prepend						\
 		"0:	lr" lr_sfx " %0, %2\n"				\
 		"	bne  %0, %z3, 1f\n"				\
-		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
+		"	sc" sc_sfx " %1, %z4, %2\n"			\
 		"	bnez %1, 0b\n"					\
-		append							\
+		sc_append						\
 		"1:\n"							\
 		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
 		: "rJ" (co o), "rJ" (n)					\
@@ -195,7 +201,9 @@ no_zacas:								\
 end:;									\
 })
 
-#define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
+#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
+		      sc_prepend, sc_append,				\
+		      cas_prepend, cas_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __old = (old);				\
@@ -204,22 +212,28 @@ end:;									\
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
-					prepend, append,		\
-					__ret, __ptr, __old, __new);    \
+		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
+				      sc_prepend, sc_append,		\
+				      cas_prepend, cas_append,		\
+				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
-					prepend, append,		\
-					__ret, __ptr, __old, __new);	\
+		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
+				      sc_prepend, sc_append,		\
+				      cas_prepend, cas_append,		\
+				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
-		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
-				__ret, __ptr, (long), __old, __new);	\
+		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
+			       sc_prepend, sc_append,			\
+			       cas_prepend, cas_append,			\
+			       __ret, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__arch_cmpxchg(".d", ".d" sc_sfx, prepend, append,	\
-				__ret, __ptr, /**/, __old, __new);	\
+		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
+			       sc_prepend, sc_append,			\
+			       cas_prepend, cas_append,			\
+			       __ret, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -228,16 +242,19 @@ end:;									\
 })
 
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", "", "")
+	_arch_cmpxchg((ptr), (o), (n), "", "", "", "", "", "")
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
+	_arch_cmpxchg((ptr), (o), (n), "", "",				\
+		      "", RISCV_ACQUIRE_BARRIER, "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_cmpxchg_release(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
+	_arch_cmpxchg((ptr), (o), (n), "", "",				\
+		      RISCV_RELEASE_BARRIER, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_cmpxchg(ptr, o, n)						\
-	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
+	_arch_cmpxchg((ptr), (o), (n), ".rl", ".aqrl",			\
+		      "", RISCV_FULL_BARRIER, "", "")
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 	arch_cmpxchg_relaxed((ptr), (o), (n))
-- 
2.39.2


