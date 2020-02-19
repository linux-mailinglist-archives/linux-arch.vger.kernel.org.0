Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779CD164825
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBSPOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgBSPOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IpnIrcYzxW/pmCh8r6ahrVqxFjZ64TN/ui0oK82jKgM=; b=ScaRK5D/tZ31OgEP5QXbUcKDSK
        j/iL4cDvhMBtVLeuIRtHLmUt1XJmOdzLQFQd4+o7zcYOL+Uf76ye+1X80hfqQZ/JairwJwA02meLx
        kESuMQGYVGunYHTnmxk+EqLxMG4jl0A0rGQ/+f+mcvkQJU9yf55pwiFhkDzFaBrqakA1rfpcIc1Qa
        yitRzkfAcVyLtsrr/oym9v5JItwFuoPYuOhUhfdzTxzcuhy4FdfLaUP53ol1Fzm+3KiSvABvb08TW
        b4kEv/1m0VHJIkR1gYeZavIxnDq3+GOdvq422g/mt1ZjNXBdOq6mYRscv8HRKsgZIdzoM+CNjWrKR
        5BmXMaXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3A-0007fU-KJ; Wed, 19 Feb 2020 15:14:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A41E307936;
        Wed, 19 Feb 2020 16:12:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AEE002B4D7B88; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.357784675@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 17/22] asm-generic/atomic: Use __always_inline for pure wrappers    
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

Prefer __always_inline for atomic wrappers. When building for size
(CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
inline even relatively small static inline functions that are assumed to
be inlinable such as atomic ops. This can cause problems, for example in
UACCESS regions.

By using __always_inline, we let the real implementation and not the
wrapper determine the final inlining preference.

For x86 tinyconfig we observe:
 - vmlinux baseline: 1316204
 - vmlinux with patch: 1315988 (-216 bytes)

This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
in the KCSAN runtime:
http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 include/asm-generic/atomic-instrumented.h |  335 +++++++++++++++---------------
 include/asm-generic/atomic-long.h         |  331 ++++++++++++++---------------
 scripts/atomic/gen-atomic-instrumented.sh |    7 
 scripts/atomic/gen-atomic-long.sh         |    3 
 4 files changed, 340 insertions(+), 336 deletions(-)

--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -18,19 +18,20 @@
 #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 
-static inline void __atomic_check_read(const volatile void *v, size_t size)
+static __always_inline void __atomic_check_read(const volatile void *v, size_t size)
 {
 	kasan_check_read(v, size);
 }
 
-static inline void __atomic_check_write(const volatile void *v, size_t size)
+static __always_inline void __atomic_check_write(const volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 }
 
-static inline int
+static __always_inline int
 atomic_read(const atomic_t *v)
 {
 	__atomic_check_read(v, sizeof(*v));
@@ -39,7 +40,7 @@ atomic_read(const atomic_t *v)
 #define atomic_read atomic_read
 
 #if defined(arch_atomic_read_acquire)
-static inline int
+static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	__atomic_check_read(v, sizeof(*v));
@@ -48,7 +49,7 @@ atomic_read_acquire(const atomic_t *v)
 #define atomic_read_acquire atomic_read_acquire
 #endif
 
-static inline void
+static __always_inline void
 atomic_set(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -57,7 +58,7 @@ atomic_set(atomic_t *v, int i)
 #define atomic_set atomic_set
 
 #if defined(arch_atomic_set_release)
-static inline void
+static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -66,7 +67,7 @@ atomic_set_release(atomic_t *v, int i)
 #define atomic_set_release atomic_set_release
 #endif
 
-static inline void
+static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -75,7 +76,7 @@ atomic_add(int i, atomic_t *v)
 #define atomic_add atomic_add
 
 #if !defined(arch_atomic_add_return_relaxed) || defined(arch_atomic_add_return)
-static inline int
+static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -85,7 +86,7 @@ atomic_add_return(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_add_return_acquire)
-static inline int
+static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -95,7 +96,7 @@ atomic_add_return_acquire(int i, atomic_
 #endif
 
 #if defined(arch_atomic_add_return_release)
-static inline int
+static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -105,7 +106,7 @@ atomic_add_return_release(int i, atomic_
 #endif
 
 #if defined(arch_atomic_add_return_relaxed)
-static inline int
+static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -115,7 +116,7 @@ atomic_add_return_relaxed(int i, atomic_
 #endif
 
 #if !defined(arch_atomic_fetch_add_relaxed) || defined(arch_atomic_fetch_add)
-static inline int
+static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -125,7 +126,7 @@ atomic_fetch_add(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_add_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -135,7 +136,7 @@ atomic_fetch_add_acquire(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_add_release)
-static inline int
+static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -145,7 +146,7 @@ atomic_fetch_add_release(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_add_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -154,7 +155,7 @@ atomic_fetch_add_relaxed(int i, atomic_t
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -163,7 +164,7 @@ atomic_sub(int i, atomic_t *v)
 #define atomic_sub atomic_sub
 
 #if !defined(arch_atomic_sub_return_relaxed) || defined(arch_atomic_sub_return)
-static inline int
+static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -173,7 +174,7 @@ atomic_sub_return(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_sub_return_acquire)
-static inline int
+static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -183,7 +184,7 @@ atomic_sub_return_acquire(int i, atomic_
 #endif
 
 #if defined(arch_atomic_sub_return_release)
-static inline int
+static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -193,7 +194,7 @@ atomic_sub_return_release(int i, atomic_
 #endif
 
 #if defined(arch_atomic_sub_return_relaxed)
-static inline int
+static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -203,7 +204,7 @@ atomic_sub_return_relaxed(int i, atomic_
 #endif
 
 #if !defined(arch_atomic_fetch_sub_relaxed) || defined(arch_atomic_fetch_sub)
-static inline int
+static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -213,7 +214,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_sub_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -223,7 +224,7 @@ atomic_fetch_sub_acquire(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_sub_release)
-static inline int
+static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -233,7 +234,7 @@ atomic_fetch_sub_release(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_sub_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -243,7 +244,7 @@ atomic_fetch_sub_relaxed(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_inc)
-static inline void
+static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -253,7 +254,7 @@ atomic_inc(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_return)
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -263,7 +264,7 @@ atomic_inc_return(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_return_acquire)
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -273,7 +274,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_return_release)
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -283,7 +284,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_return_relaxed)
-static inline int
+static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -293,7 +294,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_inc)
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -303,7 +304,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_inc_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -313,7 +314,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_inc_release)
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -323,7 +324,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_inc_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -333,7 +334,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec)
-static inline void
+static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -343,7 +344,7 @@ atomic_dec(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_return)
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -353,7 +354,7 @@ atomic_dec_return(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_return_acquire)
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -363,7 +364,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_return_release)
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -373,7 +374,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_return_relaxed)
-static inline int
+static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -383,7 +384,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_dec)
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -393,7 +394,7 @@ atomic_fetch_dec(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_dec_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -403,7 +404,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_dec_release)
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -413,7 +414,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_dec_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -422,7 +423,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -431,7 +432,7 @@ atomic_and(int i, atomic_t *v)
 #define atomic_and atomic_and
 
 #if !defined(arch_atomic_fetch_and_relaxed) || defined(arch_atomic_fetch_and)
-static inline int
+static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -441,7 +442,7 @@ atomic_fetch_and(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_and_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -451,7 +452,7 @@ atomic_fetch_and_acquire(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_and_release)
-static inline int
+static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -461,7 +462,7 @@ atomic_fetch_and_release(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_and_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -471,7 +472,7 @@ atomic_fetch_and_relaxed(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_andnot)
-static inline void
+static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -481,7 +482,7 @@ atomic_andnot(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_andnot)
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -491,7 +492,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_andnot_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -501,7 +502,7 @@ atomic_fetch_andnot_acquire(int i, atomi
 #endif
 
 #if defined(arch_atomic_fetch_andnot_release)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -511,7 +512,7 @@ atomic_fetch_andnot_release(int i, atomi
 #endif
 
 #if defined(arch_atomic_fetch_andnot_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -520,7 +521,7 @@ atomic_fetch_andnot_relaxed(int i, atomi
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -529,7 +530,7 @@ atomic_or(int i, atomic_t *v)
 #define atomic_or atomic_or
 
 #if !defined(arch_atomic_fetch_or_relaxed) || defined(arch_atomic_fetch_or)
-static inline int
+static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -539,7 +540,7 @@ atomic_fetch_or(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_or_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -549,7 +550,7 @@ atomic_fetch_or_acquire(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_or_release)
-static inline int
+static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -559,7 +560,7 @@ atomic_fetch_or_release(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_or_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -568,7 +569,7 @@ atomic_fetch_or_relaxed(int i, atomic_t
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -577,7 +578,7 @@ atomic_xor(int i, atomic_t *v)
 #define atomic_xor atomic_xor
 
 #if !defined(arch_atomic_fetch_xor_relaxed) || defined(arch_atomic_fetch_xor)
-static inline int
+static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -587,7 +588,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_xor_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -597,7 +598,7 @@ atomic_fetch_xor_acquire(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_xor_release)
-static inline int
+static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -607,7 +608,7 @@ atomic_fetch_xor_release(int i, atomic_t
 #endif
 
 #if defined(arch_atomic_fetch_xor_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -617,7 +618,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t
 #endif
 
 #if !defined(arch_atomic_xchg_relaxed) || defined(arch_atomic_xchg)
-static inline int
+static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -627,7 +628,7 @@ atomic_xchg(atomic_t *v, int i)
 #endif
 
 #if defined(arch_atomic_xchg_acquire)
-static inline int
+static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -637,7 +638,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 #endif
 
 #if defined(arch_atomic_xchg_release)
-static inline int
+static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -647,7 +648,7 @@ atomic_xchg_release(atomic_t *v, int i)
 #endif
 
 #if defined(arch_atomic_xchg_relaxed)
-static inline int
+static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -657,7 +658,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
 #endif
 
 #if !defined(arch_atomic_cmpxchg_relaxed) || defined(arch_atomic_cmpxchg)
-static inline int
+static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -667,7 +668,7 @@ atomic_cmpxchg(atomic_t *v, int old, int
 #endif
 
 #if defined(arch_atomic_cmpxchg_acquire)
-static inline int
+static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -677,7 +678,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int
 #endif
 
 #if defined(arch_atomic_cmpxchg_release)
-static inline int
+static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -687,7 +688,7 @@ atomic_cmpxchg_release(atomic_t *v, int
 #endif
 
 #if defined(arch_atomic_cmpxchg_relaxed)
-static inline int
+static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -697,7 +698,7 @@ atomic_cmpxchg_relaxed(atomic_t *v, int
 #endif
 
 #if defined(arch_atomic_try_cmpxchg)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -708,7 +709,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_acquire)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -719,7 +720,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v,
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_release)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -730,7 +731,7 @@ atomic_try_cmpxchg_release(atomic_t *v,
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_relaxed)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -741,7 +742,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v,
 #endif
 
 #if defined(arch_atomic_sub_and_test)
-static inline bool
+static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -751,7 +752,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_and_test)
-static inline bool
+static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -761,7 +762,7 @@ atomic_dec_and_test(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_and_test)
-static inline bool
+static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -771,7 +772,7 @@ atomic_inc_and_test(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_add_negative)
-static inline bool
+static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -781,7 +782,7 @@ atomic_add_negative(int i, atomic_t *v)
 #endif
 
 #if defined(arch_atomic_fetch_add_unless)
-static inline int
+static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -791,7 +792,7 @@ atomic_fetch_add_unless(atomic_t *v, int
 #endif
 
 #if defined(arch_atomic_add_unless)
-static inline bool
+static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -801,7 +802,7 @@ atomic_add_unless(atomic_t *v, int a, in
 #endif
 
 #if defined(arch_atomic_inc_not_zero)
-static inline bool
+static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -811,7 +812,7 @@ atomic_inc_not_zero(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_inc_unless_negative)
-static inline bool
+static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -821,7 +822,7 @@ atomic_inc_unless_negative(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_unless_positive)
-static inline bool
+static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -831,7 +832,7 @@ atomic_dec_unless_positive(atomic_t *v)
 #endif
 
 #if defined(arch_atomic_dec_if_positive)
-static inline int
+static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -840,7 +841,7 @@ atomic_dec_if_positive(atomic_t *v)
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
-static inline s64
+static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
 	__atomic_check_read(v, sizeof(*v));
@@ -849,7 +850,7 @@ atomic64_read(const atomic64_t *v)
 #define atomic64_read atomic64_read
 
 #if defined(arch_atomic64_read_acquire)
-static inline s64
+static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	__atomic_check_read(v, sizeof(*v));
@@ -858,7 +859,7 @@ atomic64_read_acquire(const atomic64_t *
 #define atomic64_read_acquire atomic64_read_acquire
 #endif
 
-static inline void
+static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -867,7 +868,7 @@ atomic64_set(atomic64_t *v, s64 i)
 #define atomic64_set atomic64_set
 
 #if defined(arch_atomic64_set_release)
-static inline void
+static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -876,7 +877,7 @@ atomic64_set_release(atomic64_t *v, s64
 #define atomic64_set_release atomic64_set_release
 #endif
 
-static inline void
+static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -885,7 +886,7 @@ atomic64_add(s64 i, atomic64_t *v)
 #define atomic64_add atomic64_add
 
 #if !defined(arch_atomic64_add_return_relaxed) || defined(arch_atomic64_add_return)
-static inline s64
+static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -895,7 +896,7 @@ atomic64_add_return(s64 i, atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_add_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -905,7 +906,7 @@ atomic64_add_return_acquire(s64 i, atomi
 #endif
 
 #if defined(arch_atomic64_add_return_release)
-static inline s64
+static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -915,7 +916,7 @@ atomic64_add_return_release(s64 i, atomi
 #endif
 
 #if defined(arch_atomic64_add_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -925,7 +926,7 @@ atomic64_add_return_relaxed(s64 i, atomi
 #endif
 
 #if !defined(arch_atomic64_fetch_add_relaxed) || defined(arch_atomic64_fetch_add)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -935,7 +936,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_add_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -945,7 +946,7 @@ atomic64_fetch_add_acquire(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_add_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -955,7 +956,7 @@ atomic64_fetch_add_release(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_add_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -964,7 +965,7 @@ atomic64_fetch_add_relaxed(s64 i, atomic
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -973,7 +974,7 @@ atomic64_sub(s64 i, atomic64_t *v)
 #define atomic64_sub atomic64_sub
 
 #if !defined(arch_atomic64_sub_return_relaxed) || defined(arch_atomic64_sub_return)
-static inline s64
+static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -983,7 +984,7 @@ atomic64_sub_return(s64 i, atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_sub_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -993,7 +994,7 @@ atomic64_sub_return_acquire(s64 i, atomi
 #endif
 
 #if defined(arch_atomic64_sub_return_release)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1003,7 +1004,7 @@ atomic64_sub_return_release(s64 i, atomi
 #endif
 
 #if defined(arch_atomic64_sub_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1013,7 +1014,7 @@ atomic64_sub_return_relaxed(s64 i, atomi
 #endif
 
 #if !defined(arch_atomic64_fetch_sub_relaxed) || defined(arch_atomic64_fetch_sub)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1023,7 +1024,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_sub_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1033,7 +1034,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_sub_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1043,7 +1044,7 @@ atomic64_fetch_sub_release(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_sub_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1053,7 +1054,7 @@ atomic64_fetch_sub_relaxed(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_inc)
-static inline void
+static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1063,7 +1064,7 @@ atomic64_inc(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_inc_return)
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1073,7 +1074,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_inc_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1083,7 +1084,7 @@ atomic64_inc_return_acquire(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_inc_return_release)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1093,7 +1094,7 @@ atomic64_inc_return_release(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_inc_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1103,7 +1104,7 @@ atomic64_inc_return_relaxed(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_fetch_inc)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1113,7 +1114,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_inc_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1123,7 +1124,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_fetch_inc_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1133,7 +1134,7 @@ atomic64_fetch_inc_release(atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_fetch_inc_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1143,7 +1144,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_dec)
-static inline void
+static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1153,7 +1154,7 @@ atomic64_dec(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_dec_return)
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1163,7 +1164,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_dec_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1173,7 +1174,7 @@ atomic64_dec_return_acquire(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_dec_return_release)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1183,7 +1184,7 @@ atomic64_dec_return_release(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_dec_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1193,7 +1194,7 @@ atomic64_dec_return_relaxed(atomic64_t *
 #endif
 
 #if defined(arch_atomic64_fetch_dec)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1203,7 +1204,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_dec_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1213,7 +1214,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_fetch_dec_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1223,7 +1224,7 @@ atomic64_fetch_dec_release(atomic64_t *v
 #endif
 
 #if defined(arch_atomic64_fetch_dec_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1232,7 +1233,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1241,7 +1242,7 @@ atomic64_and(s64 i, atomic64_t *v)
 #define atomic64_and atomic64_and
 
 #if !defined(arch_atomic64_fetch_and_relaxed) || defined(arch_atomic64_fetch_and)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1251,7 +1252,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_and_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1261,7 +1262,7 @@ atomic64_fetch_and_acquire(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_and_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1271,7 +1272,7 @@ atomic64_fetch_and_release(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_and_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1281,7 +1282,7 @@ atomic64_fetch_and_relaxed(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_andnot)
-static inline void
+static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1291,7 +1292,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_andnot)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1301,7 +1302,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1311,7 +1312,7 @@ atomic64_fetch_andnot_acquire(s64 i, ato
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1321,7 +1322,7 @@ atomic64_fetch_andnot_release(s64 i, ato
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1330,7 +1331,7 @@ atomic64_fetch_andnot_relaxed(s64 i, ato
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1339,7 +1340,7 @@ atomic64_or(s64 i, atomic64_t *v)
 #define atomic64_or atomic64_or
 
 #if !defined(arch_atomic64_fetch_or_relaxed) || defined(arch_atomic64_fetch_or)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1349,7 +1350,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_or_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1359,7 +1360,7 @@ atomic64_fetch_or_acquire(s64 i, atomic6
 #endif
 
 #if defined(arch_atomic64_fetch_or_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1369,7 +1370,7 @@ atomic64_fetch_or_release(s64 i, atomic6
 #endif
 
 #if defined(arch_atomic64_fetch_or_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1378,7 +1379,7 @@ atomic64_fetch_or_relaxed(s64 i, atomic6
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1387,7 +1388,7 @@ atomic64_xor(s64 i, atomic64_t *v)
 #define atomic64_xor atomic64_xor
 
 #if !defined(arch_atomic64_fetch_xor_relaxed) || defined(arch_atomic64_fetch_xor)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1397,7 +1398,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_fetch_xor_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1407,7 +1408,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_xor_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1417,7 +1418,7 @@ atomic64_fetch_xor_release(s64 i, atomic
 #endif
 
 #if defined(arch_atomic64_fetch_xor_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1427,7 +1428,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic
 #endif
 
 #if !defined(arch_atomic64_xchg_relaxed) || defined(arch_atomic64_xchg)
-static inline s64
+static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1437,7 +1438,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 #endif
 
 #if defined(arch_atomic64_xchg_acquire)
-static inline s64
+static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1447,7 +1448,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64
 #endif
 
 #if defined(arch_atomic64_xchg_release)
-static inline s64
+static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1457,7 +1458,7 @@ atomic64_xchg_release(atomic64_t *v, s64
 #endif
 
 #if defined(arch_atomic64_xchg_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1467,7 +1468,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64
 #endif
 
 #if !defined(arch_atomic64_cmpxchg_relaxed) || defined(arch_atomic64_cmpxchg)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1477,7 +1478,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old,
 #endif
 
 #if defined(arch_atomic64_cmpxchg_acquire)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1487,7 +1488,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v,
 #endif
 
 #if defined(arch_atomic64_cmpxchg_release)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1497,7 +1498,7 @@ atomic64_cmpxchg_release(atomic64_t *v,
 #endif
 
 #if defined(arch_atomic64_cmpxchg_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1507,7 +1508,7 @@ atomic64_cmpxchg_relaxed(atomic64_t *v,
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1518,7 +1519,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_acquire)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1529,7 +1530,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_release)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1540,7 +1541,7 @@ atomic64_try_cmpxchg_release(atomic64_t
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_relaxed)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1551,7 +1552,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t
 #endif
 
 #if defined(arch_atomic64_sub_and_test)
-static inline bool
+static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1561,7 +1562,7 @@ atomic64_sub_and_test(s64 i, atomic64_t
 #endif
 
 #if defined(arch_atomic64_dec_and_test)
-static inline bool
+static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1571,7 +1572,7 @@ atomic64_dec_and_test(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_inc_and_test)
-static inline bool
+static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1581,7 +1582,7 @@ atomic64_inc_and_test(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_add_negative)
-static inline bool
+static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1591,7 +1592,7 @@ atomic64_add_negative(s64 i, atomic64_t
 #endif
 
 #if defined(arch_atomic64_fetch_add_unless)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1601,7 +1602,7 @@ atomic64_fetch_add_unless(atomic64_t *v,
 #endif
 
 #if defined(arch_atomic64_add_unless)
-static inline bool
+static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1611,7 +1612,7 @@ atomic64_add_unless(atomic64_t *v, s64 a
 #endif
 
 #if defined(arch_atomic64_inc_not_zero)
-static inline bool
+static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1621,7 +1622,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 #endif
 
 #if defined(arch_atomic64_inc_unless_negative)
-static inline bool
+static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1631,7 +1632,7 @@ atomic64_inc_unless_negative(atomic64_t
 #endif
 
 #if defined(arch_atomic64_dec_unless_positive)
-static inline bool
+static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1641,7 +1642,7 @@ atomic64_dec_unless_positive(atomic64_t
 #endif
 
 #if defined(arch_atomic64_dec_if_positive)
-static inline s64
+static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	__atomic_check_write(v, sizeof(*v));
@@ -1795,4 +1796,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// aa929c117bdd954a0957b91fe509f118ca8b9707
+// 6c1b0b614b55b76c258f89e205622e8f004871af
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_GENERIC_ATOMIC_LONG_H
 #define _ASM_GENERIC_ATOMIC_LONG_H
 
+#include <linux/compiler.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT
@@ -22,493 +23,493 @@ typedef atomic_t atomic_long_t;
 
 #ifdef CONFIG_64BIT
 
-static inline long
+static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
 	return atomic64_read(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
 	return atomic64_read_acquire(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
 	atomic64_set(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set_release(atomic_long_t *v, long i)
 {
 	atomic64_set_release(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
 	atomic64_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return(long i, atomic_long_t *v)
 {
 	return atomic64_add_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_release(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
 	atomic64_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
 	atomic64_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return(atomic_long_t *v)
 {
 	return atomic64_inc_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
 	return atomic64_inc_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_release(atomic_long_t *v)
 {
 	return atomic64_inc_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
 	return atomic64_inc_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc(atomic_long_t *v)
 {
 	return atomic64_fetch_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_release(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
 	atomic64_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return(atomic_long_t *v)
 {
 	return atomic64_dec_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
 	return atomic64_dec_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_release(atomic_long_t *v)
 {
 	return atomic64_dec_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
 	return atomic64_dec_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec(atomic_long_t *v)
 {
 	return atomic64_fetch_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_release(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
 	atomic64_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
 	atomic64_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
 	atomic64_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
 	atomic64_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg(atomic_long_t *v, long i)
 {
 	return atomic64_xchg(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_acquire(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_release(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_release(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_relaxed(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_acquire(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_release(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_relaxed(v, old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_release(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
 	return atomic64_sub_and_test(i, v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_and_test(atomic_long_t *v)
 {
 	return atomic64_dec_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_and_test(atomic_long_t *v)
 {
 	return atomic64_inc_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_negative(long i, atomic_long_t *v)
 {
 	return atomic64_add_negative(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic64_fetch_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic64_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_not_zero(atomic_long_t *v)
 {
 	return atomic64_inc_not_zero(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_unless_negative(atomic_long_t *v)
 {
 	return atomic64_inc_unless_negative(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_unless_positive(atomic_long_t *v)
 {
 	return atomic64_dec_unless_positive(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
 {
 	return atomic64_dec_if_positive(v);
@@ -516,493 +517,493 @@ atomic_long_dec_if_positive(atomic_long_
 
 #else /* CONFIG_64BIT */
 
-static inline long
+static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
 	return atomic_read(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
 	return atomic_read_acquire(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
 	atomic_set(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set_release(atomic_long_t *v, long i)
 {
 	atomic_set_release(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
 	atomic_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return(long i, atomic_long_t *v)
 {
 	return atomic_add_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic_add_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_release(long i, atomic_long_t *v)
 {
 	return atomic_add_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_add_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
 	atomic_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return(long i, atomic_long_t *v)
 {
 	return atomic_sub_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
 	atomic_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return(atomic_long_t *v)
 {
 	return atomic_inc_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
 	return atomic_inc_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_release(atomic_long_t *v)
 {
 	return atomic_inc_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
 	return atomic_inc_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc(atomic_long_t *v)
 {
 	return atomic_fetch_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
 	return atomic_fetch_inc_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_release(atomic_long_t *v)
 {
 	return atomic_fetch_inc_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
 	return atomic_fetch_inc_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
 	atomic_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return(atomic_long_t *v)
 {
 	return atomic_dec_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
 	return atomic_dec_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_release(atomic_long_t *v)
 {
 	return atomic_dec_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
 	return atomic_dec_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec(atomic_long_t *v)
 {
 	return atomic_fetch_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
 	return atomic_fetch_dec_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_release(atomic_long_t *v)
 {
 	return atomic_fetch_dec_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
 	return atomic_fetch_dec_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
 	atomic_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
 	atomic_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
 	atomic_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
 	atomic_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg(atomic_long_t *v, long i)
 {
 	return atomic_xchg(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
 	return atomic_xchg_acquire(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_release(atomic_long_t *v, long i)
 {
 	return atomic_xchg_release(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
 	return atomic_xchg_relaxed(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_acquire(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_release(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_relaxed(v, old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_acquire(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_release(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_relaxed(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
 	return atomic_sub_and_test(i, v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_and_test(atomic_long_t *v)
 {
 	return atomic_dec_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_and_test(atomic_long_t *v)
 {
 	return atomic_inc_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_negative(long i, atomic_long_t *v)
 {
 	return atomic_add_negative(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic_fetch_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_not_zero(atomic_long_t *v)
 {
 	return atomic_inc_not_zero(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_unless_negative(atomic_long_t *v)
 {
 	return atomic_inc_unless_negative(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_unless_positive(atomic_long_t *v)
 {
 	return atomic_dec_unless_positive(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
 {
 	return atomic_dec_if_positive(v);
@@ -1010,4 +1011,4 @@ atomic_long_dec_if_positive(atomic_long_
 
 #endif /* CONFIG_64BIT */
 #endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// 77558968132ce4f911ad53f6f52ce423006f6268
+// a624200981f552b2c6be4f32fe44da8289f30d87
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -84,7 +84,7 @@ gen_proto_order_variant()
 	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
 
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomicname}(${params})
 {
 ${checks}
@@ -147,14 +147,15 @@ cat << EOF
 #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 
-static inline void __atomic_check_read(const volatile void *v, size_t size)
+static __always_inline void __atomic_check_read(const volatile void *v, size_t size)
 {
 	kasan_check_read(v, size);
 }
 
-static inline void __atomic_check_write(const volatile void *v, size_t size)
+static __always_inline void __atomic_check_write(const volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 }
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -46,7 +46,7 @@ gen_proto_order_variant()
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 atomic_long_${name}(${params})
 {
 	${retstmt}${atomic}_${name}(${argscast});
@@ -64,6 +64,7 @@ cat << EOF
 #ifndef _ASM_GENERIC_ATOMIC_LONG_H
 #define _ASM_GENERIC_ATOMIC_LONG_H
 
+#include <linux/compiler.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT


