Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3D475990
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhLONYN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:24:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237399AbhLONYN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:24:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E75D6E;
        Wed, 15 Dec 2021 05:24:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007803F774;
        Wed, 15 Dec 2021 05:24:07 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:24:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/43] compiler_attributes.h: add
 __disable_sanitizer_instrumentation
Message-ID: <YbnsdDUCwX+Mem0s@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-8-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-8-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:14PM +0100, Alexander Potapenko wrote:
> The new attribute maps to
> __attribute__((disable_sanitizer_instrumentation)), which will be
> supported by Clang >= 14.0. Future support in GCC is also possible.
> 
> This attribute disables compiler instrumentation for kernel sanitizer
> tools, making it easier to implement noinstr. It is different from the
> existing __no_sanitize* attributes, which may still allow certain types
> of instrumentation to prevent false positives.

When you say the __no_sanitize* attributes allow some instrumentation, does
that apply to any of the existing KASAN/KCSAN/KCOV support, or just for KMSAN?

The documentation just says the same as the commit message:

| This is not the same as __attribute__((no_sanitize(...))), which depending on
| the tool may still insert instrumentation to prevent false positive reports.

... which implies the other instrumentation might not be suprressed.

I ask because architectures which select ARCH_WANTS_NO_INSTR *need* to be able
to suppress all instrumentation. It's fine if that means they need a new
version of clang for KMSAN, but if there's latent instrumentation we have more
bugs to fix first...

Thanks,
Mark.

> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Ic0123ce99b33ab7d5ed1ae90593425be8d3d774a
> ---
>  include/linux/compiler_attributes.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index b9121afd87331..37e2600202216 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -308,6 +308,24 @@
>  # define __compiletime_warning(msg)
>  #endif
>  
> +/*
> + * Optional: only supported since clang >= 14.0
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#disable-sanitizer-instrumentation
> + *
> + * disable_sanitizer_instrumentation is not always similar to
> + * no_sanitize((<sanitizer-name>)): the latter may still let specific sanitizers
> + * insert code into functions to prevent false positives. Unlike that,
> + * disable_sanitizer_instrumentation prevents all kinds of instrumentation to
> + * functions with the attribute.
> + */
> +#if __has_attribute(disable_sanitizer_instrumentation)
> +# define __disable_sanitizer_instrumentation \
> +	 __attribute__((disable_sanitizer_instrumentation))
> +#else
> +# define __disable_sanitizer_instrumentation
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
