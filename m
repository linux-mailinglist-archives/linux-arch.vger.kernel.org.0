Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7466743E2E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbfFMPsC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:48:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFMJVh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 05:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KNxPWlWuxnDwYXMMhXWadjBNeF5Uv67xMzgxslH4spI=; b=RvVfgl22PpGBJDNLkXFMiMjLs
        u8EyR5xVLEFRoaxMXVmWkgS3oWG0cFcTq94IwDR7upEolKf/rdjFDkLH8uYoayUuNpIviET6kY9/8
        tbb/DBMzpHXF5XxnKNtjV46uRJS0UaH/2h+CpUg5R5DWhCY6Q++wILsSOi+cl7IF0vBSJ90GTuunC
        bCj7nyddUBt0KfPVT3aZpEv8LRFzH7VdqyrF41olQSipswiMd3oI+WWxkn21LhC+JiiYWDkDaKY/j
        GfjiqyLLH4ow9K7AOYgLJrGwE8KfWhs1zsCVQlmoIR2Jbf7d9y07Ie9yPKBC1GIea5Nu6gR4dOV/y
        zHArEAOGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbLvA-0000K1-OV; Thu, 13 Jun 2019 09:21:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33A9D209C844F; Thu, 13 Jun 2019 11:21:23 +0200 (CEST)
Date:   Thu, 13 Jun 2019 11:21:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to
 avoid instrumentation
Message-ID: <20190613092123.GO3402@hirez.programming.kicks-ass.net>
References: <20190531150828.157832-1-elver@google.com>
 <20190531150828.157832-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531150828.157832-3-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 31, 2019 at 05:08:30PM +0200, Marco Elver wrote:
> This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> test_bit inside the uaccess region. With instrumentation, the KASAN
> check would otherwise be flagged by objtool.
> 
> For consistency, kernel/signal.c was changed to mirror this change,
> however, is never instrumented with KASAN (currently unsupported under
> x86 32bit).

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> ---
> Changes in v3:
> * Use static_cpu_has instead of moving boot_cpu_has outside uaccess
>   region.
> 
> Changes in v2:
> * Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
>   whitelist'
> ---
>  arch/x86/ia32/ia32_signal.c | 2 +-
>  arch/x86/kernel/signal.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 629d1ee05599..1cee10091b9f 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
>  		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>  
>  		/* Create the ucontext.  */
> -		if (boot_cpu_has(X86_FEATURE_XSAVE))
> +		if (static_cpu_has(X86_FEATURE_XSAVE))
>  			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>  		else
>  			put_user_ex(0, &frame->uc.uc_flags);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 364813cea647..52eb1d551aed 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>  		put_user_ex(&frame->uc, &frame->puc);
>  
>  		/* Create the ucontext.  */
> -		if (boot_cpu_has(X86_FEATURE_XSAVE))
> +		if (static_cpu_has(X86_FEATURE_XSAVE))
>  			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>  		else
>  			put_user_ex(0, &frame->uc.uc_flags);
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 
