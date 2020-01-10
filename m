Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0313743F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 17:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAJQ5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 11:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgAJQ46 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:58 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1860B2072A;
        Fri, 10 Jan 2020 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675416;
        bh=KIAMMoX4ussuS3054z9TvEMfI1Lp5o0LpTZIancEs/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amy8AtbpFiyydZNlBjGl6AyPq/dqFkLMnG5Nd25wJqp2UpU2SsmznqlUmfg2OLLlH
         EgRcHl31a5idFlyWdFIdN16XgulpTN6hMOC8W8g9eBKIzJbePUkWA2QwU70BcuoDXH
         VMSwifQkxRP1+xJd7CT7q5q94CmSEeNtVK+B/3Wg=
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
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading from scalar types
Date:   Fri, 10 Jan 2020 16:56:34 +0000
Message-Id: <20200110165636.28035-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Passing a volatile-qualified pointer to READ_ONCE() is an absolute
trainwreck for code generation: the use of 'typeof()' to define a
temporary variable inside the macro means that the final evaluation in
macro scope ends up forcing a read back from the stack. When stack
protector is enabled (the default for arm64, at least), this causes
the compiler to vomit up all sorts of junk.

Unfortunately, dropping pointer qualifiers inside the macro poses quite
a challenge, especially since the pointed-to type is permitted to be an
aggregate, and this is relied upon by mm/ code accessing things like
'pmd_t'. Based on numerous hacks and discussions on the mailing list,
this is the best I've managed to come up with.

Introduce '__unqual_scalar_typeof()' which takes an expression and, if
the expression is an optionally qualified 8, 16, 32 or 64-bit scalar
type, evaluates to the unqualified type. Other input types, including
aggregates, remain unchanged. Hopefully READ_ONCE() on volatile aggregate
pointers isn't something we do on a fast-path.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h       |  6 +++---
 include/linux/compiler_types.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 863180641336..d3491fd44c19 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,13 +203,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
+#define __READ_ONCE(x)	(*(volatile __unqual_scalar_typeof(x) *)&(x))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-	typeof(x) __x = __READ_ONCE(x);					\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
 	smp_read_barrier_depends();					\
-	__x;								\
+	(typeof(x))__x;							\
 })
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..21e7859a356f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -219,6 +219,21 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
+#define __unqual_scalar_typeof(x) typeof(					\
+	__builtin_choose_expr(__same_type(x, (__s8)0), (__s8)0,			\
+	__builtin_choose_expr(__same_type(x, (__u8)0), (__u8)0,			\
+	__builtin_choose_expr(__same_type(x, (__s16)0), (__s16)0,		\
+	__builtin_choose_expr(__same_type(x, (__u16)0), (__u16)0,		\
+	__builtin_choose_expr(__same_type(x, (__s32)0), (__s32)0,		\
+	__builtin_choose_expr(__same_type(x, (__u32)0), (__u32)0,		\
+	__builtin_choose_expr(__same_type(x, 0L), 0L,				\
+	__builtin_choose_expr(__same_type(x, 0UL), 0UL,				\
+	__builtin_choose_expr(__same_type(x, 0LL), 0LL,				\
+	__builtin_choose_expr(__same_type(x, 0ULL), 0ULL,			\
+	(x)									\
+)))))))))))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-- 
2.25.0.rc1.283.g88dfdc4193-goog

