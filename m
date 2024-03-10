Return-Path: <linux-arch+bounces-2917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C588877516
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9DAB20D6B
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C63A8E8;
	Sun, 10 Mar 2024 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di6pDk6N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CF3A1A2
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036364; cv=none; b=KviWTJQ0L56Ce1vhKDCU0LS9AxN9RmPjSiOshAuSi4qGGXIfnVO1UveXDgr7jPNZs2SejSY2+y6xS+mCCiOKDpXRA0BxHCLbq/kWysWSwS/r1tXUZQovyWXwfALNlK3fMz4lQL7QdZ+znJpCiM8x8NsdHD6d65PFWy8sysJMeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036364; c=relaxed/simple;
	bh=5SZh2mNEl5n+h2lF7KiTxzvDIwYjug3hRJqLAmoNhNQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YoFk3edP+kju82j9sfj9QuXAJh84ugu+ca64cGpyedIHSCrvm1Hf06l34k1CXnSPuLjxpp2Mj+qXBd2oR4LUqdri22RLR8tt7Zu+IFT6v1tTw0MyvKDngePzsZZwweNi5GndoeTVns0UIsiyysd8c2Df5kJSyKzD3SidvRAuOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Di6pDk6N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so4762897b3.2
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036359; x=1710641159; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1/umpZGVsczLzrKS1GZCeAFysDY04buU8ZoM+JBKw=;
        b=Di6pDk6NePavMF2yALztmcFiJt+x7tbKH41g7V7tmKXpI1KI8Xp6mAzitCxmfo9DcO
         6raBeb+eQk7G9fIGxVMs/sYQblO2BRyfy90v+WkYhzFg1GGiizQv742FDU8EK+ZFwRwU
         vfGTaQ7N0pXROHAxr6tk9DokTsKmKfe1AQ8N86r+BqVYtjAC2Gtzli84MJerVNK2z188
         EBaQWSa+L2Dp9j/wtYynGlH/igpaNvLsz7UviGOx9PDXXU3IblAnGvrUmlr7IYjXhR9O
         P91Fwx4+QnSkrZeNQIXzDa/cwZaDOYB/XdM/pdVfwu8y36kr+LbfT0iQGnEcKivrpxaw
         odaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036359; x=1710641159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1/umpZGVsczLzrKS1GZCeAFysDY04buU8ZoM+JBKw=;
        b=JAamKyslxk/e0zruLNJUizcud0e/vMSQ3NMG/Nw3AqyVe/0kja3BWp7cAiYMseTSbg
         eRdEjI1kP+4wMjbmgWvHR2LugbdduHda+v7ZE8vdvJDEIK7KFrTgQVIq6gdUTR1nahUQ
         tSW3zoCF615+K/kSvwg6DW1uRZFOjW8blj9Mfq0ZvU92eA44owk2Yj701uQW6H9A4aOB
         Q20I9ZRd9vJG0PaZJ4kT1AP1N3ReTBuuJR33gqYFzqk2YkrtGkqgEPoHr8y/T8p+9cLu
         o0YunYdwhyejOnp/b9K9WeBg+J1lb1Y3Y1W2KZVNtU1Y9YuFXWJPbdTfS00xx72aOfWV
         JbHw==
X-Forwarded-Encrypted: i=1; AJvYcCVvz3QXSrmICoPoSHieLqek+Fd1i2Ysfsph+RqCvoNWs7fbjZ5ULF3V1Yb4oOhMMkOlGKtq61jQujxfz/YyWzc45HnQw/kc3aKNMg==
X-Gm-Message-State: AOJu0YytfBoDoL4dI4EDHM0ckgdo4PBqYKj00Rg9v1C4povA9xLx7rs3
	HLzw3YmO8HSh+tqn6TX6fXSjKWw2+gcNJbAoNUBf4QYs3IYAEshmQo0kiMvQiLqGM8LVT9i2dem
	BbyIPuQ==
X-Google-Smtp-Source: AGHT+IFPbWB3/192KGdZtIg9F9X7CoqlPRJZXE+414zWtjFld4XzM0pldNt12CDgHpD/F24xaEQHAI0MEqre
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1820:b0:dc2:5456:d9ac with SMTP
 id cf32-20020a056902182000b00dc25456d9acmr147760ybb.5.1710036359574; Sat, 09
 Mar 2024 18:05:59 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:06 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 11/13] tools headers: Sync linux/overflow.h
From: Ian Rogers <irogers@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Bring in the changes:

26dd68d293fd overflow: add DEFINE_FLEX() for on-stack allocs
d67790ddf021 overflow: Add struct_size_t() helper
4b21d25bf519 overflow: Introduce overflows_type() and castable_to_type()
31970608a6d3 overflow: Fix kern-doc markup for functions
d219d2a9a92e overflow: Allow mixed type arguments
92d23c6e9415 overflow, tracing: Define the is_signed_type() macro once
230f6fa2c1db overflow: Provide constant expression struct_size
e1be43d9b5d0 overflow: Implement size_t saturating arithmetic helpers

Add file to check-headers.sh, so there is a warning if the tools
version of the file drifts from the kernel's version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/overflow.h | 331 ++++++++++++++++++++++++++-------
 tools/perf/check-headers.sh    |   1 +
 2 files changed, 268 insertions(+), 64 deletions(-)

diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
index dcb0c1bf6866..7b5cf4a5cd19 100644
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -3,6 +3,8 @@
 #define __LINUX_OVERFLOW_H
 
 #include <linux/compiler.h>
+#include <linux/limits.h>
+#include <linux/const.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -28,117 +30,318 @@
  * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
  * credit to Christian Biere.
  */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
 
 /*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
- */
-#define check_add_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-})
+ * Avoids triggering -Wtype-limits compilation warning,
+ * while using unsigned data types to check a < 0.
+ */
+#define is_non_negative(a) ((a) > 0 || (a) == 0)
+#define is_negative(a) (!(is_non_negative(a)))
 
-#define check_sub_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-})
+/*
+ * Allows for effectively applying __must_check to a macro so we can have
+ * both the type-agnostic benefits of the macros while also being able to
+ * enforce that the return value is, in fact, checked.
+ */
+static inline bool __must_check __must_check_overflow(bool overflow)
+{
+	return unlikely(overflow);
+}
+
+/**
+ * check_add_overflow() - Calculate addition with overflow checking
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
+ */
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
+
+/**
+ * check_sub_overflow() - Calculate subtraction with overflow checking
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
+
+/**
+ * check_mul_overflow() - Calculate multiplication with overflow checking
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
+
+/**
+ * check_shl_overflow() - Calculate a left-shifted value and check overflow
+ * @a: Value to be shifted
+ * @s: How many bits left to shift
+ * @d: Pointer to where to store the result
+ *
+ * Computes *@d = (@a << @s)
+ *
+ * Returns true if '*@d' cannot hold the result or when '@a << @s' doesn't
+ * make sense. Example conditions:
+ *
+ * - '@a << @s' causes bits to be lost when stored in *@d.
+ * - '@s' is garbage (e.g. negative) or so large that the result of
+ *   '@a << @s' is guaranteed to be 0.
+ * - '@a' is negative.
+ * - '@a << @s' sets the sign bit, if any, in '*@d'.
+ *
+ * '*@d' will hold the results of the attempted shift, but is not
+ * considered "safe for use" if true is returned.
+ */
+#define check_shl_overflow(a, s, d) __must_check_overflow(({		\
+	typeof(a) _a = a;						\
+	typeof(s) _s = s;						\
+	typeof(d) _d = d;						\
+	u64 _a_full = _a;						\
+	unsigned int _to_shift =					\
+		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
+	*_d = (_a_full << _to_shift);					\
+	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
+	(*_d >> _to_shift) != _a);					\
+}))
 
-#define check_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
+#define __overflows_type_constexpr(x, T) (			\
+	is_unsigned_type(typeof(x)) ?				\
+		(x) > type_max(typeof(T)) :			\
+	is_unsigned_type(typeof(T)) ?				\
+		(x) < 0 || (x) > type_max(typeof(T)) :		\
+	(x) < type_min(typeof(T)) || (x) > type_max(typeof(T)))
+
+#define __overflows_type(x, T)		({	\
+	typeof(T) v = 0;			\
+	check_add_overflow((x), v, &v);		\
 })
 
 /**
- * array_size() - Calculate size of 2-dimensional array.
+ * overflows_type - helper for checking the overflows between value, variables,
+ *		    or data type
  *
- * @a: dimension one
- * @b: dimension two
+ * @n: source constant value or variable to be checked
+ * @T: destination variable or data type proposed to store @x
  *
- * Calculates size of 2-dimensional array: @a * @b.
+ * Compares the @x expression for whether or not it can safely fit in
+ * the storage of the type in @T. @x and @T can have different types.
+ * If @x is a constant expression, this will also resolve to a constant
+ * expression.
  *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: true if overflow can occur, false otherwise.
+ */
+#define overflows_type(n, T)					\
+	__builtin_choose_expr(__is_constexpr(n),		\
+			      __overflows_type_constexpr(n, T),	\
+			      __overflows_type(n, T))
+
+/**
+ * castable_to_type - like __same_type(), but also allows for casted literals
+ *
+ * @n: variable or constant value
+ * @T: variable or data type
+ *
+ * Unlike the __same_type() macro, this allows a constant value as the
+ * first argument. If this value would not overflow into an assignment
+ * of the second argument's type, it returns true. Otherwise, this falls
+ * back to __same_type().
  */
-static inline __must_check size_t array_size(size_t a, size_t b)
+#define castable_to_type(n, T)						\
+	__builtin_choose_expr(__is_constexpr(n),			\
+			      !__overflows_type_constexpr(n, T),	\
+			      __same_type(n, T))
+
+/**
+ * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
+ * @factor1: first factor
+ * @factor2: second factor
+ *
+ * Returns: calculate @factor1 * @factor2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
+	if (check_mul_overflow(factor1, factor2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * array3_size() - Calculate size of 3-dimensional array.
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
+ * @addend1: first addend
+ * @addend2: second addend
  *
- * @a: dimension one
- * @b: dimension two
- * @c: dimension three
- *
- * Calculates size of 3-dimensional array: @a * @b * @c.
- *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: calculate @addend1 + @addend2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
+static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_mul_overflow(bytes, c, &bytes))
+	if (check_add_overflow(addend1, addend2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
-static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
+/**
+ * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
+ * @minuend: value to subtract from
+ * @subtrahend: value to subtract from @minuend
+ *
+ * Returns: calculate @minuend - @subtrahend, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. For
+ * composition with the size_add() and size_mul() helpers, neither
+ * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
+ * The lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(n, size, &bytes))
-		return SIZE_MAX;
-	if (check_add_overflow(bytes, c, &bytes))
+	if (minuend == SIZE_MAX || subtrahend == SIZE_MAX ||
+	    check_sub_overflow(minuend, subtrahend, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * struct_size() - Calculate size of structure with trailing array.
+ * array_size() - Calculate size of 2-dimensional array.
+ * @a: dimension one
+ * @b: dimension two
+ *
+ * Calculates size of 2-dimensional array: @a * @b.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array_size(a, b)	size_mul(a, b)
+
+/**
+ * array3_size() - Calculate size of 3-dimensional array.
+ * @a: dimension one
+ * @b: dimension two
+ * @c: dimension three
+ *
+ * Calculates size of 3-dimensional array: @a * @b * @c.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
+
+/**
+ * flex_array_size() - Calculate size of a flexible array member
+ *                     within an enclosing structure.
  * @p: Pointer to the structure.
+ * @member: Name of the flexible array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of a flexible array of @count number of @member
+ * elements, at the end of structure @p.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define flex_array_size(p, member, count)				\
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
+
+/**
+ * struct_size() - Calculate size of structure with trailing flexible array.
+ * @p: Pointer to the structure.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure of @p followed by an
+ * array of @count number of @member elements.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size(p, member, count)					\
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
+
+/**
+ * struct_size_t() - Calculate size of structure with trailing flexible array
+ * @type: structure type name.
  * @member: Name of the array member.
- * @n: Number of elements in the array.
+ * @count: Number of elements in the array.
  *
- * Calculates size of memory needed for structure @p followed by an
- * array of @n @member elements.
+ * Calculates size of memory needed for structure @type followed by an
+ * array of @count number of @member elements. Prefer using struct_size()
+ * when possible instead, to keep calculations associated with a specific
+ * instance variable of type @type.
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define struct_size(p, member, n)					\
-	__ab_c_size(n,							\
-		    sizeof(*(p)->member) + __must_be_array((p)->member),\
-		    sizeof(*(p)))
+#define struct_size_t(type, member, count)					\
+	struct_size((type *)NULL, member, count)
+
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: initializer expression (could be empty for no init).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer)			\
+	_Static_assert(__builtin_constant_p(count),				\
+		       "onstack flex array members require compile-time const count"); \
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u initializer;							\
+	type *name = (type *)&name##_u
+
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @type structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@name) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(type, name, member, count)			\
+	_DEFINE_FLEX(type, name, member, count, = {})
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 64dbf199dff9..272a37d8e1c4 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -35,6 +35,7 @@ FILES=(
   "include/vdso/const.h"
   "include/linux/hash.h"
   "include/linux/list-sort.h"
+  "include/linux/overflow.h"
   "include/uapi/linux/hw_breakpoint.h"
   "arch/x86/include/asm/disabled-features.h"
   "arch/x86/include/asm/required-features.h"
-- 
2.44.0.278.ge034bb2e1d-goog


