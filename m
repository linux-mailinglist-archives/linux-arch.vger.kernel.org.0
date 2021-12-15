Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6A4759B9
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbhLONdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:33:55 -0500
Received: from foss.arm.com ([217.140.110.172]:52094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242909AbhLONdy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:33:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4B9D106F;
        Wed, 15 Dec 2021 05:33:53 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D833F774;
        Wed, 15 Dec 2021 05:33:49 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:33:46 +0000
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
Subject: Re: [PATCH 12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
Message-ID: <Ybnuup0eMnhrwp8e@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-13-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-13-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:19PM +0100, Alexander Potapenko wrote:
> kcov used to be broken prior to Clang 11, but right now that version is
> already the minimum required to build with KCSAN, that is why we don't
> need KCSAN_KCOV_BROKEN anymore.

Just to check, how is that requirement enforced?

I see the core Makefiles enforce 10.0.1+, but I couldn't spot an explicit
version dependency in Kconfig.kcsan.

Otherwise, this looks good to me!

Mark.

> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Ida287421577f37de337139b5b5b9e977e4a6fee2
> ---
>  lib/Kconfig.kcsan | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index e0a93ffdef30e..b81454b2a0d09 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -10,21 +10,10 @@ config HAVE_KCSAN_COMPILER
>  	  For the list of compilers that support KCSAN, please see
>  	  <file:Documentation/dev-tools/kcsan.rst>.
>  
> -config KCSAN_KCOV_BROKEN
> -	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> -	depends on CC_IS_CLANG
> -	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
> -	help
> -	  Some versions of clang support either KCSAN and KCOV but not the
> -	  combination of the two.
> -	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> -	  in newer releases.
> -
>  menuconfig KCSAN
>  	bool "KCSAN: dynamic data race detector"
>  	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
>  	depends on DEBUG_KERNEL && !KASAN
> -	depends on !KCSAN_KCOV_BROKEN
>  	select STACKTRACE
>  	help
>  	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
