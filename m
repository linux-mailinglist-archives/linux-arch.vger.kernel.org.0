Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F91146CFF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAWPeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgAWPeL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:34:11 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7F721D7D;
        Thu, 23 Jan 2020 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793651;
        bh=EO//m1a5/W3ayPB+jVjN2R3Nvy9PLK/PkD+2e3tSVsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L//ee4fa7iSJOyltW23ThNXNer+l9jfq1sDnIRdPDwvW6qtuMc7TcN0QbwnJYw6M7
         uZcQXMhQiFjyfk9DrrVJzQMFGbZYPoa9rvoJQBId+RlgL+8OM5gXwlfBiq4NqvB9KH
         Rt3oXdJVoECuS81cfkSNb8d52iznzKUMyLNTQDq0=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
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
Subject: [PATCH v2 07/10] locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
Date:   Thu, 23 Jan 2020 15:33:38 +0000
Message-Id: <20200123153341.19947-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
References: <20200123153341.19947-1-will@kernel.org>
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
2.25.0.341.g760bfbb309-goog

