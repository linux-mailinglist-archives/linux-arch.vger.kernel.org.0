Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4D47484B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhLNQiK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLNQiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:38:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4EC061574;
        Tue, 14 Dec 2021 08:38:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1865D612FF;
        Tue, 14 Dec 2021 16:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD433C34601;
        Tue, 14 Dec 2021 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639499888;
        bh=BiOMJrBttOea17b5tIemSIlhVRlcynMIgkPFw/EBLG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpl6WsS8qRHuu0xvc94JKoBsVUJ/sRhEXhvI9ommwHFg5ZE+JUxmCsFoHeriM9935
         bH7nngLxCbp4L5npi5XlQ4X4JriozG2I9tkMbv9OCEmmh+Ve0dO81T9g3vmvG4VPUW
         XLOIv18Lg5j3RfsoRPecTywT66FEUkKAW9gUbTPw=
Date:   Tue, 14 Dec 2021 17:38:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH 41/43] security: kmsan: fix interoperability with
 auto-initialization
Message-ID: <YbjIbpFRqMac/X8s@kroah.com>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-42-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-42-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:48PM +0100, Alexander Potapenko wrote:
> Heap and stack initialization is great, but not when we are trying
> uses of uninitialized memory. When the kernel is built with KMSAN,
> having kernel memory initialization enabled may introduce false
> negatives.
> 
> We disable CONFIG_INIT_STACK_ALL_PATTERN and CONFIG_INIT_STACK_ALL_ZERO
> under CONFIG_KMSAN, making it impossible to auto-initialize stack
> variables in KMSAN builds. We also disable CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> and CONFIG_INIT_ON_FREE_DEFAULT_ON to prevent accidental use of heap
> auto-initialization.
> 
> We however still let the users enable heap auto-initialization at
> boot-time (by setting init_on_alloc=1 or init_on_free=1), in which case
> a warning is printed.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/I86608dd867018683a14ae1870f1928ad925f42e9
> ---
>  mm/page_alloc.c            | 4 ++++
>  security/Kconfig.hardening | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fa8029b714a81..4218dea0c76a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -855,6 +855,10 @@ void init_mem_debugging_and_hardening(void)
>  	else
>  		static_branch_disable(&init_on_free);
>  
> +	if (IS_ENABLED(CONFIG_KMSAN) &&
> +	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
> +		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  	if (!debug_pagealloc_enabled())
>  		return;
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index d051f8ceefddd..bd13a46024457 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -106,6 +106,7 @@ choice
>  	config INIT_STACK_ALL_PATTERN
>  		bool "pattern-init everything (strongest)"
>  		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
> +		depends on !KMSAN
>  		help
>  		  Initializes everything on the stack (including padding)
>  		  with a specific debug value. This is intended to eliminate
> @@ -124,6 +125,7 @@ choice
>  	config INIT_STACK_ALL_ZERO
>  		bool "zero-init everything (strongest and safest)"
>  		depends on CC_HAS_AUTO_VAR_INIT_ZERO
> +		depends on !KMSAN

So this means KMSAN is a developer debugging feature only and should
never be turned on on a real device/server that has users?

thanks,

greg k-h
