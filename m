Return-Path: <linux-arch+bounces-5752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15188942808
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382F11C22835
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3351A4B42;
	Wed, 31 Jul 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lZWiSGFj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA81A71FB
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411203; cv=none; b=P9loGtCiInBaobrnj/gNMsQGBOC4u1PKB7x6oWN49tpk1oL4JCyjibdxq0lB+e+2NIdmP5IDk5DtjeaytH7lsGRHis8s/LhPe+wT1E4hJY3WcFH/NGooPEiRLOY5WPnQ3kwyKQZUhKoTjAZuUM82wmNn7iN2rL/Kzvg1QavRluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411203; c=relaxed/simple;
	bh=zIctHSF8s4ycH2M1Xuee5DajFIDyCPEPGL7Vxs9tOR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyBwcHSt62+LribrzhQwETKAZiq5EBOA69ctdsf0XTyMMVRK0GOo/Oz51WPeLrF2ioLayNCmDA82TKB7PRMAv42S8zjWORX6dbsr+MIoVsvsy5MLz5EzhTGGUzq6OB6ACjoDOFxIbym7NpeXjU0DM1toTCFWRG7yMulvOrDV75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lZWiSGFj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so31509615e9.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411199; x=1723015999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=lZWiSGFj8taJ5VBwaSLmzf+o100hjPaA3xXBJs97+DrkrR29O4M/gTlPby3B1xxQXU
         +Wmn1tl7NQlrhQ0VN5xy39RW3Yu6tpdT1Y6Tng8DQDhbRPHM5AivxGHYFIhtVbYemIPz
         IEQYnfIaFLyxMgbIsQ0mJUj+0ggvRfUKfpZK0b8J5PWzo9PCc4xmHiOEGo7lziHJJJVT
         HGO0IMzMankaSFMO7aTt/V95RdGdNe+J//zxg9wuyjnIHSJh5ssAKSyoTmgzOsUIKmuu
         NB37FzzxBSw7zYQDrygfChs5c6J7XR9h1hd0xlIiJzC8lTgqkWMzBi5bSVYvFMP/+ozo
         OF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411199; x=1723015999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=YCxmlDBT2IXivZkcwGQ1s3WTNEg6IFCcVoCVRap48gFIq+R0qHbpevt+rUyktL6wnw
         liWSJ5++aqS1Gw5vrZL36AC60aRb3QIznVmXORLTGJf6QVpCCIgql1IIe97uxRUyA2uS
         SL6f/S5rLNnFUWNGLMznCvfg0dGH4iHqmRvUDntChXwiyRzin+k9RZYNpulaMmi1GF4e
         QoAadGCjh3JfgT1hx2QbmJtIzZCLZmbdsLj2dJFtDbaYOqNCPIbFtKc6TmFtW8K5C/zi
         LjhrJxVzifZHRUHgYK3UIdWchsxcakH4qmqaybahqVrxe+Otz2c+bzlz9n0LDAU3NpVi
         vdoA==
X-Forwarded-Encrypted: i=1; AJvYcCX2IzEjwaJ7XXeUL/TpvfXxvkr1dmEUD15HXKRxuqnpW5nS4MW23xZjLe+ewA1ZOOkc/moqhUGwKuF/9ZhbuYMPEFiaVUJI/FGpQg==
X-Gm-Message-State: AOJu0YwYnA/D15urZKDNPOJCceELf9dv+TuUpshFWM6PMr7J6TaqzKIx
	K8DspaRiBqFb1OLTv2xeyOkQm9EMGO8o1WxhtIZ+cDolE4+OPwWeeXWS3WWAdXY=
X-Google-Smtp-Source: AGHT+IEcnY6AHoPV/M+h1TDSqxuXyVV5Hu7UR4S5fwQ9ffgAKn2jmSi+Y4GhJoM3ugRGgONDlr03/Q==
X-Received: by 2002:a5d:6d81:0:b0:368:4c38:a669 with SMTP id ffacd0b85a97d-36b5cee2e5fmr11880218f8f.10.1722411199233;
        Wed, 31 Jul 2024 00:33:19 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e51f0sm16335609f8f.46.2024.07.31.00.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:33:18 -0700 (PDT)
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
Cc: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v4 09/13] asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
Date: Wed, 31 Jul 2024 09:24:01 +0200
Message-Id: <20240731072405.197046-10-alexghiti@rivosinc.com>
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


