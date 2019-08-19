Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9391D0E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHSG2Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 02:28:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfHSG2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 02:28:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so569775pfp.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2019 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPQB69yWRrfnt5mqgKFU9csZRzqxMbwma7Xig4WeJx0=;
        b=Ks1ESLvCPBBOXAUrm0znq2PKp9y+9vnQeylHfYwxozEakRFVtb5m2mQrtrhpqAPX5a
         yKsLo0t+VAz/M6Bw6Co/HtdxN9CapVCwJ6cb4AkQiURHXcWMCXE50+Zhx3DE1qP/A/j6
         OXVMebkHjxf9IMX4EphOB8kvJqh4JCkHitup0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPQB69yWRrfnt5mqgKFU9csZRzqxMbwma7Xig4WeJx0=;
        b=rSc/IB3iP8vsXsAbgK1nf7eeBBbbtr3tmR7p+/17x7mUalXfYmhhJAHjVfwkai1iym
         HCOUHJ2lQFSU4WVupXWcU3aF08Hq0pS4bYfBS9sllJdxu+19eJnVPWOS/Z0XkZZHgQbk
         cmtk84MHAb1/CAZVGr74zfysw/drt+v9qw5DDvD0QQxLCVt0Z4CBAduklf17xJOi66kc
         +tTrThn0jn5YO5JgEHO9LFNKs2f0a+gv9zzAHkdFYq4JGsF74mELEUniNO6tKK8V8NEd
         PB6aNL8SVOx8P1Y1opI84p/y0VsjXHJD9yg5FKNyzMfaCfufOimFUREDhsmVHr+v2byn
         r4mw==
X-Gm-Message-State: APjAAAWTwzSohA5KeTpVXhyhzYP+QdrMqp75UQn9W8knqNjqqIQewWeq
        Z3KnImZ2ihGbLO2I3BencGhVNw==
X-Google-Smtp-Source: APXvYqzmHtav9cLjoJDNHobYAlg166JNQbUPUsaEOM8flvrqwW3jHDGsBkHenm3A3v2fZ2nR7iC5Xg==
X-Received: by 2002:a17:90a:3646:: with SMTP id s64mr19329426pjb.44.1566196104738;
        Sun, 18 Aug 2019 23:28:24 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id y13sm3557979pfb.48.2019.08.18.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 23:28:24 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] powerpc: support KASAN instrumentation of bitops
Date:   Mon, 19 Aug 2019 16:28:14 +1000
Message-Id: <20190819062814.5315-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819062814.5315-1-dja@axtens.net>
References: <20190819062814.5315-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In KASAN development I noticed that the powerpc-specific bitops
were not being picked up by the KASAN test suite.

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

Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/bitops.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 603aed229af7..8615b2bc35fe 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
 DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
 DEFINE_BITOP(change_bits, xor, "")
 
-static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_clear_bit(int nr, volatile unsigned long *addr)
 {
 	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+static __inline__ void arch_clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_change_bit(int nr, volatile unsigned long *addr)
 {
 	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
@@ -138,26 +138,26 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
-static __inline__ int test_and_set_bit(unsigned long nr,
+static __inline__ int arch_test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_set_bit_lock(unsigned long nr,
+static __inline__ int arch_test_and_set_bit_lock(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits_lock(BIT_MASK(nr),
 				addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_clear_bit(unsigned long nr,
+static __inline__ int arch_test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
 	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_change_bit(unsigned long nr,
+static __inline__ int arch_test_and_change_bit(unsigned long nr,
 					  volatile unsigned long *addr)
 {
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
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
+static __inline__ void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
 	__clear_bit(nr, addr);
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

