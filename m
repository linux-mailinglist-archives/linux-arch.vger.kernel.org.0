Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E772AEF2A
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKKLHi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 06:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKKLHh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2020 06:07:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32385C0613D1;
        Wed, 11 Nov 2020 03:07:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e7so1379656pfn.12;
        Wed, 11 Nov 2020 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaRNVN7IQp0J42DlqO/RdFB7HR0Qo59Y85JYdPkkOEM=;
        b=fWEIRK3iIhUBZSJpMSOtGh80z4bLXIAmmbUdeEGioPIGs7naWD+ncx2Zcz6xhUt2wq
         1TN6XwTMLl82pYCdwh3i2xLnm5s2YF2B69fp2kt8dUeARS9Vcx8/v8HdzvXFj6sVkbjc
         d04FYVE6FJrp63gOQ12+EpQb0OIyqStFLrB+FCAEPTye3Yk1qfpg3sQ+PUhIgzkwQFEN
         DldxPGBUQYE4JWUmq7gOOpc4vlXTYld7zzY4l06gugPpAf1l4+Lpn9YsTxHgcJ+kkmRg
         uRO1AfZ2R13T37eZYhjcm0FlkkrgVCzfqy5QyT2Wi7eD7qy1oCabrOD5VRdddzIieiiL
         Oy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaRNVN7IQp0J42DlqO/RdFB7HR0Qo59Y85JYdPkkOEM=;
        b=Jdrw6mLTXY7lDwgMbHhywzhAuXTynUQnbfMaNCqODO7VxcG3eiml2/mGt8wGC+zY3y
         HCJ4zsKkTMyNPAeO0zqx6+HJWH6EAAL2aHQhkQlTDkhLPtn2O0IlR0jaMFJIcrb0zZYO
         sITo/4YPIp9IZ83JHKp7fSXRwhjT4oQydyVGjVk/bJXsaTK8Erv0oZNUyW+FJKOBSRPd
         suqMOZjmDCk6RlBS2pYbNqao6l//bcRQwoIrANUNDifGXYptg0yJMQJA4/kAXVnGY46+
         QjE4q4ktaMEv8akpjmrb7994ek1Vtmw3D7v2sltTVtx9aXd+NFvsRAVWp3PSp0zweJqq
         Kwzw==
X-Gm-Message-State: AOAM531pea9eHhA183Fy8J9hQhlDqJ7RRMULZ9p79VpK6m0IbVJuT/2g
        M0nIyc64WF+GEEXvmFlHLgA=
X-Google-Smtp-Source: ABdhPJwP8uQQpmy1oaw81lNCVlsjzZpMF4ckneC9iNjwb10hHnlFsPcz7ZW8ntP8YCetS0IAZDYTuA==
X-Received: by 2002:aa7:838b:0:b029:18c:42ad:7721 with SMTP id u11-20020aa7838b0000b029018c42ad7721mr9010716pfm.15.1605092856784;
        Wed, 11 Nov 2020 03:07:36 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id 9sm2154943pfp.102.2020.11.11.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:07:36 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
Date:   Wed, 11 Nov 2020 21:07:21 +1000
Message-Id: <20201111110723.3148665-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201111110723.3148665-1-npiggin@gmail.com>
References: <20201111110723.3148665-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
both before and after powerpc is converted to use ARCH_ATOMIC.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/atomic64.h | 70 +++++++++++++++++++++++++++-------
 lib/atomic64.c                 | 36 ++++++++---------
 2 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..2b1ecb591bb9 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -15,19 +15,17 @@ typedef struct {
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-extern s64 atomic64_read(const atomic64_t *v);
-extern void atomic64_set(atomic64_t *v, s64 i);
-
-#define atomic64_set_release(v, i)	atomic64_set((v), (i))
+extern s64 __atomic64_read(const atomic64_t *v);
+extern void __atomic64_set(atomic64_t *v, s64 i);
 
 #define ATOMIC64_OP(op)							\
-extern void	 atomic64_##op(s64 a, atomic64_t *v);
+extern void	 __atomic64_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OP_RETURN(op)						\
-extern s64 atomic64_##op##_return(s64 a, atomic64_t *v);
+extern s64 __atomic64_##op##_return(s64 a, atomic64_t *v);
 
 #define ATOMIC64_FETCH_OP(op)						\
-extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
+extern s64 __atomic64_fetch_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
@@ -46,11 +44,57 @@ ATOMIC64_OPS(xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-extern s64 atomic64_dec_if_positive(atomic64_t *v);
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
-extern s64 atomic64_xchg(atomic64_t *v, s64 new);
-extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+extern s64 __atomic64_dec_if_positive(atomic64_t *v);
+extern s64 __atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
+extern s64 __atomic64_xchg(atomic64_t *v, s64 new);
+extern s64 __atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
+
+#ifdef ARCH_ATOMIC
+#define arch_atomic64_read __atomic64_read
+#define arch_atomic64_set __atomic64_set
+#define arch_atomic64_add __atomic64_add
+#define arch_atomic64_add_return __atomic64_add_return
+#define arch_atomic64_fetch_add __atomic64_fetch_add
+#define arch_atomic64_sub __atomic64_sub
+#define arch_atomic64_sub_return __atomic64_sub_return
+#define arch_atomic64_fetch_sub __atomic64_fetch_sub
+#define arch_atomic64_and __atomic64_and
+#define arch_atomic64_and_return __atomic64_and_return
+#define arch_atomic64_fetch_and __atomic64_fetch_and
+#define arch_atomic64_or __atomic64_or
+#define arch_atomic64_or_return __atomic64_or_return
+#define arch_atomic64_fetch_or __atomic64_fetch_or
+#define arch_atomic64_xor __atomic64_xor
+#define arch_atomic64_xor_return __atomic64_xor_return
+#define arch_atomic64_fetch_xor __atomic64_fetch_xor
+#define arch_atomic64_xchg __atomic64_xchg
+#define arch_atomic64_cmpxchg __atomic64_cmpxchg
+#define arch_atomic64_set_release(v, i)	__atomic64_set((v), (i))
+#define arch_atomic64_dec_if_positive __atomic64_dec_if_positive
+#define arch_atomic64_fetch_add_unless __atomic64_fetch_add_unless
+#else
+#define atomic64_read __atomic64_read
+#define atomic64_set __atomic64_set
+#define atomic64_add __atomic64_add
+#define atomic64_add_return __atomic64_add_return
+#define atomic64_fetch_add __atomic64_fetch_add
+#define atomic64_sub __atomic64_sub
+#define atomic64_sub_return __atomic64_sub_return
+#define atomic64_fetch_sub __atomic64_fetch_sub
+#define atomic64_and __atomic64_and
+#define atomic64_and_return __atomic64_and_return
+#define atomic64_fetch_and __atomic64_fetch_and
+#define atomic64_or __atomic64_or
+#define atomic64_or_return __atomic64_or_return
+#define atomic64_fetch_or __atomic64_fetch_or
+#define atomic64_xor __atomic64_xor
+#define atomic64_xor_return __atomic64_xor_return
+#define atomic64_fetch_xor __atomic64_fetch_xor
+#define atomic64_xchg __atomic64_xchg
+#define atomic64_cmpxchg __atomic64_cmpxchg
+#define atomic64_set_release(v, i)	__atomic64_set((v), (i))
+#define atomic64_dec_if_positive __atomic64_dec_if_positive
+#define atomic64_fetch_add_unless __atomic64_fetch_add_unless
+#endif
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/lib/atomic64.c b/lib/atomic64.c
index e98c85a99787..05aba5e3268f 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -42,7 +42,7 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
 	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
 }
 
-s64 atomic64_read(const atomic64_t *v)
+s64 __atomic64_read(const atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -53,9 +53,9 @@ s64 atomic64_read(const atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_read);
+EXPORT_SYMBOL(__atomic64_read);
 
-void atomic64_set(atomic64_t *v, s64 i)
+void __atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -64,10 +64,10 @@ void atomic64_set(atomic64_t *v, s64 i)
 	v->counter = i;
 	raw_spin_unlock_irqrestore(lock, flags);
 }
-EXPORT_SYMBOL(atomic64_set);
+EXPORT_SYMBOL(__atomic64_set);
 
 #define ATOMIC64_OP(op, c_op)						\
-void atomic64_##op(s64 a, atomic64_t *v)				\
+void __atomic64_##op(s64 a, atomic64_t *v)				\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -76,10 +76,10 @@ void atomic64_##op(s64 a, atomic64_t *v)				\
 	v->counter c_op a;						\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 }									\
-EXPORT_SYMBOL(atomic64_##op);
+EXPORT_SYMBOL(__atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
+s64 __atomic64_##op##_return(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -90,10 +90,10 @@ s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_##op##_return);
+EXPORT_SYMBOL(__atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
+s64 __atomic64_fetch_##op(s64 a, atomic64_t *v)				\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -105,7 +105,7 @@ s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_fetch_##op);
+EXPORT_SYMBOL(__atomic64_fetch_##op);
 
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
@@ -130,7 +130,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-s64 atomic64_dec_if_positive(atomic64_t *v)
+s64 __atomic64_dec_if_positive(atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -143,9 +143,9 @@ s64 atomic64_dec_if_positive(atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_dec_if_positive);
+EXPORT_SYMBOL(__atomic64_dec_if_positive);
 
-s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+s64 __atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -158,9 +158,9 @@ s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_cmpxchg);
+EXPORT_SYMBOL(__atomic64_cmpxchg);
 
-s64 atomic64_xchg(atomic64_t *v, s64 new)
+s64 __atomic64_xchg(atomic64_t *v, s64 new)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -172,9 +172,9 @@ s64 atomic64_xchg(atomic64_t *v, s64 new)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_xchg);
+EXPORT_SYMBOL(__atomic64_xchg);
 
-s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+s64 __atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -188,4 +188,4 @@ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return val;
 }
-EXPORT_SYMBOL(atomic64_fetch_add_unless);
+EXPORT_SYMBOL(__atomic64_fetch_add_unless);
-- 
2.23.0

