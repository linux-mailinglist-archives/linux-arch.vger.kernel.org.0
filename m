Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574C167D345
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAZReU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjAZReS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 12:34:18 -0500
Received: from fx308.security-mail.net (smtpout30.security-mail.net [85.31.212.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607A3D92A
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 09:34:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx308.security-mail.net (Postfix) with ESMTP id 8AD30457484
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 18:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674754450;
        bh=mGAe5MCFM5+e6dUpTYJXSSXGH2Bt68QabcQ78M+qQYQ=;
        h=From:To:Cc:Subject:Date;
        b=vTfMSvxoYa1Cg/D2X1TNRbe440M/3WCUm4P6C1MzxDUYVymZcwlBggjXaIAeSyPqi
         r4/H1V2ON777iMEsZdkTYNzGvjRwWHWOPnJwHiVe3b9xytDDMrskvyxrVu9oLE4oZl
         6p7eJijjXWlg2XlzvpFNtjLiXpkLTh8VQ6NO4xCM=
Received: from fx308 (localhost [127.0.0.1])
        by fx308.security-mail.net (Postfix) with ESMTP id 774A6456566;
        Thu, 26 Jan 2023 18:34:10 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <32f4.63d2b992.2c2d.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx308.security-mail.net (Postfix) with ESMTPS id 039CF456FAE;
        Thu, 26 Jan 2023 18:34:10 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id D205A27E0374;
        Thu, 26 Jan 2023 18:34:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B77B627E0431;
        Thu, 26 Jan 2023 18:34:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B77B627E0431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674754449;
        bh=6N8vM8DHSvacPzNZe/Rjhi7+TG2mJlRN/Z5xbOptOPI=;
        h=From:To:Date:Message-Id;
        b=P7Pi8SAGDJAi/Ins6G/QTtc9JUNlUeN/hfMI37CSoCTqbl0zOgfxkQj17//v6OMiw
         CRN9/MGbOWM3is/WFOeCldnj2mG25dPTFECTM/yKVVGYKCGIDdNTxcBq6c11sLxHn1
         z3qJh8iYBXaS92XcnTEd3bT832jQEqm69meGRPPU=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Oy0211sE8ER1; Thu, 26 Jan 2023 18:34:09 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 9469727E0374;
        Thu, 26 Jan 2023 18:34:09 +0100 (CET)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in generic atomic ops
Date:   Thu, 26 Jan 2023 18:33:54 +0100
Message-Id: <20230126173354.13250-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reading and setting the atomic counter should be done through
arch_atomic_{read,set} macros, which respectively uses {READ,WRITE}_ONCE
macros.

This is to avoid the compiler from potentially replay the read access.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 include/asm-generic/atomic.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 04b8be9f1a77..711e408af581 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -12,6 +12,9 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
+#define arch_atomic_read(v)			READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
@@ -21,7 +24,7 @@ static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
-	c = v->counter;							\
+	c = arch_atomic_read(v);					\
 	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 }
@@ -31,7 +34,7 @@ static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	int c, old;							\
 									\
-	c = v->counter;							\
+	c = arch_atomic_read(v);					\
 	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
@@ -43,7 +46,7 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
-	c = v->counter;							\
+	c = arch_atomic_read(v);					\
 	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
@@ -58,9 +61,11 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
+	int c;								\
 									\
 	raw_local_irq_save(flags);					\
-	v->counter = v->counter c_op i;					\
+	c = arch_atomic_read(v);					\
+	arch_atomic_set(v, c c_op i);					\
 	raw_local_irq_restore(flags);					\
 }
 
@@ -68,27 +73,28 @@ static inline void generic_atomic_##op(int i, atomic_t *v)		\
 static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
-	int ret;							\
+	int c;								\
 									\
 	raw_local_irq_save(flags);					\
-	ret = (v->counter = v->counter c_op i);				\
+	c = arch_atomic_read(v);					\
+	arch_atomic_set(v, c c_op i);					\
 	raw_local_irq_restore(flags);					\
 									\
-	return ret;							\
+	return c c_op i;						\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
 static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
-	int ret;							\
+	int c;								\
 									\
 	raw_local_irq_save(flags);					\
-	ret = v->counter;						\
-	v->counter = v->counter c_op i;					\
+	c = arch_atomic_read(v);					\
+	arch_atomic_set(v, c c_op i);					\
 	raw_local_irq_restore(flags);					\
 									\
-	return ret;							\
+	return c;							\
 }
 
 #endif /* CONFIG_SMP */
@@ -127,9 +133,6 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_or				generic_atomic_or
 #define arch_atomic_xor				generic_atomic_xor
 
-#define arch_atomic_read(v)			READ_ONCE((v)->counter)
-#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
-
 #define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
 #define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
-- 
2.17.1

