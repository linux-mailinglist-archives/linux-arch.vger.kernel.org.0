Return-Path: <linux-arch+bounces-2919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7B87751D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4552C2807DD
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C83A8CD;
	Sun, 10 Mar 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hV39oof8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599674694
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036369; cv=none; b=dqNFRPt63tHL/+fqXnn8ameldbKPMZljN3VF/OG8jja0IldSHpjFkSHOyGzd218foOOpPq9VVnWGQq7I9X9FfvyRJTbgBD5UXJbkM8S/E96oB+EflK/n2uCygdUOE4dQ8Wt0cItM+WsCpgxpHwN69iAPpU+FoLHGHdqhHfqp0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036369; c=relaxed/simple;
	bh=qvu80I2tuIwczv3ewDN5Kf8bkfHfC9IP72lON4Zzmek=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=GuxDwtFN9NgHkoWsxAYJ45ltx9xA4KfmRcWlrtQPGljpt8qVBez6KRWrXBXh5OMBEsu3AY5D7vRsysXclpLwRkZ9+D796PF3I+ntkW5jYRKA+AinNYoJBxeNHtE00XziOrqOCaAKvAZvvzrv17Avf0pZiUDl4+q/4dpUAuAYLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hV39oof8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so6232147276.1
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036365; x=1710641165; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2TI3BR52BOETJMkXQVYiCvqxjFYb61EnnuV6r2EGgU=;
        b=hV39oof8n6gQYhpoRdQBNKXrF9luve4Gjjy1Iibfj18oWaFulJIcW/K0a+36t6prcz
         c2TirRz8836CT+nuHJYaKfcP8O3elPqWrHmJdhPhrYbIebqJVgH2tC4zE2I3VeLdlg23
         ihbhVIuMkt4Fo+motqOpBgLeIqMlgh6bVwkPGzIwr78rsxBOM839rKLVNIweb/bB37oC
         bee/hJw0Psd6q4+giekuPYhNzCCyOGVouxE66vuCTKa3h+WcMmDafItdyLDBzhIC+mvw
         yus2gBGtfrawoxBl/bS0bvetjFoluac4zdUvlbymAVId8gCuS3ZZ+LOeQ0GGcBYxc1wG
         mt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036365; x=1710641165;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2TI3BR52BOETJMkXQVYiCvqxjFYb61EnnuV6r2EGgU=;
        b=jElUWO++kKJKxmGNZ0UsYZdkzlDG1PG9w14kZPVpRowFeWSBdIcSzU3qvTx3PesmMW
         nzZhZT13FtxmBjriLbtHPz9Ndenjbkj2eBWes1CfoLL68SBQ+kxc1Z/ElSdWldF6k2Px
         eS+fKAmEwit3g6IeU43Rv6Q8vG/DyUkNrTWzu8HEuS2nosG6Hy1s8fLH6wlMsmvgEHTc
         GAHecw5Q/eBOvndc9kAk/dudf0Qfa7urjDkpEdUDlPG81tWZbC2xVUwqlXXTuXeqpTJJ
         8Yloi3itCt8tsUkp9ZFzXJYgFjz1qGeJrQdV1DyXoXrFmUe/IvpkEaSoEb4tbpq76TqQ
         i9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX6K++waPnXKPA7bKcCVTuglwZvXsPOzIMKOGTRYSSfrRc8R0Oum8hCp0KKB+P4h+NO9S+IHY/toN2fegsdICmPS0KASHx4oenOBA==
X-Gm-Message-State: AOJu0Yy26NxK0IbPzFFd7mOzO7ZNmKm3yaMya3GVKfAggkZaTlSaLR2D
	wtC7q8giTvtXX/+raKORhziUn+5Q+p3RUKna7ISVVq+lup+dU8gynWSCm+pS/aA4FdjN0yhDED6
	fXnU0sw==
X-Google-Smtp-Source: AGHT+IHg84e8jFIAgnoZrRiN8Pu+L19uE2B6rig+tSx4eREFwobOlwuHge4FvzAmOSQKYE9pLZGbcXyYmOgE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c9:b0:dc6:fec4:1c26 with SMTP
 id ck9-20020a05690218c900b00dc6fec41c26mr897542ybb.1.1710036365375; Sat, 09
 Mar 2024 18:06:05 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:08 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
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
Cc: Christopher Di Bella <cjdb@google.com>
Content-Type: text/plain; charset="UTF-8"

An issue was reported with clang and llvm libc where the noinline
attribute [1] was being expanded due to the #define in
linux/compiler.h (now in compiler_attributes.h). The expansion caused
the __attribute__ to appear twice and break the build. To avoid this
conflict, rename noinline to __noinline which is more consistent with
other compiler attributes.

[1] https://clang.llvm.org/docs/AttributeReference.html#noinline
Reported-by: Christopher Di Bella <cjdb@google.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler_attributes.h |  4 ++--
 tools/perf/arch/x86/tests/bp-modify.c     |  4 ++--
 tools/perf/bench/find-bit-bench.c         |  2 +-
 tools/perf/tests/bp_account.c             |  2 +-
 tools/perf/tests/bp_signal.c              |  2 +-
 tools/perf/tests/bp_signal_overflow.c     |  2 +-
 tools/perf/tests/dwarf-unwind.c           | 12 ++++++------
 tools/perf/tests/workloads/leafloop.c     |  8 ++++----
 tools/perf/tests/workloads/thloop.c       |  4 ++--
 9 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/compiler_attributes.h b/tools/include/linux/compiler_attributes.h
index 9bfaec783e48..1ff3d85f5af3 100644
--- a/tools/include/linux/compiler_attributes.h
+++ b/tools/include/linux/compiler_attributes.h
@@ -267,12 +267,12 @@
 # define __flatten			__attribute__((flatten))
 
 /*
- * Note the missing underscores.
+ * Note, the kernel version is missing the underscores.
  *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noinline-function-attribute
  * clang: mentioned
  */
-#define   noinline                      __attribute__((__noinline__))
+#define   __noinline                      __attribute__((__noinline__))
 
 /*
  * Optional: only supported since gcc >= 8
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index 0924ccd9e36d..65493ff7a76f 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -15,13 +15,13 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-static noinline int bp_1(void)
+static __noinline int bp_1(void)
 {
 	pr_debug("in %s\n", __func__);
 	return 0;
 }
 
-static noinline int bp_2(void)
+static __noinline int bp_2(void)
 {
 	pr_debug("in %s\n", __func__);
 	return 0;
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..dd97a51649bc 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -31,7 +31,7 @@ static const char *const bench_usage[] = {
 static unsigned int accumulator;
 static unsigned int use_of_val;
 
-static noinline void workload(int val)
+static __noinline void workload(int val)
 {
 	use_of_val += val;
 	accumulator++;
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 6f921db33cf9..459f61752a71 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -34,7 +34,7 @@
 
 static volatile long the_var;
 
-static noinline int test_function(void)
+static __noinline int test_function(void)
 {
 	return 0;
 }
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 1f2908f02389..484a7e7f96ee 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -59,7 +59,7 @@ static void __test_function(volatile long *ptr)
 }
 #endif
 
-static noinline int test_function(void)
+static __noinline int test_function(void)
 {
 	__test_function(&the_var);
 	the_var++;
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 4e897c2cf26b..9436bf2973f8 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -30,7 +30,7 @@
 
 static int overflows;
 
-static noinline int test_function(void)
+static __noinline int test_function(void)
 {
 	return time(NULL);
 }
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index d01aa931fe81..a669c69a9242 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -109,7 +109,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	return strcmp((const char *) symbol, funcs[idx]);
 }
 
-NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
@@ -140,7 +140,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thr
 
 static int global_unwind_retval = -INT_MAX;
 
-NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
+NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 {
 	/* Any possible value should be 'thread' */
 	struct thread *thread = *(struct thread **)p1;
@@ -159,7 +159,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p
 	return p1 - p2;
 }
 
-NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 {
 	struct thread *array[2] = {thread, thread};
 	void *fp = &bsearch;
@@ -178,7 +178,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *th
 	return global_unwind_retval;
 }
 
-NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_2(struct thread *thread)
 {
 	int ret;
 
@@ -187,7 +187,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *th
 	return ret;
 }
 
-NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_1(struct thread *thread)
 {
 	int ret;
 
@@ -196,7 +196,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 	return ret;
 }
 
-noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
+__noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 				int subtest __maybe_unused)
 {
 	struct machine *machine;
diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
index 1bf5cc97649b..89d2cec2f461 100644
--- a/tools/perf/tests/workloads/leafloop.c
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -4,18 +4,18 @@
 #include "../tests.h"
 
 /* We want to check these symbols in perf script */
-noinline void leaf(volatile int b);
-noinline void parent(volatile int b);
+__noinline void leaf(volatile int b);
+__noinline void parent(volatile int b);
 
 static volatile int a;
 
-noinline void leaf(volatile int b)
+__noinline void leaf(volatile int b)
 {
 	for (;;)
 		a += b;
 }
 
-noinline void parent(volatile int b)
+__noinline void parent(volatile int b)
 {
 	leaf(b);
 }
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 457b29f91c3e..e252efb76203 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -9,14 +9,14 @@
 static volatile sig_atomic_t done;
 
 /* We want to check this symbol in perf report */
-noinline void test_loop(void);
+__noinline void test_loop(void);
 
 static void sighandler(int sig __maybe_unused)
 {
 	done = 1;
 }
 
-noinline void test_loop(void)
+__noinline void test_loop(void)
 {
 	while (!done);
 }
-- 
2.44.0.278.ge034bb2e1d-goog


