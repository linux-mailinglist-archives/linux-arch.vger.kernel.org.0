Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2593E4EBDE4
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiC3Jok (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiC3Jok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 05:44:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B15265EA9;
        Wed, 30 Mar 2022 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xboQMeJsqxqCS/mVv8ONF0Dx4kieBwqN3CccVGBtXx4=; b=WR7Y1eLIzpC3APxVKwuZB5YY5H
        heEqaN5gq7yJRZptgGTX7bVdhKspMHmi3yN4BqQGtlAyPwtKV6tMZFRP/FlbtteIDnWDMT2FGvI0m
        rzuKxY0gP26ut9x5C9F1DygZHaEDenytEItHumgfNN8F0bdgJNivDu7NHV+RnbqPBNo+K7vvahCZA
        +KSbmNeCisLVKGJ1G2NPEoLOTcUiJ5Y7g76A6nxVwzQUPff+uSa6PIkPG8V86Qnm+7UbQbO49izg1
        NyxdTe1AMcKGw/dFLm/IRZD+TopsPAQEwnC0X1ae/rX8FDI6GjBggYJNJhgN7mcbeASr6YwfOTQ75
        BR+dLA/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZUpz-006B9b-5Z; Wed, 30 Mar 2022 09:41:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C15CC986215; Wed, 30 Mar 2022 11:41:56 +0200 (CEST)
Date:   Wed, 30 Mar 2022 11:41:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryabinin.a.a@gmail.com
Subject: Re: [PATCH v2 13/48] kmsan: add KMSAN runtime core
Message-ID: <20220330094156.GG14330@worktop.programming.kicks-ass.net>
References: <20220329124017.737571-1-glider@google.com>
 <20220329124017.737571-14-glider@google.com>
 <20220330085826.GI8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330085826.GI8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 30, 2022 at 10:58:26AM +0200, Peter Zijlstra wrote:
> On Tue, Mar 29, 2022 at 02:39:42PM +0200, Alexander Potapenko wrote:
> > +/* Handle llvm.memmove intrinsic. */
> > +void *__msan_memmove(void *dst, const void *src, uintptr_t n)
> > +{
> > +	void *result;
> > +
> > +	result = __memmove(dst, src, n);
> > +	if (!n)
> > +		/* Some people call memmove() with zero length. */
> > +		return result;
> > +	if (!kmsan_enabled || kmsan_in_runtime())
> > +		return result;
> > +
> > +	kmsan_internal_memmove_metadata(dst, (void *)src, n);
> > +
> > +	return result;
> > +}
> > +EXPORT_SYMBOL(__msan_memmove);
> > +
> > +/* Handle llvm.memcpy intrinsic. */
> > +void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
> > +{
> > +	void *result;
> > +
> > +	result = __memcpy(dst, src, n);
> > +	if (!n)
> > +		/* Some people call memcpy() with zero length. */
> > +		return result;
> > +
> > +	if (!kmsan_enabled || kmsan_in_runtime())
> > +		return result;
> > +
> > +	/* Using memmove instead of memcpy doesn't affect correctness. */
> > +	kmsan_internal_memmove_metadata(dst, (void *)src, n);
> > +
> > +	return result;
> > +}
> > +EXPORT_SYMBOL(__msan_memcpy);
> > +
> > +/* Handle llvm.memset intrinsic. */
> > +void *__msan_memset(void *dst, int c, uintptr_t n)
> > +{
> > +	void *result;
> > +
> > +	result = __memset(dst, c, n);
> > +	if (!kmsan_enabled || kmsan_in_runtime())
> > +		return result;
> > +
> > +	kmsan_enter_runtime();
> > +	/*
> > +	 * Clang doesn't pass parameter metadata here, so it is impossible to
> > +	 * use shadow of @c to set up the shadow for @dst.
> > +	 */
> > +	kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
> > +	kmsan_leave_runtime();
> > +
> > +	return result;
> > +}
> > +EXPORT_SYMBOL(__msan_memset);
> 
> This, we need this same for KASAN. KASAN must be changed to have the
> mem*() intrinsics emit __asan_mem*(), such that we can have
> uninstrumented base functions.
> 
> Currently we seem to have the problem that when a noinstr function trips
> one of those instrinsics it'll emit a call to an instrumented function,
> which is a complete no-no.
> 
> Also see:
> 
>   https://lore.kernel.org/all/YjxTt3pFIcV3lt8I@zn.tnic/T/#m2049a14be400d4ae2b54a1f7da3ede28b7fd7564
> 
> Given the helpful feedback there, Mark and me are going to unilaterally
> break Kasan by deleting the existing wrappers.

specifically, I was thinking of something like the below...

(potentially more architectures are affected)

---
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 23048be0333b..909ffbce8438 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -149,6 +149,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_NOINSTR if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	# Some instrumentation may be unsound, hence EXPERT
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 4ab48d49c451..9f6ed674e420 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -242,12 +242,12 @@ SYM_FUNC_END(__pi_memcpy)
 
 SYM_FUNC_ALIAS(__memcpy, __pi_memcpy)
 EXPORT_SYMBOL(__memcpy)
-SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+SYM_FUNC_ALIAS(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_ALIAS(__pi_memmove, __pi_memcpy)
 
 SYM_FUNC_ALIAS(__memmove, __pi_memmove)
 EXPORT_SYMBOL(__memmove)
-SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+SYM_FUNC_ALIAS(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
index a5aebe82ad73..c41ae56ce6a8 100644
--- a/arch/arm64/lib/memset.S
+++ b/arch/arm64/lib/memset.S
@@ -206,5 +206,5 @@ SYM_FUNC_END(__pi_memset)
 SYM_FUNC_ALIAS(__memset, __pi_memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS_WEAK(memset, __pi_memset)
+SYM_FUNC_ALIAS(memset, __pi_memset)
 EXPORT_SYMBOL(memset)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7340d9f01b62..a89881ad0568 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -166,6 +166,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
+	select HAVE_ARCH_KASAN_NOINSTR		if X86_64
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad..d5e1a2d4a41a 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -42,7 +42,7 @@ SYM_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+SYM_FUNC_ALIAS(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 /*
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index d83cba364e31..a13711b645fb 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -208,5 +208,5 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+SYM_FUNC_ALIAS(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index fc9ffd3ff3b2..29299a926962 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -43,7 +43,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS_WEAK(memset, __memset)
+SYM_FUNC_ALIAS(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 /*
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 1f3e620188a2..7d4815bfa9ae 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
 config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+config HAVE_ARCH_KASAN_NOINSTR
+	bool
+
 config ARCH_DISABLE_KASAN_INLINE
 	bool
 	help
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index a4f07de21771..6fd542061625 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -38,6 +38,44 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
 }
 EXPORT_SYMBOL(__kasan_check_write);
 
+/*
+ * noinstr archs require uninstrumented base functions, as such their kasan
+ * implementation must use __asan_mem*() functions if they want
+ * instrumentation.
+ */
+#ifdef HAVE_ARCH_KASAN_NOINSTR
+
+void *__asan_memset(void *addr, int c, size_t len)
+{
+	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
+		return NULL;
+
+	return __memset(addr, c, len);
+}
+
+#ifdef __HAVE_ARCH_MEMMOVE
+#undef memmove
+void *__asan_memmove(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
+	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memmove(dest, src, len);
+}
+#endif
+
+#undef memcpy
+void *__asan_memcpy(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
+	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memcpy(dest, src, len);
+}
+#else
+
 #undef memset
 void *memset(void *addr, int c, size_t len)
 {
@@ -69,6 +107,8 @@ void *memcpy(void *dest, const void *src, size_t len)
 	return __memcpy(dest, src, len);
 }
 
+#endif
+
 void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
