Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414F68826D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjBBPb0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjBBPbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D076A1;
        Thu,  2 Feb 2023 07:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VyG6+KQHCAeEAEZCgwKflnVjYNYIFWnZVnfAizA2/bE=; b=joKm4qjSNFbo4hFpEXGNuPRr+M
        x6C5AUB7KuB7mYmWZ8TfjRhnW9H0blPwPiJnykDLW6v51sQfgfyaxBFX3KpHYtJrLS8sqTxZIuCXw
        qdjov4449SEqRvitwAf8Sd7TSv329PRG4oug2ZxlILrwyM0Jh4AqX1+EVIl2yr9QKd5UpOgx7dTyq
        lgK0tlJ3jkAs/BdwoWpjxH873GJEWPzTbwwJfM0ow40bR8Qfwr4+gbXL9vpVs1ZAenAWLuoq5aGdx
        lVVWKHojJbD5Z11OlT50xTw1DOeEcnjjGX6jZgdN/9qHW9cfJnjUj0kA9GbtgZNG4bs5rEzayP5TR
        ZJ0qDe3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbVT-005CFe-1p;
        Thu, 02 Feb 2023 15:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03242300E3F;
        Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8DFE523F31FBA; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.433050731@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 04/10] instrumentation: Wire up cmpxchg128()
References: <20230202145030.223740842@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire up the cmpxchg128 familty in the atomic wrappery scripts.

These provide the generic cmpxchg128 family of functions from the
arch_ prefixed version, adding explicit instrumentation where needed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic/atomic-arch-fallback.h |   95 +++++++++++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  |   77 ++++++++++++++++++++++
 scripts/atomic/gen-atomic-fallback.sh       |    4 -
 scripts/atomic/gen-atomic-instrumented.sh   |    4 -
 4 files changed, 174 insertions(+), 6 deletions(-)

--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -77,6 +77,29 @@
 
 #endif /* arch_cmpxchg64_relaxed */
 
+#ifndef arch_cmpxchg128_relaxed
+#define arch_cmpxchg128_acquire arch_cmpxchg128
+#define arch_cmpxchg128_release arch_cmpxchg128
+#define arch_cmpxchg128_relaxed arch_cmpxchg128
+#else /* arch_cmpxchg128_relaxed */
+
+#ifndef arch_cmpxchg128_acquire
+#define arch_cmpxchg128_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg128_release
+#define arch_cmpxchg128_release(...) \
+	__atomic_op_release(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg128
+#define arch_cmpxchg128(...) \
+	__atomic_op_fence(arch_cmpxchg128, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg128_relaxed */
+
 #ifndef arch_try_cmpxchg_relaxed
 #ifdef arch_try_cmpxchg
 #define arch_try_cmpxchg_acquire arch_try_cmpxchg
@@ -217,6 +240,76 @@
 
 #endif /* arch_try_cmpxchg64_relaxed */
 
+#ifndef arch_try_cmpxchg128_relaxed
+#ifdef arch_try_cmpxchg128
+#define arch_try_cmpxchg128_acquire arch_try_cmpxchg128
+#define arch_try_cmpxchg128_release arch_try_cmpxchg128
+#define arch_try_cmpxchg128_relaxed arch_try_cmpxchg128
+#endif /* arch_try_cmpxchg128 */
+
+#ifndef arch_try_cmpxchg128
+#define arch_try_cmpxchg128(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128 */
+
+#ifndef arch_try_cmpxchg128_acquire
+#define arch_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_acquire */
+
+#ifndef arch_try_cmpxchg128_release
+#define arch_try_cmpxchg128_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_release */
+
+#ifndef arch_try_cmpxchg128_relaxed
+#define arch_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg128_relaxed */
+
+#else /* arch_try_cmpxchg128_relaxed */
+
+#ifndef arch_try_cmpxchg128_acquire
+#define arch_try_cmpxchg128_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg128_release
+#define arch_try_cmpxchg128_release(...) \
+	__atomic_op_release(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg128
+#define arch_try_cmpxchg128(...) \
+	__atomic_op_fence(arch_try_cmpxchg128, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg128_relaxed */
+
 #ifndef arch_atomic_read_acquire
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
@@ -2456,4 +2549,4 @@ arch_atomic64_dec_if_positive(atomic64_t
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// b5e87bdd5ede61470c29f7a7e4de781af3770f09
+// 46357a526de89c762d30fb238f35a7d5950a670b
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1968,6 +1968,36 @@ atomic_long_dec_if_positive(atomic_long_
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
+#define cmpxchg128(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_mb(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_acquire(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_release(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_release(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg128_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+
 #define try_cmpxchg(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2044,6 +2074,44 @@ atomic_long_dec_if_positive(atomic_long_
 	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define try_cmpxchg128(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_mb(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_release(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg128_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg128_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2058,6 +2126,13 @@ atomic_long_dec_if_positive(atomic_long_
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
+#define cmpxchg128_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
+})
+
 #define sync_cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2083,4 +2158,4 @@ atomic_long_dec_if_positive(atomic_long_
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 764f741eb77a7ad565dc8d99ce2837d5542e8aee
+// 27320c1ec2bf2878ecb9df3ea4816a7bc0c57a52
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -217,11 +217,11 @@ cat << EOF
 
 EOF
 
-for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
+for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64" "arch_cmpxchg128"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
-for cmpxchg in "cmpxchg" "cmpxchg64"; do
+for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 	gen_try_cmpxchg_fallbacks "${cmpxchg}"
 done
 
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -166,14 +166,14 @@ grep '^[a-z]' "$1" | while read name met
 done
 
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}" "${order}" ""
 		printf "\n"
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg"; do
 	gen_xchg "${xchg}" "" ""
 	printf "\n"
 done


