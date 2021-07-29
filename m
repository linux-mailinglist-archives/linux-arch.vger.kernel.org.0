Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44E3D9BE6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 04:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhG2ClG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 22:41:06 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40474 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231370AbhG2ClF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 22:41:05 -0400
Received: from localhost.localdomain (unknown [121.228.27.69])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj0ArFQJhr6glAA--.25353S2;
        Thu, 29 Jul 2021 10:40:48 +0800 (CST)
From:   Rui Wang <wangrui@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Wang <wangrui@loongson.cn>, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH v2] locking/atomic: Implement atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
Date:   Thu, 29 Jul 2021 10:40:29 +0800
Message-Id: <20210729024029.910-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxj0ArFQJhr6glAA--.25353S2
X-Coremail-Antispam: 1UD129KBjvAXoWfAFy8AF1kXr48GrWDAw1DWrg_yoW8Zw43Wo
        Z3KFW5tr4Iqry7W395KFyIqr4DXF1jqayrGry0vrsYvF9rZanYqwnrGr1jyr1xX34kAr4k
        Wr4ftw13trWqqwn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch introduce a new atomic primitive andnot_or:

 * atomic_andnot_or
 * atomic_fetch_andnot_or
 * atomic_fetch_andnot_or_relaxed
 * atomic_fetch_andnot_or_acquire
 * atomic_fetch_andnot_or_release
 * atomic64_andnot_or
 * atomic64_fetch_andnot_or
 * atomic64_fetch_andnot_or_relaxed
 * atomic64_fetch_andnot_or_acquire
 * atomic64_fetch_andnot_or_release
 * atomic_long_andnot_or
 * atomic_long_fetch_andnot_or
 * atomic_long_fetch_andnot_or_relaxed
 * atomic_long_fetch_andnot_or_acquire
 * atomic_long_fetch_andnot_or_release

Signed-off-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: hev <r@hev.cc>
---
 include/asm-generic/atomic-instrumented.h |  72 +++++-
 include/asm-generic/atomic-long.h         |  62 ++++-
 include/linux/atomic-arch-fallback.h      | 262 +++++++++++++++++++++-
 lib/atomic64_test.c                       |  92 ++++----
 scripts/atomic/atomics.tbl                |   1 +
 scripts/atomic/fallbacks/andnot_or        |  24 ++
 6 files changed, 470 insertions(+), 43 deletions(-)
 create mode 100755 scripts/atomic/fallbacks/andnot_or

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index bc45af52c93b..8f5efade88b7 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -599,6 +599,41 @@ atomic_dec_if_positive(atomic_t *v)
 	return arch_atomic_dec_if_positive(v);
 }
 
+static __always_inline void
+atomic_andnot_or(int m, int o, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_andnot_or(m, o, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_or(int m, int o, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_or(m, o, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_or_acquire(int m, int o, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_or_acquire(m, o, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_or_release(int m, int o, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_or_release(m, o, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_or_relaxed(int m, int o, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_or_relaxed(m, o, v);
+}
+
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
@@ -1177,6 +1212,41 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
+static __always_inline void
+atomic64_andnot_or(s64 m, s64 o, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_andnot_or(m, o, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_or(s64 m, s64 o, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_or(m, o, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_or_acquire(s64 m, s64 o, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_or_acquire(m, o, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_or_release(s64 m, s64 o, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_or_release(m, o, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_or_relaxed(s64 m, s64 o, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_or_relaxed(m, o, v);
+}
+
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1334,4 +1404,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
+// 9c9792d0dcd1fb3de8eeda1225ebbd0d811fb941
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index 073cf40f431b..0c61626b42d2 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -515,6 +515,36 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	return atomic64_dec_if_positive(v);
 }
 
+static __always_inline void
+atomic_long_andnot_or(long m, long o, atomic_long_t *v)
+{
+	atomic64_andnot_or(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or(long m, long o, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_or(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_acquire(long m, long o, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_or_acquire(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_release(long m, long o, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_or_release(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_relaxed(long m, long o, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_or_relaxed(m, o, v);
+}
+
 #else /* CONFIG_64BIT */
 
 static __always_inline long
@@ -1009,6 +1039,36 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	return atomic_dec_if_positive(v);
 }
 
+static __always_inline void
+atomic_long_andnot_or(long m, long o, atomic_long_t *v)
+{
+	atomic_andnot_or(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or(long m, long o, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_or(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_acquire(long m, long o, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_or_acquire(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_release(long m, long o, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_or_release(m, o, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_or_relaxed(long m, long o, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_or_relaxed(m, o, v);
+}
+
 #endif /* CONFIG_64BIT */
 #endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// a624200981f552b2c6be4f32fe44da8289f30d87
+// 3ab842342b36b655b902481be793ba7a04c5a88d
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
index a3dba31df01e..580d48c42597 100644
--- a/include/linux/atomic-arch-fallback.h
+++ b/include/linux/atomic-arch-fallback.h
@@ -1250,6 +1250,136 @@ arch_atomic_dec_if_positive(atomic_t *v)
 #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 #endif
 
+#ifndef arch_atomic_andnot_or
+static __always_inline void
+arch_atomic_andnot_or(int m, int o, atomic_t *v)
+{
+	({
+		int N, O = arch_atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic_try_cmpxchg_relaxed(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic_andnot_or arch_atomic_andnot_or
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or_relaxed
+#ifdef arch_atomic_fetch_andnot_or
+#define arch_atomic_fetch_andnot_or_acquire arch_atomic_fetch_andnot_or
+#define arch_atomic_fetch_andnot_or_release arch_atomic_fetch_andnot_or
+#define arch_atomic_fetch_andnot_or_relaxed arch_atomic_fetch_andnot_or
+#endif /* arch_atomic_fetch_andnot_or */
+
+#ifndef arch_atomic_fetch_andnot_or
+static __always_inline int
+arch_atomic_fetch_andnot_or(int m, int o, atomic_t *v)
+{
+	return ({
+		int N, O = arch_atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic_try_cmpxchg(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic_fetch_andnot_or arch_atomic_fetch_andnot_or
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_or_acquire(int m, int o, atomic_t *v)
+{
+	return ({
+		int N, O = arch_atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic_try_cmpxchg_acquire(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic_fetch_andnot_or_acquire arch_atomic_fetch_andnot_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or_release
+static __always_inline int
+arch_atomic_fetch_andnot_or_release(int m, int o, atomic_t *v)
+{
+	return ({
+		int N, O = arch_atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic_try_cmpxchg_release(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic_fetch_andnot_or_release arch_atomic_fetch_andnot_or_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or_relaxed
+static __always_inline int
+arch_atomic_fetch_andnot_or_relaxed(int m, int o, atomic_t *v)
+{
+	return ({
+		int N, O = arch_atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic_try_cmpxchg_relaxed(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic_fetch_andnot_or_relaxed arch_atomic_fetch_andnot_or_relaxed
+#endif
+
+#else /* arch_atomic_fetch_andnot_or_relaxed */
+
+#ifndef arch_atomic_fetch_andnot_or_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_or_acquire(int m, int o, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_or_relaxed(m, o, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_or_acquire arch_atomic_fetch_andnot_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or_release
+static __always_inline int
+arch_atomic_fetch_andnot_or_release(int m, int o, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_or_relaxed(m, o, v);
+}
+#define arch_atomic_fetch_andnot_or_release arch_atomic_fetch_andnot_or_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_or
+static __always_inline int
+arch_atomic_fetch_andnot_or(int m, int o, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_andnot_or_relaxed(m, o, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_or arch_atomic_fetch_andnot_or
+#endif
+
+#endif /* arch_atomic_fetch_andnot_or_relaxed */
+
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -2357,5 +2487,135 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 #endif
 
+#ifndef arch_atomic64_andnot_or
+static __always_inline void
+arch_atomic64_andnot_or(s64 m, s64 o, atomic64_t *v)
+{
+	({
+		s64 N, O = arch_atomic64_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic64_try_cmpxchg_relaxed(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic64_andnot_or arch_atomic64_andnot_or
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or_relaxed
+#ifdef arch_atomic64_fetch_andnot_or
+#define arch_atomic64_fetch_andnot_or_acquire arch_atomic64_fetch_andnot_or
+#define arch_atomic64_fetch_andnot_or_release arch_atomic64_fetch_andnot_or
+#define arch_atomic64_fetch_andnot_or_relaxed arch_atomic64_fetch_andnot_or
+#endif /* arch_atomic64_fetch_andnot_or */
+
+#ifndef arch_atomic64_fetch_andnot_or
+static __always_inline s64
+arch_atomic64_fetch_andnot_or(s64 m, s64 o, atomic64_t *v)
+{
+	return ({
+		s64 N, O = arch_atomic64_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic64_try_cmpxchg(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic64_fetch_andnot_or arch_atomic64_fetch_andnot_or
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_or_acquire(s64 m, s64 o, atomic64_t *v)
+{
+	return ({
+		s64 N, O = arch_atomic64_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic64_try_cmpxchg_acquire(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic64_fetch_andnot_or_acquire arch_atomic64_fetch_andnot_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_or_release(s64 m, s64 o, atomic64_t *v)
+{
+	return ({
+		s64 N, O = arch_atomic64_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic64_try_cmpxchg_release(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic64_fetch_andnot_or_release arch_atomic64_fetch_andnot_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or_relaxed
+static __always_inline s64
+arch_atomic64_fetch_andnot_or_relaxed(s64 m, s64 o, atomic64_t *v)
+{
+	return ({
+		s64 N, O = arch_atomic64_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_atomic64_try_cmpxchg_relaxed(v, &O, N));
+		O;
+	});
+}
+#define arch_atomic64_fetch_andnot_or_relaxed arch_atomic64_fetch_andnot_or_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_andnot_or_relaxed */
+
+#ifndef arch_atomic64_fetch_andnot_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_or_acquire(s64 m, s64 o, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_andnot_or_relaxed(m, o, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_or_acquire arch_atomic64_fetch_andnot_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_or_release(s64 m, s64 o, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_or_relaxed(m, o, v);
+}
+#define arch_atomic64_fetch_andnot_or_release arch_atomic64_fetch_andnot_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_or
+static __always_inline s64
+arch_atomic64_fetch_andnot_or(s64 m, s64 o, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_or_relaxed(m, o, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_or arch_atomic64_fetch_andnot_or
+#endif
+
+#endif /* arch_atomic64_fetch_andnot_or_relaxed */
+
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
+// 709f9a3b37c43051cce565fa3c78002ee8b83766
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..fedc83118a29 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -17,12 +17,18 @@
 #include <asm/cpufeature.h>	/* for boot_cpu_has below */
 #endif
 
-#define TEST(bit, op, c_op, val)				\
+#define COP(c_op1, c_op2, val1, val2...)			\
+do {								\
+	(void)(r c_op1 val1);					\
+	(void)(r c_op2 val2);					\
+} while (0)
+
+#define TEST(bit, op, c_op1, c_op2, args...)			\
 do {								\
 	atomic##bit##_set(&v, v0);				\
 	r = v0;							\
-	atomic##bit##_##op(val, &v);				\
-	r c_op val;						\
+	atomic##bit##_##op(args, &v);				\
+	COP(c_op1, c_op2, args);				\
 	WARN(atomic##bit##_read(&v) != r, "%Lx != %Lx\n",	\
 		(unsigned long long)atomic##bit##_read(&v),	\
 		(unsigned long long)r);				\
@@ -50,12 +56,12 @@ do {								\
 	BUG_ON(atomic##bit##_read(&v) != r);			\
 } while (0)
 
-#define TEST_FETCH(bit, op, c_op, val)				\
+#define TEST_FETCH(bit, op, c_op1, c_op2, args...)		\
 do {								\
 	atomic##bit##_set(&v, v0);				\
 	r = v0;							\
-	r c_op val;						\
-	BUG_ON(atomic##bit##_##op(val, &v) != v0);		\
+	COP(c_op1, c_op2, args);				\
+	BUG_ON(atomic##bit##_##op(args, &v) != v0);		\
 	BUG_ON(atomic##bit##_read(&v) != r);			\
 } while (0)
 
@@ -64,9 +70,9 @@ do {								\
 	FAMILY_TEST(TEST_RETURN, bit, op, c_op, val);		\
 } while (0)
 
-#define FETCH_FAMILY_TEST(bit, op, c_op, val)			\
+#define FETCH_FAMILY_TEST(bit, op, args...)			\
 do {								\
-	FAMILY_TEST(TEST_FETCH, bit, op, c_op, val);		\
+	FAMILY_TEST(TEST_FETCH, bit, op, args);			\
 } while (0)
 
 #define TEST_ARGS(bit, op, init, ret, expect, args...)		\
@@ -105,35 +111,38 @@ static __init void test_atomic(void)
 {
 	int v0 = 0xaaa31337;
 	int v1 = 0xdeadbeef;
+	int mask = 0x0000ffff;
 	int onestwos = 0x11112222;
 	int one = 1;
 
 	atomic_t v;
 	int r;
 
-	TEST(, add, +=, onestwos);
-	TEST(, add, +=, -one);
-	TEST(, sub, -=, onestwos);
-	TEST(, sub, -=, -one);
-	TEST(, or, |=, v1);
-	TEST(, and, &=, v1);
-	TEST(, xor, ^=, v1);
-	TEST(, andnot, &= ~, v1);
+	TEST(, add, +=, , onestwos);
+	TEST(, add, +=, , -one);
+	TEST(, sub, -=, , onestwos);
+	TEST(, sub, -=, , -one);
+	TEST(, or, |=, , v1);
+	TEST(, and, &=, , v1);
+	TEST(, xor, ^=, , v1);
+	TEST(, andnot, &= ~, , v1);
+	TEST(, andnot_or, &= ~, |=, mask, one);
 
 	RETURN_FAMILY_TEST(, add_return, +=, onestwos);
 	RETURN_FAMILY_TEST(, add_return, +=, -one);
 	RETURN_FAMILY_TEST(, sub_return, -=, onestwos);
 	RETURN_FAMILY_TEST(, sub_return, -=, -one);
 
-	FETCH_FAMILY_TEST(, fetch_add, +=, onestwos);
-	FETCH_FAMILY_TEST(, fetch_add, +=, -one);
-	FETCH_FAMILY_TEST(, fetch_sub, -=, onestwos);
-	FETCH_FAMILY_TEST(, fetch_sub, -=, -one);
+	FETCH_FAMILY_TEST(, fetch_add, +=, , onestwos);
+	FETCH_FAMILY_TEST(, fetch_add, +=, , -one);
+	FETCH_FAMILY_TEST(, fetch_sub, -=, , onestwos);
+	FETCH_FAMILY_TEST(, fetch_sub, -=, , -one);
 
-	FETCH_FAMILY_TEST(, fetch_or,  |=, v1);
-	FETCH_FAMILY_TEST(, fetch_and, &=, v1);
-	FETCH_FAMILY_TEST(, fetch_andnot, &= ~, v1);
-	FETCH_FAMILY_TEST(, fetch_xor, ^=, v1);
+	FETCH_FAMILY_TEST(, fetch_or,  |=, , v1);
+	FETCH_FAMILY_TEST(, fetch_and, &=, , v1);
+	FETCH_FAMILY_TEST(, fetch_andnot, &= ~, , v1);
+	FETCH_FAMILY_TEST(, fetch_xor, ^=, , v1);
+	FETCH_FAMILY_TEST(, fetch_andnot_or, &= ~, |=, mask, one);
 
 	INC_RETURN_FAMILY_TEST(, v0);
 	DEC_RETURN_FAMILY_TEST(, v0);
@@ -150,6 +159,7 @@ static __init void test_atomic64(void)
 	long long v1 = 0xdeadbeefdeafcafeLL;
 	long long v2 = 0xfaceabadf00df001LL;
 	long long v3 = 0x8000000000000000LL;
+	long long mask = 0x00000000ffffffffLL;
 	long long onestwos = 0x1111111122222222LL;
 	long long one = 1LL;
 	int r_int;
@@ -163,29 +173,31 @@ static __init void test_atomic64(void)
 	BUG_ON(v.counter != r);
 	BUG_ON(atomic64_read(&v) != r);
 
-	TEST(64, add, +=, onestwos);
-	TEST(64, add, +=, -one);
-	TEST(64, sub, -=, onestwos);
-	TEST(64, sub, -=, -one);
-	TEST(64, or, |=, v1);
-	TEST(64, and, &=, v1);
-	TEST(64, xor, ^=, v1);
-	TEST(64, andnot, &= ~, v1);
+	TEST(64, add, +=, , onestwos);
+	TEST(64, add, +=, , -one);
+	TEST(64, sub, -=, , onestwos);
+	TEST(64, sub, -=, , -one);
+	TEST(64, or, |=, , v1);
+	TEST(64, and, &=, , v1);
+	TEST(64, xor, ^=, , v1);
+	TEST(64, andnot, &= ~, , v1);
+	TEST(64, andnot_or, &= ~, |=, mask, one);
 
 	RETURN_FAMILY_TEST(64, add_return, +=, onestwos);
 	RETURN_FAMILY_TEST(64, add_return, +=, -one);
 	RETURN_FAMILY_TEST(64, sub_return, -=, onestwos);
 	RETURN_FAMILY_TEST(64, sub_return, -=, -one);
 
-	FETCH_FAMILY_TEST(64, fetch_add, +=, onestwos);
-	FETCH_FAMILY_TEST(64, fetch_add, +=, -one);
-	FETCH_FAMILY_TEST(64, fetch_sub, -=, onestwos);
-	FETCH_FAMILY_TEST(64, fetch_sub, -=, -one);
+	FETCH_FAMILY_TEST(64, fetch_add, +=, , onestwos);
+	FETCH_FAMILY_TEST(64, fetch_add, +=, , -one);
+	FETCH_FAMILY_TEST(64, fetch_sub, -=, , onestwos);
+	FETCH_FAMILY_TEST(64, fetch_sub, -=, , -one);
 
-	FETCH_FAMILY_TEST(64, fetch_or,  |=, v1);
-	FETCH_FAMILY_TEST(64, fetch_and, &=, v1);
-	FETCH_FAMILY_TEST(64, fetch_andnot, &= ~, v1);
-	FETCH_FAMILY_TEST(64, fetch_xor, ^=, v1);
+	FETCH_FAMILY_TEST(64, fetch_or,  |=, , v1);
+	FETCH_FAMILY_TEST(64, fetch_and, &=, , v1);
+	FETCH_FAMILY_TEST(64, fetch_andnot, &= ~, , v1);
+	FETCH_FAMILY_TEST(64, fetch_xor, ^=, , v1);
+	FETCH_FAMILY_TEST(64, fetch_andnot_or, &= ~, |=, mask, one);
 
 	INIT(v0);
 	atomic64_inc(&v);
diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
index fbee2f6190d9..db6fe1dfcdb4 100755
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -39,3 +39,4 @@ inc_not_zero		b	v
 inc_unless_negative	b	v
 dec_unless_positive	b	v
 dec_if_positive		i	v
+andnot_or		vF	i:m	i:o	v
diff --git a/scripts/atomic/fallbacks/andnot_or b/scripts/atomic/fallbacks/andnot_or
new file mode 100755
index 000000000000..7ca5e5fd0772
--- /dev/null
+++ b/scripts/atomic/fallbacks/andnot_or
@@ -0,0 +1,24 @@
+local try_order=${order}
+
+#
+# non-value returning atomics are implicity relaxed
+#
+if [ -z "${retstmt}" ]; then
+	try_order="_relaxed"
+fi
+
+cat <<EOF
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}andnot_or${sfx}${order}(${int} m, ${int} o, ${atomic}_t *v)
+{
+	${retstmt}({
+		${int} N, O = ${arch}${atomic}_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!${arch}${atomic}_try_cmpxchg${try_order}(v, &O, N));
+		O;
+	});
+}
+EOF
-- 
2.32.0

