Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3797F9549C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 04:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHTCuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 22:50:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32919 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfHTCuM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 22:50:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so1942043plb.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ljr2InsBtzDAS9Drpe0kzrEUQvzHekKKA+vOfzzLGA=;
        b=PsibIzx5rTlBR2htkZaC14SZ+TyjHDX4IFClJIdwueYX3BOfqve7g8GUtouBZ1PEC9
         XgmL2bkcGiVdms2gBulf9tWzN/Cn1147xOsrary4sNqlrYhrtpZgf65btsrxT4QD5z7j
         R5/dYAaMfF91u5K1Z6pjvdC1CuO2GQgWMSJJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ljr2InsBtzDAS9Drpe0kzrEUQvzHekKKA+vOfzzLGA=;
        b=Zou/o80LiVrPSUEePrZ6t42y++u1MBVC2ZO+ve7VYqOc60zuJi8Ba4HlPN9xt49+7M
         LXucHI0GC+JNVvKVd3yy7Ff4ta3W/xDtEWMIu6E4FYR4tqwOiLmp/F2R2sXmYbM95Xqc
         K3NdwH/MC3pVXRo6FkUtjt850IEfKvXa1mmd6eFu6TgB5M0H1rLnOer+Y416yWdfixbf
         Z1PYOOBaDaFXAzSk8XgFYvNw0oCXbUDj8KNptjkM1LGzmRuVBuYuSQnf1u4USq38rI6w
         EQDKpIHZ30lVJiPnq7ZElscDrOrn7AUMIZS69/inqga1u4kinZnKra5fS856zu1gFIPK
         UaLg==
X-Gm-Message-State: APjAAAWZMdDcYU87L6OFBZ6VztQa2kXo3e/JkoPeJiaETvjP1af3KvWu
        W5g1GV5G4UqkuRZoEBRnP4R/vw==
X-Google-Smtp-Source: APXvYqystm3jdzymp+1rMFPxd1ITjgesZk8LVWVIqs910yEXCDW7YMtttcl8wr0UuWWDizjPOMIKeQ==
X-Received: by 2002:a17:902:e2:: with SMTP id a89mr26250902pla.210.1566269411763;
        Mon, 19 Aug 2019 19:50:11 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id v15sm18777348pfn.69.2019.08.19.19.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:50:11 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/2] powerpc: support KASAN instrumentation of bitops
Date:   Tue, 20 Aug 2019 12:49:41 +1000
Message-Id: <20190820024941.12640-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820024941.12640-1-dja@axtens.net>
References: <20190820024941.12640-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The powerpc-specific bitops are not being picked up by the KASAN
test suite.

Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
headers. They require that arch-specific versions of bitop functions
are renamed to arch_*. Do this renaming.

For clear_bit_unlock_is_negative_byte, the current implementation
uses the PG_waiters constant. This works because it's a preprocessor
macro - so it's only actually evaluated in contexts where PG_waiters
is defined. With instrumentation however, it becomes a static inline
function, and all of a sudden we need the actual value of PG_waiters.
Because of the order of header includes, it's not available and we
fail to compile. Instead, manually specify that we care about bit 7.
This is still correct: bit 7 is the bit that would mark a negative
byte.

While we're at it, replace __inline__ with inline across the file.

Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>

--
v2: Address Christophe review
---
 arch/powerpc/include/asm/bitops.h | 51 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 603aed229af7..28dcf8222943 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -64,7 +64,7 @@
 
 /* Macro for generating the ***_bits() functions */
 #define DEFINE_BITOP(fn, op, prefix)		\
-static __inline__ void fn(unsigned long mask,	\
+static inline void fn(unsigned long mask,	\
 		volatile unsigned long *_p)	\
 {						\
 	unsigned long old;			\
@@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
 DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
 DEFINE_BITOP(change_bits, xor, "")
 
-static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+static inline void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
 {
 	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+static inline void arch_clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+static inline void arch_change_bit(int nr, volatile unsigned long *addr)
 {
 	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
@@ -109,7 +109,7 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
  * operands. */
 #define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
-static __inline__ unsigned long fn(			\
+static inline unsigned long fn(			\
 		unsigned long mask,			\
 		volatile unsigned long *_p)		\
 {							\
@@ -138,34 +138,34 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
-static __inline__ int test_and_set_bit(unsigned long nr,
-				       volatile unsigned long *addr)
+static inline int arch_test_and_set_bit(unsigned long nr,
+					volatile unsigned long *addr)
 {
 	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_set_bit_lock(unsigned long nr,
-				       volatile unsigned long *addr)
+static inline int arch_test_and_set_bit_lock(unsigned long nr,
+					     volatile unsigned long *addr)
 {
 	return test_and_set_bits_lock(BIT_MASK(nr),
 				addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_clear_bit(unsigned long nr,
-					 volatile unsigned long *addr)
+static inline int arch_test_and_clear_bit(unsigned long nr,
+					  volatile unsigned long *addr)
 {
 	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_change_bit(unsigned long nr,
-					  volatile unsigned long *addr)
+static inline int arch_test_and_change_bit(unsigned long nr,
+					   volatile unsigned long *addr)
 {
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
 #ifdef CONFIG_PPC64
-static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
-						volatile unsigned long *addr)
+static inline unsigned long
+clear_bit_unlock_return_word(int nr, volatile unsigned long *addr)
 {
 	unsigned long old, t;
 	unsigned long *p = (unsigned long *)addr + BIT_WORD(nr);
@@ -185,15 +185,18 @@ static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
 	return old;
 }
 
-/* This is a special function for mm/filemap.c */
-#define clear_bit_unlock_is_negative_byte(nr, addr)			\
-	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
+/*
+ * This is a special function for mm/filemap.c
+ * Bit 7 corresponds to PG_waiters.
+ */
+#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
+	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
 
 #endif /* CONFIG_PPC64 */
 
 #include <asm-generic/bitops/non-atomic.h>
 
-static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
 	__clear_bit(nr, addr);
@@ -215,14 +218,14 @@ static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
  * fls: find last (most-significant) bit set.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __inline__ int fls(unsigned int x)
+static inline int fls(unsigned int x)
 {
 	return 32 - __builtin_clz(x);
 }
 
 #include <asm-generic/bitops/builtin-__fls.h>
 
-static __inline__ int fls64(__u64 x)
+static inline int fls64(__u64 x)
 {
 	return 64 - __builtin_clzll(x);
 }
@@ -239,6 +242,10 @@ unsigned long __arch_hweight64(__u64 w);
 
 #include <asm-generic/bitops/find.h>
 
+/* wrappers that deal with KASAN instrumentation */
+#include <asm-generic/bitops/instrumented-atomic.h>
+#include <asm-generic/bitops/instrumented-lock.h>
+
 /* Little-endian versions */
 #include <asm-generic/bitops/le.h>
 
-- 
2.20.1

