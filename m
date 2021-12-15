Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64114759E8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbhLONt1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:49:27 -0500
Received: from foss.arm.com ([217.140.110.172]:52482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhLONtY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:49:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFEE13A1;
        Wed, 15 Dec 2021 05:49:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481863F774;
        Wed, 15 Dec 2021 05:49:19 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:49:16 +0000
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
Subject: Re: [PATCH 21/43] kmsan: mark noinstr as __no_sanitize_memory
Message-ID: <YbnyXFWXfi1lTPHq@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-22-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-22-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:28PM +0100, Alexander Potapenko wrote:
> noinstr functions should never be instrumented, so make KMSAN skip them
> by applying the __no_sanitize_memory attribute.

To make this easier to review, it would be nice if this patch were moved
earlier, grouped with patches:

* 7: "compiler_attributes.h: add __disable_sanitizer_instrumentation"
* 9: "kmsan: introduce __no_sanitize_memory and __no_kmsan_checks"

... since that way a reviewer will spot them all in one go, rather than having
to jump around the series, and then any later patch in the series can rely on
all of these attributes, including `noinstr`.

Mark.

> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
> ---
>  include/linux/compiler_types.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 1d32f4c03c9ef..37b82564e93e5 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,7 +210,8 @@ struct ftrace_likely_data {
>  /* Section for code which can't be instrumented at all */
>  #define noinstr								\
>  	noinline notrace __attribute((__section__(".noinstr.text")))	\
> -	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> +	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> +	__no_sanitize_memory
>  
>  #endif /* __KERNEL__ */
>  
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
