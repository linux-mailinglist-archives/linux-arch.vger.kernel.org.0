Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF84EBD0D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiC3JBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiC3JBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 05:01:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01D64EC;
        Wed, 30 Mar 2022 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rrlsacueYKCfzaUaloBnav4G/jBuo1DGcsGefNV2qt0=; b=NfqWE2Z5UXlCJ89Ijz/iWnWo9f
        7Da3DL2TfLBAAhz0L4j9t/f7uqaL+IiQaeEIBKdEKBomlnah3r91Y02aA5An7+SF33uJ/llUlS/wp
        2TCIiM8ohNNfgVpnQTbc7WHgjBmEBTTb8IivVqTbtF4ubq6Kjo8rYKTdul2EwbKRXNhQpQ8jQJEu1
        3ZMR4+zvlkP4jSwsfMyFFtwhcUS0N5V7wjXwinGW5Wsyc93PsIPuXq+gYMd7rhHvB6vI9i2WgBQ4c
        UzN4pKPL9neldfp/W3UyqyE26IMVDvE4qHSFrL3QJNVKznq1/gnPqBeycX437rFDztAtSNtvRkMVh
        mr0yGnPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZU9s-0015Xh-Of; Wed, 30 Mar 2022 08:58:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52200986215; Wed, 30 Mar 2022 10:58:26 +0200 (CEST)
Date:   Wed, 30 Mar 2022 10:58:26 +0200
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
Message-ID: <20220330085826.GI8939@worktop.programming.kicks-ass.net>
References: <20220329124017.737571-1-glider@google.com>
 <20220329124017.737571-14-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329124017.737571-14-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 29, 2022 at 02:39:42PM +0200, Alexander Potapenko wrote:
> +/* Handle llvm.memmove intrinsic. */
> +void *__msan_memmove(void *dst, const void *src, uintptr_t n)
> +{
> +	void *result;
> +
> +	result = __memmove(dst, src, n);
> +	if (!n)
> +		/* Some people call memmove() with zero length. */
> +		return result;
> +	if (!kmsan_enabled || kmsan_in_runtime())
> +		return result;
> +
> +	kmsan_internal_memmove_metadata(dst, (void *)src, n);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(__msan_memmove);
> +
> +/* Handle llvm.memcpy intrinsic. */
> +void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
> +{
> +	void *result;
> +
> +	result = __memcpy(dst, src, n);
> +	if (!n)
> +		/* Some people call memcpy() with zero length. */
> +		return result;
> +
> +	if (!kmsan_enabled || kmsan_in_runtime())
> +		return result;
> +
> +	/* Using memmove instead of memcpy doesn't affect correctness. */
> +	kmsan_internal_memmove_metadata(dst, (void *)src, n);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(__msan_memcpy);
> +
> +/* Handle llvm.memset intrinsic. */
> +void *__msan_memset(void *dst, int c, uintptr_t n)
> +{
> +	void *result;
> +
> +	result = __memset(dst, c, n);
> +	if (!kmsan_enabled || kmsan_in_runtime())
> +		return result;
> +
> +	kmsan_enter_runtime();
> +	/*
> +	 * Clang doesn't pass parameter metadata here, so it is impossible to
> +	 * use shadow of @c to set up the shadow for @dst.
> +	 */
> +	kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
> +	kmsan_leave_runtime();
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(__msan_memset);

This, we need this same for KASAN. KASAN must be changed to have the
mem*() intrinsics emit __asan_mem*(), such that we can have
uninstrumented base functions.

Currently we seem to have the problem that when a noinstr function trips
one of those instrinsics it'll emit a call to an instrumented function,
which is a complete no-no.

Also see:

  https://lore.kernel.org/all/YjxTt3pFIcV3lt8I@zn.tnic/T/#m2049a14be400d4ae2b54a1f7da3ede28b7fd7564

Given the helpful feedback there, Mark and me are going to unilaterally
break Kasan by deleting the existing wrappers.
