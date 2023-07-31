Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94007690A2
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGaIqq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGaIqT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 04:46:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7291BEC;
        Mon, 31 Jul 2023 01:45:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3177f520802so2774894f8f.1;
        Mon, 31 Jul 2023 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690793108; x=1691397908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlJcOZ0rPLmWhlyeSLW4YJJZ3jh5RfWXKohPhf857cA=;
        b=Y3kzUSwFc9LW4htnoLpe2K1AqS9YOGys/MCvvcEvqWqdLcheaqCk64k3/c1S6FN5fl
         xMR+3AyUncRkt+LhG1uRKSal1YrXieIIvhiJwSJqAniTMgdFz3sXlcc5yuLGvzJQXdUO
         HsEclnYkzsvmXVyGO18pkXlAfEJmS1dYIDRg6yXoLbDRpIrk7DZIH9dsgbMyt1ETEJIB
         1VpIYLCrp8hHdB06PSfWZV3GthxF+z6E77vr8dD+463XqePAO1Z5vEz+tqGa8e1s5DMn
         aRx3eBY9fp1yEz6VYjB2fLQG803r4N8bO2AK0j4ViXA0suToAseAG81E6XfxB1xSzF8m
         /qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793108; x=1691397908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlJcOZ0rPLmWhlyeSLW4YJJZ3jh5RfWXKohPhf857cA=;
        b=ggNzDJuCkK9td+CniPSF9Zu+dknlurcrZI+NNlqy/ZamM+TV+q7Kzxdz0giiCa3PFy
         IaXiZKKp9uJ7MQ+2JIkXSL9dpqzIplpOJtRqt1N8gFooX/s7j9j0leJwZot6Evj8KqA4
         cuCiyb53YJ6YptfutR9fojaYXW1QmCQMVtnRILOK2fLd7u03Vd8utfqYuz+iHupBzPFb
         U856qUa1P/Rt0uka8e4KztAoUpk34FJzFSvLzAsmHhtYmt478PTqYcOOkvhx3c+LqMvd
         C9WzsLvKEAOUYmMvyEfgCp0iAHlWMCe4pJKvAdH8ya/indv+EC1DEwhOWyd0Wp//6lbx
         e+wQ==
X-Gm-Message-State: ABy/qLZ8CxFJERNqhONWx01jk8HkqO0lAXRWReQGuaHMeIwzN382DI07
        L6lq4tA3hY0eDet2hnworp8=
X-Google-Smtp-Source: APBJJlF//uW16wr5DhKIiufGXX42sZb/Y9SPMirVZ8h/SfajlB/u2cIdGloIW+7LRiKCEW8RncsHSg==
X-Received: by 2002:adf:f9d1:0:b0:317:67d1:cdf2 with SMTP id w17-20020adff9d1000000b0031767d1cdf2mr7472435wrr.32.1690793107560;
        Mon, 31 Jul 2023 01:45:07 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b003177074f830sm12325080wrr.59.2023.07.31.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:45:07 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] locking/arch: Rewrite local_add_unless as static inline function
Date:   Mon, 31 Jul 2023 10:42:23 +0200
Message-ID: <20230731084458.28096-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rewrite local_add_unless as a static inline function with boolean
return value, similar to arch_atomic_add_unless arch fallbacks.

The function is currently unused.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jun Yi <yijun@loongson.cn>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/alpha/include/asm/local.h     | 33 +++++++++++++++---------------
 arch/loongarch/include/asm/local.h | 27 ++++++++++++++----------
 arch/mips/include/asm/local.h      | 27 ++++++++++++++----------
 arch/powerpc/include/asm/local.h   | 12 +++++------
 arch/x86/include/asm/local.h       | 33 +++++++++++++++---------------
 5 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index 0fcaad642cc3..88eb398947a5 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -65,28 +65,27 @@ static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	for (;;) {						\
-		if (unlikely(c == (u)))				\
-			break;					\
-		old = local_cmpxchg((l), c, c + (a));	\
-		if (likely(old == c))				\
-			break;					\
-		c = old;					\
-	}							\
-	c != (u);						\
-})
+static __inline__ bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 83e995b30e47..15bc3579f16c 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -70,22 +70,27 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
+static inline bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_dec_return(l) local_sub_return(1, (l))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 5daf6fe8e3e9..90435158a083 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -108,22 +108,27 @@ static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read(l);					\
-	while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
+static __inline__ bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 #define local_dec_return(l) local_sub_return(1, (l))
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 45492fb5bf22..ec6ced6d7ced 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -115,23 +115,23 @@ static __inline__ long local_xchg(local_t *l, long n)
 }
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-static __inline__ int local_add_unless(local_t *l, long a, long u)
+static __inline__ bool local_add_unless(local_t *l, long a, long u)
 {
 	unsigned long flags;
-	int ret = 0;
+	bool ret = false;
 
 	powerpc_local_irq_pmu_save(flags);
 	if (l->v != u) {
 		l->v += a;
-		ret = 1;
+		ret = true;
 	}
 	powerpc_local_irq_pmu_restore(flags);
 
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 56d4ef604b91..46ce92d4e556 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -135,28 +135,27 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 #define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
 
 /**
- * local_add_unless - add unless the number is a given value
+ * local_add_unless - add unless the number is already a given value
  * @l: pointer of type local_t
  * @a: the amount to add to l...
  * @u: ...unless l is equal to u.
  *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
+ * Atomically adds @a to @l, if @v was not already @u.
+ * Returns true if the addition was done.
  */
-#define local_add_unless(l, a, u)				\
-({								\
-	long c, old;						\
-	c = local_read((l));					\
-	for (;;) {						\
-		if (unlikely(c == (u)))				\
-			break;					\
-		old = local_cmpxchg((l), c, c + (a));		\
-		if (likely(old == c))				\
-			break;					\
-		c = old;					\
-	}							\
-	c != (u);						\
-})
+static __always_inline bool
+local_add_unless(local_t *l, long a, long u)
+{
+	long c = local_read(l);
+
+	do {
+		if (unlikely(c == u))
+			return false;
+	} while (!local_try_cmpxchg(l, &c, c + a));
+
+	return true;
+}
+
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
 /* On x86_32, these are no better than the atomic variants.
-- 
2.41.0

