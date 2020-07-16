Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC7222D41
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgGPUwh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgGPUwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:52:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D53C08C5C0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:52:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so4381260pls.9
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aquIO2FGAE3lkoXCYp5iGwupgQI/65LCYOM68Vjw6Tk=;
        b=e4nnEJcZ/2dm2oYM392D+Ygv7VRrVE4tmm+yuKAqRtbsZNjS/1PkZ46Uxg8lMawtjg
         El2Z81ViYhNC0aaun3sECRkjhMsnRv98wWpt8kupNRE2/dtD/TMRkXdwdzaMZqMcaa4L
         ei0O+fZuVfuoMtxgfqNKcekKxywb2hDgAl3ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aquIO2FGAE3lkoXCYp5iGwupgQI/65LCYOM68Vjw6Tk=;
        b=Oot6zA0XKirS1AT/0ifOhn1aMuXNI/y2UbEFvEKeH2MOvDU+LBDdAj8E8O4ViI9c8M
         6RmTFYC1Q6t2UvPoVb1Ny2gYTQL4hsyKItZ3EFKsyRZWV8iyytoW2R4H9odklBGgiGrz
         DN7Q0HokT/R/bXxZ2h9zu+fkRtAY5QOPdffvO8Fy77xll2xb4GJPU0wmd7BrDC+cBgji
         6rQbh6pGS8Asvfwt/ZheryPVeU/tiSywOjf9JZXe6CW0GBqLVd5Cj6jBvBgduBt7gkrj
         mOzcVghTBaqPvyo501RqT1AM+Ai/MSZVF6Mdzk+5axJcKU2sz8BdBG3ICYPgkNmxJW6T
         fPng==
X-Gm-Message-State: AOAM530SeloB94oD3CIkIS6VovgozKZbfhjpLjGbl0rJb4raBqRmT6yv
        Qnj2J+4UwgctLw97IrkYMvp4fg==
X-Google-Smtp-Source: ABdhPJzbQgJCDG9LnefQx5i570VFQUbYsZndgRWWuoW2VeaNkft010xcMMlGVftM1UOa8T+so1E6cQ==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr5040902plq.263.1594932755485;
        Thu, 16 Jul 2020 13:52:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm5532894pgk.68.2020.07.16.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:52:34 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:52:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry
 functionality
Message-ID: <202007161336.B993ED938@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.011950288@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.011950288@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:09PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On syscall entry certain work needs to be done:
> 
>    - Establish state (lockdep, context tracking, tracing)
>    - Conditional work (ptrace, seccomp, audit...)
> 
> This code is needlessly duplicated and  different in all
> architectures.
> 
> Provide a generic version based on the x86 implementation which has all the
> RCU and instrumentation bits right.

Ahh! You're reading my mind! I was just thinking about this while
reviewing the proposed syscall redirection series[1], and pondering the
lack of x86 TIF flags, and that nearly everything in the series (and for
seccomp and other things) didn't need to be arch-specific. And now that
series absolutely needs to be rebased and it'll magically work for every
arch that switches to the generic entry code. :)

Notes below...

[1] https://lore.kernel.org/lkml/20200716193141.4068476-2-krisman@collabora.com/

> +/*
> + * Define dummy _TIF work flags if not defined by the architecture or for
> + * disabled functionality.
> + */

When I was thinking about this last week I was pondering having a split
between the arch-agnositc TIF flags and the arch-specific TIF flags, and
that each arch could have a single "there is agnostic work to be done"
TIF in their thread_info, and the agnostic flags could live in
task_struct or something. Anyway, I'll keep reading...

> +/**
> + * syscall_enter_from_user_mode - Check and handle work before invoking
> + *				 a syscall
> + * @regs:	Pointer to currents pt_regs
> + * @syscall:	The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the
> + * function returns all state is correct and the subsequent functions can be
> + * instrumented.
> + *
> + * Returns: The original or a modified syscall number
> + *
> + * If the returned syscall number is -1 then the syscall should be
> + * skipped. In this case the caller may invoke syscall_set_error() or
> + * syscall_set_return_value() first.  If neither of those are called and -1
> + * is returned, then the syscall will fail with ENOSYS.

There's been some recent confusion over "has the syscall changed,
or did seccomp request it be skipped?" that was explored in arm64[2]
(though I see Will and Keno in CC already). There might need to be a
clearer way to distinguish between "wild userspace issued a -1 syscall"
and "seccomp or ptrace asked for the syscall to be skipped". The
difference is mostly about when ENOSYS gets set, with respect to calls
to syscall_set_return_value(), but if the syscall gets changed, the arch
may need to recheck the value and consider ENOSYS, etc. IIUC, what Will
ended up with[3] was having syscall_trace_enter() return the syscall return
value instead of the new syscall.

[2] https://lore.kernel.org/lkml/20200704125027.GB21185@willie-the-truck/
[3] https://lore.kernel.org/lkml/20200703083914.GA18516@willie-the-truck/

> +static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> +				unsigned long ti_work)
> +{
> +	long ret = 0;
> +
> +	/* Handle ptrace */
> +	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> +		ret = arch_syscall_enter_tracehook(regs);
> +		if (ret || (ti_work & _TIF_SYSCALL_EMU))
> +			return -1L;
> +	}
> +
> +	/* Do seccomp after ptrace, to catch any tracer changes. */
> +	if (ti_work & _TIF_SECCOMP) {
> +		ret = arch_syscall_enter_seccomp(regs);
> +		if (ret == -1L)
> +			return ret;
> +	}
> +
> +	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
> +		trace_sys_enter(regs, syscall);
> +
> +	arch_syscall_enter_audit(regs);
> +
> +	return ret ? : syscall;
> +}

Modulo the notes about -1 vs syscall number above, this looks correct to
me for ptrace and seccomp.

-- 
Kees Cook
