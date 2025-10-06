Return-Path: <linux-arch+bounces-13926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B9BBDD3C
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2B144E0312
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1D265CCD;
	Mon,  6 Oct 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTSvBZNx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489C223339;
	Mon,  6 Oct 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748870; cv=none; b=VQmiY9O2nZc9T1rSZsYrym+ycivsICCB1nfX7w6QjEHbifb8rIY/kUdlnPQSzXWF+SvOUcrEXEptg2U/cAMSZMjiYf/AptTvSbIEom23Okif96LIItVfIWSAM+6jRVi7PTxSY9kucwj1fFeeSxqTzfMfrg4Yp+oOQ1GpygCDQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748870; c=relaxed/simple;
	bh=H/JV3keURjBYWjBPl+P5pFvTDDpr2Zqj0n/evlTqhZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c1DVCRet5674WZIhh1kCGmWKd8q9TsomBc5jDRkcYkT5pfRKzFPFEmYp4qEumRXHTNS60OzMlAgXC3feDMJMBON9VvK8dhDhqAhln7QHF5eM8N+trrrgccDC6x2OJA+D9QCAYP7RLnUW4qqO35q44GPjsuxeHKhZ/Vl3MwWJx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTSvBZNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD8AC4CEF5;
	Mon,  6 Oct 2025 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748870;
	bh=H/JV3keURjBYWjBPl+P5pFvTDDpr2Zqj0n/evlTqhZg=;
	h=From:To:Cc:Subject:Date:From;
	b=bTSvBZNxrDEHRl923Elq+0kwdFS8sNKO6Uaa+ZaSwDpY0eAy2fh/0xSHYSonXwVHi
	 4C1rJIEyb4selbzZe6m6spkGS0OwNxwVAf4ra2PuQH4xs/ufrPqxJ5TggwJCL3H8hf
	 wverrlc7LX5kramgFCZj/KpAWEY5A8j2u9A+j4U8UgQQsuMSYVonbiC/5LNZvrBiSn
	 JhHP6Wgfr1a8G53YsVNJiM/VmwryqdbIQTQ0jAekdTaxe/F1iSZbsg5Dsn/rgJDfFG
	 /Jwnofo4Tn7oybqve5U4Zj6PuLCwO8offhpB+TylknkBIzH8jI9wZ5op/HLp9Z7npV
	 fWJ7kx86cxMBw==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-m68k@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Finn Thain <fthain@linux-m68k.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atomic: skip alignment check for try_cmpxchg() old arg
Date: Mon,  6 Oct 2025 13:07:32 +0200
Message-Id: <20251006110740.468309-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'old' argument in atomic_try_cmpxchg() and related functions is a
pointer to a normal non-atomic integer number, which does not require
to be naturally aligned, unlike the atomic_t/atomic64_t types themselves.

In order to add an alignment check with CONFIG_DEBUG_ATOMIC into the
normal instrument_atomic_read_write() helper, change this check to use
the non-atomic instrument_read_write(), the same way that was done
earlier for try_cmpxchg() in commit ec570320b09f ("locking/atomic:
Correct (cmp)xchg() instrumentation").

This prevents warnings on m68k calling the 32-bit atomic_try_cmpxchg()
with 16-bit aligned arguments as well as several more architectures
including x86-32 when calling atomic64_try_cmpxchg() with 32-bit
aligned u64 arguments.

Reported-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/all/cover.1757810729.git.fthain@linux-m68k.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/atomic/atomic-instrumented.h | 26 +++++++++++-----------
 scripts/atomic/gen-atomic-instrumented.sh  | 11 +++++----
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 9409a6ddf3e0..37ab6314a9f7 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg(v, old, new);
 }
 
@@ -1298,7 +1298,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1321,7 +1321,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
 
@@ -1343,7 +1343,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -2854,7 +2854,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg(v, old, new);
 }
 
@@ -2876,7 +2876,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -2899,7 +2899,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
 
@@ -2921,7 +2921,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -4432,7 +4432,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
 
@@ -4454,7 +4454,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -4477,7 +4477,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
@@ -4499,7 +4499,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -5050,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 8829b337928e9508259079d32581775ececd415b
+// f618ac667f868941a84ce0ab2242f1786e049ed4
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 592f3ec89b5f..9c1d53f81eb2 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -12,7 +12,7 @@ gen_param_check()
 	local arg="$1"; shift
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
-	local rw="write"
+	local rw="atomic_write"
 
 	case "${type#c}" in
 	i) return;;
@@ -20,14 +20,17 @@ gen_param_check()
 
 	if [ ${type#c} != ${type} ]; then
 		# We don't write to constant parameters.
-		rw="read"
+		rw="atomic_read"
+	elif [ "${type}" = "p" ] ; then
+		# The "old" argument in try_cmpxchg() gets accessed non-atomically
+		rw="read_write"
 	elif [ "${meta}" != "s" ]; then
 		# An atomic RMW: if this parameter is not a constant, and this atomic is
 		# not just a 's'tore, this parameter is both read from and written to.
-		rw="read_write"
+		rw="atomic_read_write"
 	fi
 
-	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tinstrument_${rw}(${name}, sizeof(*${name}));\n"
 }
 
 #gen_params_checks(meta, arg...)
-- 
2.39.5


