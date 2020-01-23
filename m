Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93B146CFE
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWPeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgAWPeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:34:09 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3132A20684;
        Thu, 23 Jan 2020 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793648;
        bh=6Oh8WhxCfEGGv3CofoUJVWHXz5PnbyOZzdi3NMtempM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcU/JCE4OWkIPSB4l6bNx0t3LGAyw0aUiyQLD56nQd4l/4BIiXyxYSNMLylzO3NpG
         B5bucgz2a4gV+j5VeQloAFZbUDuB6dWk71j7cK0hBmbAfiNMRxJOwT5s8JNZUSG5cM
         /TTYHvjGKJJOi0pxGuPGjIjMQ/RdZu1xIOIXFu/Y=
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
Subject: [PATCH v2 06/10] READ_ONCE: Drop pointer qualifiers when reading from scalar types
Date:   Thu, 23 Jan 2020 15:33:37 +0000
Message-Id: <20200123153341.19947-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
References: <20200123153341.19947-1-will@kernel.org>
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

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h       |  6 +++---
 include/linux/compiler_types.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index a7b2195f2655..994c35638584 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,13 +203,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile typeof(x) *)&(x))
+#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
 
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
index 72393a8c1a6c..58361f2d3b98 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -219,6 +219,27 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ *
+ * We build this out of a couple of helper macros in a vain attempt to
+ * help you keep your lunch down while reading it.
+ */
+#define __pick_scalar_type(x, type, otherwise)					\
+	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
+
+#define __pick_integer_type(x, type, otherwise)					\
+	__pick_scalar_type(x, unsigned type,					\
+		__pick_scalar_type(x, signed type, otherwise))
+
+#define __unqual_scalar_typeof(x) typeof(					\
+	__pick_integer_type(x, char,						\
+		__pick_integer_type(x, short,					\
+			__pick_integer_type(x, int,				\
+				__pick_integer_type(x, long,			\
+					__pick_integer_type(x, long long, x))))))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-- 
2.25.0.341.g760bfbb309-goog

