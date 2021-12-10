Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7646FED8
	for <lists+linux-arch@lfdr.de>; Fri, 10 Dec 2021 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhLJKnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Dec 2021 05:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbhLJKnL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2021 05:43:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C0C061746;
        Fri, 10 Dec 2021 02:39:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so28899406edu.4;
        Fri, 10 Dec 2021 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHe7vBh/4+X252aKIDIz4ef+vheyjuqk+KuJhJVZHao=;
        b=J3X6RW6y7qXI1bGRVlBZvUwsgI9Tnn9gedkSCxKZulMV3j3Bt7O/gwwQ4oqIvsRq9Q
         XK8UhqXLRWNA3kNEI/3nP4+p4Zg7KZ8id1UOGfgMV6O26USB8ely0d8CQy4vMYkfzpth
         aL4ped7g72nQWxCRcEnV4x5TXfRfyv7IeLSuI0EA8tHC5bLVNZ2wbUlBDm0K2n24U1H4
         z5ioud4aH+UmLI7an0Fukc6oHZlhKgMLJ1YdUUND55Th1OO4T9rkqi2LH0iSsOqzuwXy
         eyOwe25IFFtpJ969inWZ0zhe5K29B9FSkkg0Aap8751XSBLPfkwbAffYsqmKba5HvAct
         Y5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JHe7vBh/4+X252aKIDIz4ef+vheyjuqk+KuJhJVZHao=;
        b=pbFgyeXvFjulhldB6OBnlxSsp/waU+v9WthkFVxHm5Mx2KpF1NEAvmOQ9cyQGIT4qD
         tRnt/LEWmzLm0twLh6ha8xJpzJbATBWo5rGiqnYGzHc7i6RLqeW1pu3SAVEdUPVDMi2e
         +XCPrl6VmlShT23ENon1YYooN8oyZW6zMZHRTiEbDFmLr/hXxeCw0LPOAUFUgSLMH54q
         hfemje1TVkHaGICKH5eEPUqnORDOmvI6ESJ/VDGn+UHWY8gY2bmCEGxTz0+ZHfIZkPsM
         zPxEc1E1cYP4v6r6VbA5nODU3cWXBQ8op1pYP9TlxF83Fj/xbVzcZBIjwd0XeJYxjuv8
         YnMQ==
X-Gm-Message-State: AOAM531UKa8LwcLwZlOVsJA7Y2s2IF8xrwMXI2bJbQc9Zy36R3LcU/Rq
        /HzBe5g+SO9Jpgi+Y9Mg79M=
X-Google-Smtp-Source: ABdhPJyLQUaQ2hNX4CxG0irGqzhgvYGoOjfhZ8BHnmcbbhDaPjnTQI/G8VAVAIxxvsz8/gcc602t1g==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr36853255edc.273.1639132774038;
        Fri, 10 Dec 2021 02:39:34 -0800 (PST)
Received: from gmail.com (563BA250.dsl.pool.telekom.hu. [86.59.162.80])
        by smtp.gmail.com with ESMTPSA id m25sm1189113edj.80.2021.12.10.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:39:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 10 Dec 2021 11:39:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] futex: Fix sparc32/m68k/nds32 build regression
Message-ID: <YbMuYlTwaedpI6iz@gmail.com>
References: <20211126095852.455492-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126095852.455492-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> In one of the revisions of my futex cleanup series, I botched
> up a rename of some function names, breaking sparc32, m68k
> and nds32:
> 
> include/asm-generic/futex.h:17:2: error: implicit declaration of function 'futex_atomic_cmpxchg_inatomic_local_generic'; did you mean 'futex_atomic_cmpxchg_inatomic_local'? [-Werror=implicit-function-declaration]
> 
> Fix the macros to point to the correct functions.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 3f2bedabb62c ("futex: Ensure futex_atomic_cmpxchg_inatomic() is present")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/futex.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index 30e7fa63b5df..66d6843bfd02 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -14,9 +14,9 @@
>   *
>   */
>  #define futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval) \
> -	futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newval)
> +	futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval)
>  #define arch_futex_atomic_op_inuser(op, oparg, oval, uaddr) \
> -	arch_futex_atomic_op_inuser_local_generic(op, oparg, oval, uaddr)
> +	futex_atomic_op_inuser_local(op, oparg, oval, uaddr)
>  #endif /* CONFIG_SMP */
>  #endif

Doesn't solve the regression on MIPS defconfig:

# nice -n 5 make -j76 CROSS_COMPILE=/home/mingo/gcc/cross/bin/mips64-linux- ARCH=mips kernel/futex/syscalls.o
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC      kernel/futex/syscalls.o
In file included from kernel/futex/futex.h:12,
                 from kernel/futex/syscalls.c:7:
./arch/mips/include/asm/futex.h: In function 'arch_futex_atomic_op_inuser':
./arch/mips/include/asm/futex.h:89:23: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
   89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\

Thanks,

	Ingo
