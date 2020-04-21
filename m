Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA54E1B2AE9
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgDUPQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgDUPQM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:16:12 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723432070B;
        Tue, 21 Apr 2020 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482171;
        bh=vjzVo6dVD1zQ5ZhU+t8+amCBrVTU8/hgBe76KRhiEPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Y/me0rgokrFHbcRqD/kPlUiAEM/0MHEwDraZERYVKPnxbrwNPBsHZe3QpsC9vYP8
         nj1cvV4s+CCoI/4TcAkTnP3KNNYYuvS/KGzs+kGLsBxqmP5OxKDjTyk7yzw6P3wPoP
         UgGif9w0/XoJrYvlfrX2bzDL3nI1MeHxtTHwUSxg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v4 09/11] locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
Date:   Tue, 21 Apr 2020 16:15:35 +0100
Message-Id: <20200421151537.19241-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Passing volatile-qualified pointers to the asm-generic implementations of
the load-acquire macros results in a re-load from the stack due to the
temporary result variable inheriting the volatile semantics thanks to the
use of 'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 85b28eb80b11..2eacaf7d62f6 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -128,10 +128,10 @@ do {									\
 #ifndef __smp_load_acquire
 #define __smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	__smp_mb();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -183,10 +183,10 @@ do {									\
 #ifndef smp_load_acquire
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -229,14 +229,14 @@ do {									\
 #ifndef smp_cond_load_relaxed
 #define smp_cond_load_relaxed(ptr, cond_expr) ({		\
 	typeof(ptr) __PTR = (ptr);				\
-	typeof(*ptr) VAL;					\
+	__unqual_scalar_typeof(*ptr) VAL;			\
 	for (;;) {						\
 		VAL = READ_ONCE(*__PTR);			\
 		if (cond_expr)					\
 			break;					\
 		cpu_relax();					\
 	}							\
-	VAL;							\
+	(typeof(*ptr))VAL;					\
 })
 #endif
 
@@ -250,10 +250,10 @@ do {									\
  */
 #ifndef smp_cond_load_acquire
 #define smp_cond_load_acquire(ptr, cond_expr) ({		\
-	typeof(*ptr) _val;					\
+	__unqual_scalar_typeof(*ptr) _val;			\
 	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
 	smp_acquire__after_ctrl_dep();				\
-	_val;							\
+	(typeof(*ptr))_val;					\
 })
 #endif
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

