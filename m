Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBB475997
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhLON1u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:27:50 -0500
Received: from foss.arm.com ([217.140.110.172]:51922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237399AbhLON1u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:27:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEAE9ED1;
        Wed, 15 Dec 2021 05:27:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF9E3F774;
        Wed, 15 Dec 2021 05:27:45 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:27:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/43] kmsan: introduce __no_sanitize_memory and
 __no_kmsan_checks
Message-ID: <YbntTqLtBUU4hGYG@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-10-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-10-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:16PM +0100, Alexander Potapenko wrote:
> __no_sanitize_memory is a function attribute that instructs KMSAN to
> skip a function during instrumentation. This is needed to e.g. implement
> the noinstr functions.
> 
> __no_kmsan_checks is a function attribute that makes KMSAN
> ignore the uninitialized values coming from the function's
> inputs, and initialize the function's outputs.
> 
> Functions marked with this attribute can't be inlined into functions
> not marked with it, and vice versa.

Just to check, I assume an unmarked __always_inline() function can be inlined
into a marked function? Otherwise this is going to be really painful to manage
for low-level helper functions.

Thanks,
Mark.

> 
> __SANITIZE_MEMORY__ is a macro that's defined iff the file is
> instrumented with KMSAN. This is not the same as CONFIG_KMSAN, which is
> defined for every file.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/I004ff0360c918d3cd8b18767ddd1381c6d3281be
> ---
>  include/linux/compiler-clang.h | 23 +++++++++++++++++++++++
>  include/linux/compiler-gcc.h   |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 3c4de9b6c6e3e..5f11a6f269e28 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -51,6 +51,29 @@
>  #define __no_sanitize_undefined
>  #endif
>  
> +#if __has_feature(memory_sanitizer)
> +#define __SANITIZE_MEMORY__
> +/*
> + * Unlike other sanitizers, KMSAN still inserts code into functions marked with
> + * no_sanitize("kernel-memory"). Using disable_sanitizer_instrumentation
> + * provides the behavior consistent with other __no_sanitize_ attributes,
> + * guaranteeing that __no_sanitize_memory functions remain uninstrumented.
> + */
> +#define __no_sanitize_memory __disable_sanitizer_instrumentation
> +
> +/*
> + * The __no_kmsan_checks attribute ensures that a function does not produce
> + * false positive reports by:
> + *  - initializing all local variables and memory stores in this function;
> + *  - skipping all shadow checks;
> + *  - passing initialized arguments to this function's callees.
> + */
> +#define __no_kmsan_checks __attribute__((no_sanitize("kernel-memory")))
> +#else
> +#define __no_sanitize_memory
> +#define __no_kmsan_checks
> +#endif
> +
>  /*
>   * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
>   * with no_sanitize("coverage"). Prior versions of Clang support coverage
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index ccbbd31b3aae5..f6e69387aad05 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -129,6 +129,12 @@
>  #define __SANITIZE_ADDRESS__
>  #endif
>  
> +/*
> + * GCC does not support KMSAN.
> + */
> +#define __no_sanitize_memory
> +#define __no_kmsan_checks
> +
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
