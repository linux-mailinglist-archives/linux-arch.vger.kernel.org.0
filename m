Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE85733B7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jul 2022 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiGMKE4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jul 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGMKE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2022 06:04:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC928D2148
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 03:04:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so902751wmc.3
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f6Y9qjwogxCtal7OxlGnHDAF4wB3anj4wqmO3ly+ml0=;
        b=he3+yyZi6Tsrcv7LH0IV7Ke1Rsii76jKm9NNxzRjpskQ6BJuY6vU4yOQTSEts/c11L
         djSaAdwjki0dcFTLJh+YzipCWg4yVHQU3VlTKfFaB9iq77W3kRpG91Ed74Q8nYfad4VR
         izYayhzzyj1J7Juuf1UWdOh1+9NNA9HTztb9LkL2b/UKb4qEksvXWffDeZNa4OV4BYv2
         uqbIuHe184MFeTmBmGHh1zB2RsJDoCQhrwonLCtAB8CFMh/CrqaGMDZoMrGbsE/vMB5E
         vbjhht34Ff64Ouirs+J801C6TEtd+J/hdGatsmmUlrhZeW813xb/9+vlIFxclfXi4TKb
         n8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f6Y9qjwogxCtal7OxlGnHDAF4wB3anj4wqmO3ly+ml0=;
        b=xz0Yk2+j0YUCkNJLZS/g2rlyEYdwmdK8scroty4gaoPP3+t0cfh7ZSdqB0JHgGC246
         Ypi2SzFYWFl135pTdEA1cynrzgEVG/qD7RLzE/kbufJR/h1YWh0N1NrOpZOaLH6gVwu0
         UOiGFY+tRmZ3R5015E9si/r1GJAqREKqenfWLnuetTCEaIb28ShTGccTaqTAxzvnXtP1
         bWeNO7PVbvpM5Hy5uvhaDn2mVlP2QTN+Flq/YvHgzzvYs73NIhVYoxWseG9N5XY6PUP1
         s+9UqMnt66yzNe3dIV5jGL0mFaqf2teG2LNm4gIFF3WBLYV1meszRZtrspGnTbto0UW2
         ddlw==
X-Gm-Message-State: AJIora9RiX/uMgStOZ80eHnFFlGG8QUhiVXmG9dRIcBfCY57znu/outL
        DD2Rlr68v7uxtM8BzX3sdPPC6g==
X-Google-Smtp-Source: AGRyM1t4kKJQ4vgidG20/yf+55cwZ/s8XmwO5zrExibZnNYkLFCJUhP6tqcV1d66FnnJvjA9dY3kiA==
X-Received: by 2002:a1c:1902:0:b0:3a2:ee85:3934 with SMTP id 2-20020a1c1902000000b003a2ee853934mr7963222wmz.31.1657706693167;
        Wed, 13 Jul 2022 03:04:53 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:63e6:a6c0:5e2a:ac17])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003a2e2ba94ecsm1640729wmq.40.2022.07.13.03.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:04:52 -0700 (PDT)
Date:   Wed, 13 Jul 2022 12:04:46 +0200
From:   Marco Elver <elver@google.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/45] kmsan: add KMSAN runtime core
Message-ID: <Ys6YvvARDX6pWmWv@elver.google.com>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-12-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701142310.2188015-12-glider@google.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 01, 2022 at 04:22PM +0200, 'Alexander Potapenko' via kasan-dev wrote:
[...]
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2e24db4bff192..59819e6fa5865 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -963,6 +963,7 @@ config DEBUG_STACKOVERFLOW
>  
>  source "lib/Kconfig.kasan"
>  source "lib/Kconfig.kfence"
> +source "lib/Kconfig.kmsan"
>  
>  endmenu # "Memory Debugging"
>  
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> new file mode 100644
> index 0000000000000..8f768d4034e3c
> --- /dev/null
> +++ b/lib/Kconfig.kmsan
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HAVE_ARCH_KMSAN
> +	bool
> +
> +config HAVE_KMSAN_COMPILER
> +	# Clang versions <14.0.0 also support -fsanitize=kernel-memory, but not
> +	# all the features necessary to build the kernel with KMSAN.
> +	depends on CC_IS_CLANG && CLANG_VERSION >= 140000
> +	def_bool $(cc-option,-fsanitize=kernel-memory -mllvm -msan-disable-checks=1)
> +
> +config HAVE_KMSAN_PARAM_RETVAL
> +	# Separate check for -fsanitize-memory-param-retval support.

This comment doesn't add much value, maybe instead say that "Supported
only by Clang >= 15."

> +	depends on CC_IS_CLANG && CLANG_VERSION >= 140000

Why not just "depends on HAVE_KMSAN_COMPILER"? (All
fsanitize-memory-param-retval supporting compilers must also be KMSAN
compilers.)

> +	def_bool $(cc-option,-fsanitize=kernel-memory -fsanitize-memory-param-retval)
> +
> +

HAVE_KMSAN_PARAM_RETVAL should be moved under "if KMSAN" so that this
isn't unnecessarily evaluated in every kernel build (saving 1 shelling
out to clang in most builds).

> +config KMSAN
> +	bool "KMSAN: detector of uninitialized values use"
> +	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> +	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +	select STACKDEPOT
> +	select STACKDEPOT_ALWAYS_INIT
> +	help
> +	  KernelMemorySanitizer (KMSAN) is a dynamic detector of uses of
> +	  uninitialized values in the kernel. It is based on compiler
> +	  instrumentation provided by Clang and thus requires Clang to build.
> +
> +	  An important note is that KMSAN is not intended for production use,
> +	  because it drastically increases kernel memory footprint and slows
> +	  the whole system down.
> +
> +	  See <file:Documentation/dev-tools/kmsan.rst> for more details.
> +
> +if KMSAN
> +
> +config KMSAN_CHECK_PARAM_RETVAL
> +	bool "Check for uninitialized values passed to and returned from functions"
> +	default HAVE_KMSAN_PARAM_RETVAL

This can be enabled even if !HAVE_KMSAN_PARAM_RETVAL. Should this be:

	default y
	depends on HAVE_KMSAN_PARAM_RETVAL

instead?

> +	help
> +	  If the compiler supports -fsanitize-memory-param-retval, KMSAN will
> +	  eagerly check every function parameter passed by value and every
> +	  function return value.
> +
> +	  Disabling KMSAN_CHECK_PARAM_RETVAL will result in tracking shadow for
> +	  function parameters and return values across function borders. This
> +	  is a more relaxed mode, but it generates more instrumentation code and
> +	  may potentially report errors in corner cases when non-instrumented
> +	  functions call instrumented ones.
> +
