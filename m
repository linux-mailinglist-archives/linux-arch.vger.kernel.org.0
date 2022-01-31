Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCA4A5394
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 00:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiAaXxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 18:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiAaXxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 18:53:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCBC06173D
        for <linux-arch@vger.kernel.org>; Mon, 31 Jan 2022 15:53:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s6so8396135plg.12
        for <linux-arch@vger.kernel.org>; Mon, 31 Jan 2022 15:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+X+AFGoIUnRael26zUdyQVS4Stq52MtE2VPdjxRCScg=;
        b=YW4/gspNKInMiiqNd58ZCH4h0W4EUl91RhRmEY/57BXNbZ/hMUAkcEwc7FoOjBI4Nt
         E45rvZBie5zy3Gz0IT/MtOePAEx+D4c06rSLJ0MR4nhBOzD0JqXtbe/3lYMrtOi4Ixjn
         OBYyuErvU48oU1yNCmORPoTqATZguV8v3Oeuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+X+AFGoIUnRael26zUdyQVS4Stq52MtE2VPdjxRCScg=;
        b=iGpc3bHAzdwyNxg1kVKvj1IxAxFV1Ja09qQvM2w8vrYgzyaOkNeBPbEI55x8jchh4C
         +BlyIv6FJCJSPno6Bov+ejivTCA7q6LYZeKfPOCdh2HtKU8D5xQzMd5iX1VgWpIsbVmF
         nSyLZGPfKOiXrKu6VdUymRwV8kjxg3PEHznEPt6T4OiT9pGUiERb+ts2okW581JkSjpG
         eWmoE3hqiGQyBXliExLnxF7kzgktY2i9RmmmrpFmdSZ/mrDmaBhA+1XQg3ws+ctY9Dq5
         a3+5uSBlh0WowF6jkgl78q+JLjC9fBsdJI1OQ4Uwa2aNlm0IdQOAPHk/ylK1bPlkGEwF
         ZhPg==
X-Gm-Message-State: AOAM532XkrhnC1PJC1EfN828vD4tK6nr3oB092sbgifsNNPiFS7sUzXR
        6mVYy+b80vl1lal8jCwteOcREg==
X-Google-Smtp-Source: ABdhPJwQoJTVTbWyz7yUWp71cBeTkkBUzx+D+EJf+jHOTWJCSO09eDNSyMoJg+E1UEDubWnSmjvFOg==
X-Received: by 2002:a17:902:d512:: with SMTP id b18mr24084400plg.24.1643673204493;
        Mon, 31 Jan 2022 15:53:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ha21sm392379pjb.48.2022.01.31.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:53:24 -0800 (PST)
Date:   Mon, 31 Jan 2022 15:53:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/memory-barriers.txt: volatile is not a barrier()
 substitute
Message-ID: <202201311550.31EF589B2@keescook>
References: <20220131225250.409564-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131225250.409564-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 02:52:47PM -0800, Nick Desaulniers wrote:
> Add text to memory-barriers.txt and deprecated.rst to denote that
> volatile-qualifying an asm statement is not a substitute for either a
> compiler barrier (``barrier();``) or a clobber list.
> 
> This way we can point to this in code that strengthens existing
> volatile-qualified asm statements to use a compiler barrier.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Example: https://godbolt.org/z/8PW549zz9
> 
>  Documentation/memory-barriers.txt    | 24 ++++++++++++++++++++++++
>  Documentation/process/deprecated.rst | 17 +++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..f3908c0812da 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1726,6 +1726,30 @@ of optimizations:
>       respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
>       though the CPU of course need not do so.
>  
> + (*) Similarly, the compiler is within its rights to reorder instructions
> +     around an asm statement so long as clobbers are not violated. For example,
> +
> +	asm volatile ("");
> +	flag = true;
> +
> +     May be modified by the compiler to:
> +
> +	flag = true;
> +	asm volatile ("");
> +
> +     Marking an asm statement as volatile is not a substitute for barrier(),
> +     and is implicit for asm goto statements and asm statements that do not
> +     have outputs (like the above example). Prefer either:
> +
> +	asm ("":::"memory");
> +	flag = true;
> +
> +     Or:
> +
> +	asm ("");
> +	barrier();
> +	flag = true;
> +

I like this!

>   (*) The compiler is within its rights to invent stores to a variable,
>       as in the following example:
>  
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 388cb19f5dbb..432816e2f79e 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -329,3 +329,20 @@ struct_size() and flex_array_size() helpers::
>          instance->count = count;
>  
>          memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> +
> +Volatile Qualified asm Statements
> +=================================

I would open with an example, like:

Instead of::

	volatile asm("...");

just use::

	asm("...");


> +
> +According to `the GCC docs on inline asm
> +https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
> +
> +  asm statements that have no output operands and asm goto statements,
> +  are implicitly volatile.

Does this mean "volatile" _is_ needed when there are operands, etc?

> +
> +For many uses of asm statements, that means adding a volatile qualifier won't
> +hurt (making the implicit explicit), but it will not strengthen the semantics
> +for such cases where it would have been implied. Care should be taken not to
> +confuse ``volatile`` with the kernel's ``barrier()`` macro or an explicit
> +clobber list. See [memory-barriers]_ for more info on ``barrier()``.
> +
> +.. [memory-barriers] Documentation/memory-barriers.txt
> -- 
> 2.35.0.rc2.247.g8bbb082509-goog
> 

-- 
Kees Cook
