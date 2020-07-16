Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562F222E36
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 23:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgGPV4D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 17:56:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36182 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgGPV4C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 17:56:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594936560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsyDj+dTue2WIP0pk5zGUno9OU1LywpIXSAi/vYPoQs=;
        b=0bVNdp0B/UaxWgy72YFKyLzQWdf8CSVx64FHBr83D1ciBRuFI7A71FoDrXfl5k3sL2QxdA
        O8HpHbYGFRD3puE/L/2afZxpVP0HFM0c2sKxDFinhbAagHNwd7GuBxrvsUULzf5yAcBN03
        gcDoijt0QYA2T9DXQiY6GMOYLdn91/duWpMYvKapnmsS5SffIRK9PNF3ByiQ8I7gvFHKGg
        dKkJdLi+8GIOHjNkjypLKkRgEATqfMP+fyLcyZgpWsaSwDxuxhyO8wj2wdurJEV6+UXbhh
        Vhsvy4Y49jASsQb21QP69Hrr164Ifsyjk1FvdluSho+nGrUDX4bDffZ5y2TxkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594936560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bsyDj+dTue2WIP0pk5zGUno9OU1LywpIXSAi/vYPoQs=;
        b=KgVJ09qAZ9uHZF5kMPNjFmsbcKwamC34NQluBD8GHOBcuwsj+txXWXeFm9UVhLJpJH7haY
        4L92gYWqPCKrh3Cg==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
In-Reply-To: <202007161336.B993ED938@keescook>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de> <202007161336.B993ED938@keescook>
Date:   Thu, 16 Jul 2020 23:55:59 +0200
Message-ID: <87d04vt98w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:09PM +0200, Thomas Gleixner wrote:
>> This code is needlessly duplicated and  different in all
>> architectures.
>> 
>> Provide a generic version based on the x86 implementation which has all the
>> RCU and instrumentation bits right.
>
> Ahh! You're reading my mind!

I told you about that plan at the last conference over a beer :)

> I was just thinking about this while reviewing the proposed syscall
> redirection series[1], and pondering the lack of x86 TIF flags, and
> that nearly everything in the series (and for seccomp and other
> things) didn't need to be arch-specific. And now that series
> absolutely needs to be rebased and it'll magically work for every arch
> that switches to the generic entry code. :)

That's the plan. 

> Notes below...
>
> [1] https://lore.kernel.org/lkml/20200716193141.4068476-2-krisman@collabora.com/

Saw that fly by. *shudder*

>> +/*
>> + * Define dummy _TIF work flags if not defined by the architecture or for
>> + * disabled functionality.
>> + */
>
> When I was thinking about this last week I was pondering having a split
> between the arch-agnositc TIF flags and the arch-specific TIF flags, and
> that each arch could have a single "there is agnostic work to be done"
> TIF in their thread_info, and the agnostic flags could live in
> task_struct or something. Anyway, I'll keep reading...

That's going to be nasty. We rather go and expand the TIF storage to
64bit. And then do the following in a generic header:

#ifndef TIF_ARCH_SPECIFIC
# define TIF_ARCH_SPECIFIC
#endif

enum tif_bits {
	TIF_NEED_RESCHED = 0,
        TIF_...,
        TIF_LAST_GENERIC,
        TIF_ARCH_SPECIFIC,
};
        
and in the arch specific one:

#define TIF_ARCH_SPECIFIC	\
	TIF_ARCH_1,             \
        TIF_ARCH_2,

or something like that.

>> +/**
>> + * syscall_enter_from_user_mode - Check and handle work before invoking
>> + *				 a syscall
>> + * @regs:	Pointer to currents pt_regs
>> + * @syscall:	The syscall number
>> + *
>> + * Invoked from architecture specific syscall entry code with interrupts
>> + * disabled. The calling code has to be non-instrumentable. When the
>> + * function returns all state is correct and the subsequent functions can be
>> + * instrumented.
>> + *
>> + * Returns: The original or a modified syscall number
>> + *
>> + * If the returned syscall number is -1 then the syscall should be
>> + * skipped. In this case the caller may invoke syscall_set_error() or
>> + * syscall_set_return_value() first.  If neither of those are called and -1
>> + * is returned, then the syscall will fail with ENOSYS.
>
> There's been some recent confusion over "has the syscall changed,
> or did seccomp request it be skipped?" that was explored in arm64[2]
> (though I see Will and Keno in CC already). There might need to be a
> clearer way to distinguish between "wild userspace issued a -1 syscall"
> and "seccomp or ptrace asked for the syscall to be skipped". The
> difference is mostly about when ENOSYS gets set, with respect to calls
> to syscall_set_return_value(), but if the syscall gets changed, the arch
> may need to recheck the value and consider ENOSYS, etc. IIUC, what Will
> ended up with[3] was having syscall_trace_enter() return the syscall return
> value instead of the new syscall.

I was chatting with Will about that yesterday. IIRC he plans to fix the
immediate issue on arm64 first and then move arm64 over to the generic
variant. That's the reason why I reshuffled the patch series so the
generic parts are first which allows me to provide will a branch with
just those. If there are any changes needed we can just feed them back
into that branch and fixup the affected architecture trees.

IOW, that should not block progress on this stuff.

Thanks,

        tglx



