Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A21167F0E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgBUNu3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgBUNu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KNA7g95AIU9Tp5gBDDKjjSL2xc2yep1t+tkvjlPNVzE=; b=SQmvK2RHUf0XNpD5ikpHMDon7o
        sCGc10NJjC4lSyNf+vzFyuZKRMQIupNnb+TP0n2MZxhriK68QSnjTT0qyhsokt6Jh4B/bXt1DUwmL
        t2GPXnpydxnuSKB7mVxoJVEIhcUdfg7OCHgXRMudoQyYPVKeT0tmSlVayaAQsxdys7MBH+Qh5I9ce
        BtMZIOXUPac3l2ACO8jDfHx9Kq+8NaO4YeKXTlIoRWstGSlSl6b6nIeQt1XysJs6rUwylSCbLjYue
        fIXrRaIU2yIID6WAijG/ScBS/liHWzgPm724iywXi/ZpTkCnsCAEEJiAHE7pX9KDpj7mkr9ffrkIj
        oXSdBDTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gx-00016l-C2; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6329307943;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 27BA529D740B4; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.515445138@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH v4 21/27] asm-generic/atomic: Use __always_inline for fallback wrappers
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

Use __always_inline for atomic fallback wrappers. When building for size
(CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
inline even relatively small static inline functions that are assumed to
be inlinable such as atomic ops. This can cause problems, for example in
UACCESS regions.

While the fallback wrappers aren't pure wrappers, they are trivial
nonetheless, and the function they wrap should determine the final
inlining policy.

For x86 tinyconfig we observe:
 - vmlinux baseline: 1315988
 - vmlinux with patch: 1315928 (-60 bytes)

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index a7d240e465c0..656b5489b673 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 #ifndef xchg_relaxed
 #define xchg_relaxed		xchg
 #define xchg_acquire		xchg
@@ -76,7 +78,7 @@
 #endif /* cmpxchg64_relaxed */
 
 #ifndef atomic_read_acquire
-static inline int
+static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -85,7 +87,7 @@ atomic_read_acquire(const atomic_t *v)
 #endif
 
 #ifndef atomic_set_release
-static inline void
+static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -100,7 +102,7 @@ atomic_set_release(atomic_t *v, int i)
 #else /* atomic_add_return_relaxed */
 
 #ifndef atomic_add_return_acquire
-static inline int
+static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_add_return_relaxed(i, v);
@@ -111,7 +113,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return_release
-static inline int
+static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -121,7 +123,7 @@ atomic_add_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return
-static inline int
+static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	int ret;
@@ -142,7 +144,7 @@ atomic_add_return(int i, atomic_t *v)
 #else /* atomic_fetch_add_relaxed */
 
 #ifndef atomic_fetch_add_acquire
-static inline int
+static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_add_relaxed(i, v);
@@ -153,7 +155,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add_release
-static inline int
+static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -163,7 +165,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add
-static inline int
+static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	int ret;
@@ -184,7 +186,7 @@ atomic_fetch_add(int i, atomic_t *v)
 #else /* atomic_sub_return_relaxed */
 
 #ifndef atomic_sub_return_acquire
-static inline int
+static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_sub_return_relaxed(i, v);
@@ -195,7 +197,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return_release
-static inline int
+static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -205,7 +207,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return
-static inline int
+static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	int ret;
@@ -226,7 +228,7 @@ atomic_sub_return(int i, atomic_t *v)
 #else /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_fetch_sub_acquire
-static inline int
+static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_sub_relaxed(i, v);
@@ -237,7 +239,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub_release
-static inline int
+static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -247,7 +249,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub
-static inline int
+static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	int ret;
@@ -262,7 +264,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 #endif /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_inc
-static inline void
+static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	atomic_add(1, v);
@@ -278,7 +280,7 @@ atomic_inc(atomic_t *v)
 #endif /* atomic_inc_return */
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	return atomic_add_return(1, v);
@@ -287,7 +289,7 @@ atomic_inc_return(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	return atomic_add_return_acquire(1, v);
@@ -296,7 +298,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	return atomic_add_return_release(1, v);
@@ -305,7 +307,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_relaxed
-static inline int
+static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	return atomic_add_return_relaxed(1, v);
@@ -316,7 +318,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 #else /* atomic_inc_return_relaxed */
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	int ret = atomic_inc_return_relaxed(v);
@@ -327,7 +329,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -337,7 +339,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	int ret;
@@ -359,7 +361,7 @@ atomic_inc_return(atomic_t *v)
 #endif /* atomic_fetch_inc */
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	return atomic_fetch_add(1, v);
@@ -368,7 +370,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	return atomic_fetch_add_acquire(1, v);
@@ -377,7 +379,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	return atomic_fetch_add_release(1, v);
@@ -386,7 +388,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	return atomic_fetch_add_relaxed(1, v);
@@ -397,7 +399,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 #else /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_inc_relaxed(v);
@@ -408,7 +410,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -418,7 +420,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	int ret;
@@ -433,7 +435,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_dec
-static inline void
+static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	atomic_sub(1, v);
@@ -449,7 +451,7 @@ atomic_dec(atomic_t *v)
 #endif /* atomic_dec_return */
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	return atomic_sub_return(1, v);
@@ -458,7 +460,7 @@ atomic_dec_return(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	return atomic_sub_return_acquire(1, v);
@@ -467,7 +469,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	return atomic_sub_return_release(1, v);
@@ -476,7 +478,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_relaxed
-static inline int
+static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	return atomic_sub_return_relaxed(1, v);
@@ -487,7 +489,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 #else /* atomic_dec_return_relaxed */
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	int ret = atomic_dec_return_relaxed(v);
@@ -498,7 +500,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -508,7 +510,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	int ret;
@@ -530,7 +532,7 @@ atomic_dec_return(atomic_t *v)
 #endif /* atomic_fetch_dec */
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	return atomic_fetch_sub(1, v);
@@ -539,7 +541,7 @@ atomic_fetch_dec(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	return atomic_fetch_sub_acquire(1, v);
@@ -548,7 +550,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	return atomic_fetch_sub_release(1, v);
@@ -557,7 +559,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	return atomic_fetch_sub_relaxed(1, v);
@@ -568,7 +570,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 #else /* atomic_fetch_dec_relaxed */
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_dec_relaxed(v);
@@ -579,7 +581,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -589,7 +591,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	int ret;
@@ -610,7 +612,7 @@ atomic_fetch_dec(atomic_t *v)
 #else /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_fetch_and_acquire
-static inline int
+static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_and_relaxed(i, v);
@@ -621,7 +623,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and_release
-static inline int
+static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -631,7 +633,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and
-static inline int
+static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	int ret;
@@ -646,7 +648,7 @@ atomic_fetch_and(int i, atomic_t *v)
 #endif /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_andnot
-static inline void
+static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	atomic_and(~i, v);
@@ -662,7 +664,7 @@ atomic_andnot(int i, atomic_t *v)
 #endif /* atomic_fetch_andnot */
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	return atomic_fetch_and(~i, v);
@@ -671,7 +673,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	return atomic_fetch_and_acquire(~i, v);
@@ -680,7 +682,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	return atomic_fetch_and_release(~i, v);
@@ -689,7 +691,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	return atomic_fetch_and_relaxed(~i, v);
@@ -700,7 +702,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 #else /* atomic_fetch_andnot_relaxed */
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_andnot_relaxed(i, v);
@@ -711,7 +713,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -721,7 +723,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	int ret;
@@ -742,7 +744,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #else /* atomic_fetch_or_relaxed */
 
 #ifndef atomic_fetch_or_acquire
-static inline int
+static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_or_relaxed(i, v);
@@ -753,7 +755,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or_release
-static inline int
+static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -763,7 +765,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or
-static inline int
+static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	int ret;
@@ -784,7 +786,7 @@ atomic_fetch_or(int i, atomic_t *v)
 #else /* atomic_fetch_xor_relaxed */
 
 #ifndef atomic_fetch_xor_acquire
-static inline int
+static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_xor_relaxed(i, v);
@@ -795,7 +797,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor_release
-static inline int
+static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -805,7 +807,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor
-static inline int
+static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	int ret;
@@ -826,7 +828,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 #else /* atomic_xchg_relaxed */
 
 #ifndef atomic_xchg_acquire
-static inline int
+static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	int ret = atomic_xchg_relaxed(v, i);
@@ -837,7 +839,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg_release
-static inline int
+static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	__atomic_release_fence();
@@ -847,7 +849,7 @@ atomic_xchg_release(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg
-static inline int
+static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	int ret;
@@ -868,7 +870,7 @@ atomic_xchg(atomic_t *v, int i)
 #else /* atomic_cmpxchg_relaxed */
 
 #ifndef atomic_cmpxchg_acquire
-static inline int
+static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	int ret = atomic_cmpxchg_relaxed(v, old, new);
@@ -879,7 +881,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg_release
-static inline int
+static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	__atomic_release_fence();
@@ -889,7 +891,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg
-static inline int
+static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -911,7 +913,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 #endif /* atomic_try_cmpxchg */
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -924,7 +926,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -937,7 +939,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -950,7 +952,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -965,7 +967,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 #else /* atomic_try_cmpxchg_relaxed */
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	bool ret = atomic_try_cmpxchg_relaxed(v, old, new);
@@ -976,7 +978,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	__atomic_release_fence();
@@ -986,7 +988,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	bool ret;
@@ -1010,7 +1012,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	return atomic_sub_return(i, v) == 0;
@@ -1027,7 +1029,7 @@ atomic_sub_and_test(int i, atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	return atomic_dec_return(v) == 0;
@@ -1044,7 +1046,7 @@ atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	return atomic_inc_return(v) == 0;
@@ -1062,7 +1064,7 @@ atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	return atomic_add_return(i, v) < 0;
@@ -1080,7 +1082,7 @@ atomic_add_negative(int i, atomic_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline int
+static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c = atomic_read(v);
@@ -1105,7 +1107,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	return atomic_fetch_add_unless(v, a, u) != u;
@@ -1121,7 +1123,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	return atomic_add_unless(v, 1, 0);
@@ -1130,7 +1132,7 @@ atomic_inc_not_zero(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1146,7 +1148,7 @@ atomic_inc_unless_negative(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1162,7 +1164,7 @@ atomic_dec_unless_positive(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_if_positive
-static inline int
+static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	int dec, c = atomic_read(v);
@@ -1186,7 +1188,7 @@ atomic_dec_if_positive(atomic_t *v)
 #endif
 
 #ifndef atomic64_read_acquire
-static inline s64
+static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -1195,7 +1197,7 @@ atomic64_read_acquire(const atomic64_t *v)
 #endif
 
 #ifndef atomic64_set_release
-static inline void
+static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -1210,7 +1212,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 #else /* atomic64_add_return_relaxed */
 
 #ifndef atomic64_add_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_add_return_relaxed(i, v);
@@ -1221,7 +1223,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return_release
-static inline s64
+static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1231,7 +1233,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return
-static inline s64
+static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1252,7 +1254,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_add_relaxed */
 
 #ifndef atomic64_fetch_add_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_add_relaxed(i, v);
@@ -1263,7 +1265,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1273,7 +1275,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add
-static inline s64
+static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1294,7 +1296,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 #else /* atomic64_sub_return_relaxed */
 
 #ifndef atomic64_sub_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_sub_return_relaxed(i, v);
@@ -1305,7 +1307,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return_release
-static inline s64
+static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1315,7 +1317,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return
-static inline s64
+static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1336,7 +1338,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_fetch_sub_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_sub_relaxed(i, v);
@@ -1347,7 +1349,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1357,7 +1359,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1372,7 +1374,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_inc
-static inline void
+static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	atomic64_add(1, v);
@@ -1388,7 +1390,7 @@ atomic64_inc(atomic64_t *v)
 #endif /* atomic64_inc_return */
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	return atomic64_add_return(1, v);
@@ -1397,7 +1399,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	return atomic64_add_return_acquire(1, v);
@@ -1406,7 +1408,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	return atomic64_add_return_release(1, v);
@@ -1415,7 +1417,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	return atomic64_add_return_relaxed(1, v);
@@ -1426,7 +1428,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 #else /* atomic64_inc_return_relaxed */
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_inc_return_relaxed(v);
@@ -1437,7 +1439,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1447,7 +1449,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1469,7 +1471,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif /* atomic64_fetch_inc */
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	return atomic64_fetch_add(1, v);
@@ -1478,7 +1480,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_add_acquire(1, v);
@@ -1487,7 +1489,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	return atomic64_fetch_add_release(1, v);
@@ -1496,7 +1498,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_add_relaxed(1, v);
@@ -1507,7 +1509,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_inc_relaxed(v);
@@ -1518,7 +1520,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1528,7 +1530,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	s64 ret;
@@ -1543,7 +1545,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_dec
-static inline void
+static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	atomic64_sub(1, v);
@@ -1559,7 +1561,7 @@ atomic64_dec(atomic64_t *v)
 #endif /* atomic64_dec_return */
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	return atomic64_sub_return(1, v);
@@ -1568,7 +1570,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	return atomic64_sub_return_acquire(1, v);
@@ -1577,7 +1579,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	return atomic64_sub_return_release(1, v);
@@ -1586,7 +1588,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	return atomic64_sub_return_relaxed(1, v);
@@ -1597,7 +1599,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 #else /* atomic64_dec_return_relaxed */
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_dec_return_relaxed(v);
@@ -1608,7 +1610,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1618,7 +1620,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1640,7 +1642,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif /* atomic64_fetch_dec */
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	return atomic64_fetch_sub(1, v);
@@ -1649,7 +1651,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_sub_acquire(1, v);
@@ -1658,7 +1660,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	return atomic64_fetch_sub_release(1, v);
@@ -1667,7 +1669,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_sub_relaxed(1, v);
@@ -1678,7 +1680,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_dec_relaxed */
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_dec_relaxed(v);
@@ -1689,7 +1691,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1699,7 +1701,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	s64 ret;
@@ -1720,7 +1722,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #else /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_fetch_and_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_and_relaxed(i, v);
@@ -1731,7 +1733,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1741,7 +1743,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and
-static inline s64
+static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1756,7 +1758,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_andnot
-static inline void
+static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	atomic64_and(~i, v);
@@ -1772,7 +1774,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_andnot */
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and(~i, v);
@@ -1781,7 +1783,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_acquire(~i, v);
@@ -1790,7 +1792,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_release(~i, v);
@@ -1799,7 +1801,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_relaxed(~i, v);
@@ -1810,7 +1812,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_andnot_relaxed */
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_andnot_relaxed(i, v);
@@ -1821,7 +1823,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1831,7 +1833,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1852,7 +1854,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_or_relaxed */
 
 #ifndef atomic64_fetch_or_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_or_relaxed(i, v);
@@ -1863,7 +1865,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1873,7 +1875,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or
-static inline s64
+static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1894,7 +1896,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_xor_relaxed */
 
 #ifndef atomic64_fetch_xor_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_xor_relaxed(i, v);
@@ -1905,7 +1907,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1915,7 +1917,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1936,7 +1938,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 #else /* atomic64_xchg_relaxed */
 
 #ifndef atomic64_xchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	s64 ret = atomic64_xchg_relaxed(v, i);
@@ -1947,7 +1949,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg_release
-static inline s64
+static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	__atomic_release_fence();
@@ -1957,7 +1959,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg
-static inline s64
+static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	s64 ret;
@@ -1978,7 +1980,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 #else /* atomic64_cmpxchg_relaxed */
 
 #ifndef atomic64_cmpxchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret = atomic64_cmpxchg_relaxed(v, old, new);
@@ -1989,7 +1991,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg_release
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_release_fence();
@@ -1999,7 +2001,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret;
@@ -2021,7 +2023,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #endif /* atomic64_try_cmpxchg */
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2034,7 +2036,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2047,7 +2049,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2060,7 +2062,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2075,7 +2077,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 #else /* atomic64_try_cmpxchg_relaxed */
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret = atomic64_try_cmpxchg_relaxed(v, old, new);
@@ -2086,7 +2088,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_release_fence();
@@ -2096,7 +2098,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret;
@@ -2120,7 +2122,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return atomic64_sub_return(i, v) == 0;
@@ -2137,7 +2139,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	return atomic64_dec_return(v) == 0;
@@ -2154,7 +2156,7 @@ atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	return atomic64_inc_return(v) == 0;
@@ -2172,7 +2174,7 @@ atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return atomic64_add_return(i, v) < 0;
@@ -2190,7 +2192,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c = atomic64_read(v);
@@ -2215,7 +2217,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	return atomic64_fetch_add_unless(v, a, u) != u;
@@ -2231,7 +2233,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	return atomic64_add_unless(v, 1, 0);
@@ -2240,7 +2242,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2256,7 +2258,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2272,7 +2274,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_if_positive
-static inline s64
+static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 dec, c = atomic64_read(v);
@@ -2292,4 +2294,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 25de4a2804d70f57e994fe3b419148658bb5378a
+// baaf45f4c24ed88ceae58baca39d7fd80bb8101b
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index e38871e64db6..ea489acc285e 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
 	${ret} ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e6f4815637de..03cc2e07fac5 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -8,7 +8,7 @@ cat <<EOF
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
 	return ${atomic}_add_return(i, v) < 0;
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 792533885fbf..daf87a04c850 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -8,7 +8,7 @@ cat << EOF
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
 	return ${atomic}_fetch_add_unless(v, a, u) != u;
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 9f3a3216b5e3..14efce01225a 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
 	${retstmt}${atomic}_${pfx}and${sfx}${order}(~i, v);
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 10bbc82be31d..118282f3a5a3 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
 	${retstmt}${atomic}_${pfx}sub${sfx}${order}(1, v);
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 0ce7103b3df2..f8967a891117 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -7,7 +7,7 @@ cat <<EOF
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_dec_and_test(${atomic}_t *v)
 {
 	return ${atomic}_dec_return(v) == 0;
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index c52eacec43c8..cfb380bd2da6 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_dec_if_positive(${atomic}_t *v)
 {
 	${int} dec, c = ${atomic}_read(v);
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index 8a2578f14268..69cb7aa01f9c 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline bool
+static __always_inline bool
 ${atomic}_dec_unless_positive(${atomic}_t *v)
 {
 	${int} c = ${atomic}_read(v);
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 82f68fa6931a..92a3a4691bab 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index d2c091db7eae..fffbc0d16fdf 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -8,7 +8,7 @@ cat << EOF
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline ${int}
+static __always_inline ${int}
 ${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
 	${int} c = ${atomic}_read(v);
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index f866b3ad2353..10751cd62829 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
 	${retstmt}${atomic}_${pfx}add${sfx}${order}(1, v);
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 4e2068869f7e..4acea9c93604 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -7,7 +7,7 @@ cat <<EOF
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_inc_and_test(${atomic}_t *v)
 {
 	return ${atomic}_inc_return(v) == 0;
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index a7c45c8d107c..d9f7b97aab42 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -6,7 +6,7 @@ cat <<EOF
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_inc_not_zero(${atomic}_t *v)
 {
 	return ${atomic}_add_unless(v, 1, 0);
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 0c266e71dbd4..177a7cb51eda 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline bool
+static __always_inline bool
 ${atomic}_inc_unless_negative(${atomic}_t *v)
 {
 	${int} c = ${atomic}_read(v);
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 75863b5203f7..12fa83cb3a6d 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index 3f628a3802d9..730d2a6d3e07 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 45bb5e0cfc08..e5d72c717434 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline void
+static __always_inline void
 ${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 289ef17a2d7a..6cfe4ed49746 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -8,7 +8,7 @@ cat <<EOF
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 ${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
 	return ${atomic}_sub_return(i, v) == 0;
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 4ed85e2f5378..c7a26213b978 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,5 +1,5 @@
 cat <<EOF
-static inline bool
+static __always_inline bool
 ${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 1bd7c1707633..b6c6f5d306a7 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -149,6 +149,8 @@ cat << EOF
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 EOF
 
 for xchg in "xchg" "cmpxchg" "cmpxchg64"; do


