Return-Path: <linux-arch+bounces-5443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F34933703
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7C61C20DC3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66320125DE;
	Wed, 17 Jul 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oluJwtGz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC8171D8
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197632; cv=none; b=sfx25SYxHX3Twg2s2rHytdDCM/HqZDd7trhNMxng6bmhLv1VhxnlRLdloKwPndhcP+96L3Uhzmfug6SVkHXmhRIAsUNOalGKMAeVgJKUQdgSxCuGioB4U/QdgjU7vLMGI5+M3n9wrmPZ+YX0bj1BUWbTNOTKk7D5FoLJDj4gci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197632; c=relaxed/simple;
	bh=zIctHSF8s4ycH2M1Xuee5DajFIDyCPEPGL7Vxs9tOR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYCYFsO1U8H91UiUm9mRmLRYCMMzQTYoWl40E/lrz0POzLegz43EUtSdoJTsPfLnX+SMFenhnpAuSFbYOj3lyUPN6mqvxC99/RNSngLLT2ZgvUGhdqjd1A1s7aHPlYUQ9TYdCMN+Cyaw6UYZqv8sAB6/qYKR8EuDpYqaU3T/jO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oluJwtGz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368380828d6so63070f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197629; x=1721802429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=oluJwtGzW8UFQJOGpztldH/7EktLklT6yBARhB88b39iASMTLXUasaGTQZ8rJMVLEN
         OAqRSJIRhoGDeUMECAe6gMReMMMxHhN8l2DzHVVxWj6V6E+FYriT+oEueSPu6vRAGqVO
         KIK+L0XVbxTfVEHKG3ci3u9Xo7Oper/bbVIij2l3x8HPYzkUzbmEjLZXxy59aHqrvlom
         r6WqnF9+JYzisGwX5ekGYLRfl1kaJvx7sLOGszf8WXGQtiOiuIJTS2VnpPcQDdA6cUQC
         GuPAraiuz16MQiG68cqh8J40ag3X69ekVeHJ09c7HmcjuRPvquhcTzHo4PIWmUpi58zR
         6guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197629; x=1721802429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=VopFICih6eX7UQD5BK94SVBckGtGj9n5qTU2KQFIK8cDhkfaNLc2ekH2B1VlyxysLj
         nciW2BrdauWXCsZamQyMMOYITZ84CUh1FVOANMjMJZ/ZxdtEM2IQzoNgoXBxw/SJWmLl
         bDl7d/Qa8TLhnuXumw5xIDlu51reeN11PLPuK0rKhYQJIynTGV6xGzYBcS0Jev3z9wou
         X6UGLkiEiAge6I5bXi3z4MlcPt8YnudaO5ylDhM55cOFWrCwR6zWt9/7Yd8e/xD2eZFr
         szA5B2rAjlj72AZdMnabLNgbylV4F/rs72v+xJ8Kqdu9un7hvJxQf2MiL++vZxDw4ZFY
         10gg==
X-Forwarded-Encrypted: i=1; AJvYcCXQQqDy0Nw4qAkrhjIKOI2p7fORW/75/N1eHaJcPLjbRGMq9PRrrNGYjSsF7HclBsw/qFWkSGp2mrY5P21DD1KbokrFul86x4COqQ==
X-Gm-Message-State: AOJu0Ywz2ffneFVl7VuUurlgkuIzathZE6eCQZjoQ37V2ZCFH2UP4gtn
	2oke9rAslMpkOf4E/GhzYYlatChTP8wO/+Ui+jAQrbcZpEfaQApNOdM3WhFJRJI=
X-Google-Smtp-Source: AGHT+IEcx5vbXw9AngQayUYduH0av6OpvecXDO/fzCki4vNwqd2UbQND86b7G8WFV0E/r2hUOY9S4Q==
X-Received: by 2002:adf:f6c8:0:b0:367:bb20:b3e1 with SMTP id ffacd0b85a97d-3683171f8bemr430134f8f.51.1721197628922;
        Tue, 16 Jul 2024 23:27:08 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e8e2ecsm160904995e9.21.2024.07.16.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:27:08 -0700 (PDT)
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
Cc: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v3 07/11] asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
Date: Wed, 17 Jul 2024 08:19:53 +0200
Message-Id: <20240717061957.140712-8-alexghiti@rivosinc.com>
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

From: Guo Ren <guoren@linux.alibaba.com>

The arch_spinlock_t of qspinlock has contained the atomic_t val, which
satisfies the ticket-lock requirement. Thus, unify the arch_spinlock_t
into qspinlock_types.h. This is the preparation for the next combo
spinlock.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com/
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 include/asm-generic/spinlock.h       | 14 +++++++-------
 include/asm-generic/spinlock_types.h | 12 ++----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 90803a826ba0..4773334ee638 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -32,7 +32,7 @@
 
 static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 {
-	u32 val = atomic_fetch_add(1<<16, lock);
+	u32 val = atomic_fetch_add(1<<16, &lock->val);
 	u16 ticket = val >> 16;
 
 	if (ticket == (u16)val)
@@ -46,31 +46,31 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 	 * have no outstanding writes due to the atomic_fetch_add() the extra
 	 * orderings are free.
 	 */
-	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
 	smp_mb();
 }
 
 static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
 {
-	u32 old = atomic_read(lock);
+	u32 old = atomic_read(&lock->val);
 
 	if ((old >> 16) != (old & 0xffff))
 		return false;
 
-	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
 }
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(lock);
+	u32 val = atomic_read(&lock->val);
 
 	smp_store_release(ptr, (u16)val + 1);
 }
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	u32 val = lock.counter;
+	u32 val = lock.val.counter;
 
 	return ((val >> 16) == (val & 0xffff));
 }
@@ -84,7 +84,7 @@ static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(lock);
+	u32 val = atomic_read(&lock->val);
 
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
index 8962bb730945..f534aa5de394 100644
--- a/include/asm-generic/spinlock_types.h
+++ b/include/asm-generic/spinlock_types.h
@@ -3,15 +3,7 @@
 #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
 #define __ASM_GENERIC_SPINLOCK_TYPES_H
 
-#include <linux/types.h>
-typedef atomic_t arch_spinlock_t;
-
-/*
- * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
- * include.
- */
-#include <asm/qrwlock_types.h>
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
-- 
2.39.2


