Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56544437AB8
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhJVQRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhJVQRu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:17:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79417C061766
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:15:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t7so3732834pgl.9
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dZGwKlOKsd7h3Lv9CW9qHzX8xPDEzb5LWAr34NR3RiU=;
        b=Hjwap19eGAGh2JgtlUFiZQcStZrIqT8hHm4703u6DieLgy2ApUKs4s3rhZciall20L
         O7R9j3ifekFQxFSPGWM3mZgbvQ2QpfxuWOnSSlFMhI63rEqOTOQ/W/yzYNgVM1Of6Aag
         UWVTUu4zm4UXfxfD9n439U7moRc3BtyyHT568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZGwKlOKsd7h3Lv9CW9qHzX8xPDEzb5LWAr34NR3RiU=;
        b=SV8uZ+FEdWdsci70+2ZH8pC+9tzFq+lsHrAXSGCr1olCSpssIRJeDtljbyX+9eIwIz
         0bMfuY0CzOpXigYwQMbQbki0AnnvoNRWJT0hL9KyD32YBMLtMxU2i9jfgjaFIa8PD7mF
         x+iEvs81sdmUj7JxurDCfBePVzgJlJIBh42VSwYmmKB4AFBGQIbStyRY7YvuAUFGGdX5
         ojF6SV0aruVHzvcHs03BEDUkKbeXt5kUM2k36cfZ5IXj2UzqeZcbvePCA06d7hZPv+KA
         Gn58aBxbSJPAo7qlDuyART8tQ5qZoxYNao5iBTRsLG7z1LisUywvGryVGPmJcx76JoIb
         K7cg==
X-Gm-Message-State: AOAM531GeoMFf+VhooO4HmrHnky6mwUU7OmhhY7RZ9R7L0D/l7aDJiO+
        gjf/ba9zysNGgrwZPwLO9917Fw==
X-Google-Smtp-Source: ABdhPJwLgq3PV6MYMW7iluDna7GiiOH95uaBslbXxkUy+Sp0uJJQEYBMWRJCCpsjoLuwOS2zFUkuQg==
X-Received: by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with SMTP id s16-20020a056a0008d000b0044c26e61c13mr554029pfu.28.1634919331974;
        Fri, 22 Oct 2021 09:15:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t28sm10179371pfq.158.2021.10.22.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:15:31 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:15:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 5/7] powerpc, arm64: Mark __switch_to() as __sched
Message-ID: <202110220914.11A7C074AF@keescook>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.419533274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.419533274@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:38PM +0200, Peter Zijlstra wrote:
> Unlike most of the other architectures, PowerPC and ARM64 have
> __switch_to() as a C function which remains on the stack. Their
> respective __get_wchan() skips one stack frame unconditionally,
> without testing is_sched_functions().
> 
> Mark them __sched such that we can forgo that special case.

I wonder if this change will improve any benchmarks? (i.e. this will
move __switch_to into the scheduler section, maybe improving icache?)

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/kernel/process.c   |    4 ++--
>  arch/powerpc/kernel/process.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -490,8 +490,8 @@ void update_sctlr_el1(u64 sctlr)
>  /*
>   * Thread switching.
>   */
> -__notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
> -				struct task_struct *next)
> +__notrace_funcgraph __sched
> +struct task_struct *__switch_to(struct task_struct *prev, struct task_struct *next)
>  {
>  	struct task_struct *last;
>  
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1201,8 +1201,8 @@ static inline void restore_sprs(struct t
>  
>  }
>  
> -struct task_struct *__switch_to(struct task_struct *prev,
> -	struct task_struct *new)
> +__sched struct task_struct *__switch_to(struct task_struct *prev,
> +					struct task_struct *new)
>  {
>  	struct thread_struct *new_thread, *old_thread;
>  	struct task_struct *last;
> 
> 

-- 
Kees Cook
