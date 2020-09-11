Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5699266871
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgIKS6k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKS6e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 14:58:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B78C061573
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 11:58:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so7288958pgh.6
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXmHidgwtnTnxCDrTuOclLLnDmLj/yLMTWxKoHjkjfQ=;
        b=ZrOejeHoXLixXlu6m7vIPESK+fObNaFjZbYZb6BuPccGC8RhiVx86JFf69d/MMrQh3
         c5GLEicnmJy6bM1/V0UBllGrc6/ouavLYqSLeTsNsbiwto675zmuU7WPI4+tQ1SjuaIh
         xmSrh1si1mjT6qM2CdlptrXbP8DIJUI+A8S8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXmHidgwtnTnxCDrTuOclLLnDmLj/yLMTWxKoHjkjfQ=;
        b=DOPwOCJ0yjxDe9m5ft3mPIhCzZEak0CnwVeS+2lmJjOdpoh8jrQUkxju5rAQRikTpg
         rJJyTcAQpekx2VN9QZxbbHwfCZVuaEoTSddiVXRWBK4yVLNRTzZdpje2oisNBlGW3JNT
         Aw0hWmMlW4WfK9gHoVwePaQU+nnb0thgys/UaqV8Ty7LgepSREijlV36Ln1+vfFp6WJL
         ZexWjG89JojQ5F5zhsutn1RL2JpcpuR7ygpHFwgdmDwvL2KCu6LHhw86OpDuKqxYcYGG
         4iueVx36uxjoZdzKGUpHOWQnQ6Cq6XIul59NATAmpaa1GHuk44FyPYefBzTu3FuktM0t
         Kfug==
X-Gm-Message-State: AOAM5305yMP304MrQUdG7rYUbou5HfrJ7krz9N+s9R25s/EBFwZTwcdp
        XU8TdaCmHCTI9PTomoMan7a4PA==
X-Google-Smtp-Source: ABdhPJx1HHzPM4LUXPoNomXjYpginIkBVFSvmj1qsqnJ/hNQ+buyCEi68fmII7HiPctkjBg2DoUsgw==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr2779530pgj.210.1599850713261;
        Fri, 11 Sep 2020 11:58:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 124sm2920285pfd.132.2020.09.11.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:58:31 -0700 (PDT)
Date:   Fri, 11 Sep 2020 11:58:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to
 change the syscall number at entry via orig_ax
Message-ID: <202009111156.660A7C2978@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
 <87a6xzrr89.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6xzrr89.fsf@mpe.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 09, 2020 at 11:53:42PM +1000, Michael Ellerman wrote:
> Hi Thomas,
> 
> Sorry if this was discussed already somewhere, but I didn't see anything ...
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> > On Wed, Aug 19 2020 at 10:14, Kyle Huey wrote:
> >> tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
> >> modifications to orig_ax in a syscall entry trace stop are not honored
> >> and this breaks our code.
> ...
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 9852e0d62d95..fcae019158ca 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> 
> Adding context:
> 
> 	/* Do seccomp after ptrace, to catch any tracer changes. */
> 	if (ti_work & _TIF_SECCOMP) {
> 		ret = __secure_computing(NULL);
> 		if (ret == -1L)
> 			return ret;
> 	}
> 
> 	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
> 		trace_sys_enter(regs, syscall);
> 
> >  	syscall_enter_audit(regs, syscall);
> >  
> > -	return ret ? : syscall;
> > +	/* The above might have changed the syscall number */
> > +	return ret ? : syscall_get_nr(current, regs);
> >  }
> >  
> >  noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
> 
> I noticed if the syscall number is changed by seccomp/ptrace, the
> original syscall number is still passed to trace_sys_enter() and audit.
> 
> The old code used regs->orig_ax, so any change to the syscall number
> would be seen by the tracepoint and audit.

Ah! That's no good.

> I can observe the difference between v5.8 and mainline, using the
> raw_syscall trace event and running the seccomp_bpf selftest which turns
> a getpid (39) into a getppid (110).
> 
> With v5.8 we see getppid on entry and exit:
> 
>      seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (7ffff22c46e0, 40a350, 4, fffffffffffff7ab, 7fa6ee0d4010, 0)
>      seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304
> 
> Whereas on mainline we see an enter for getpid and an exit for getppid:
> 
>      seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (7ffe2f6d1ad0, 40a350, 7ffe2f6d1ad0, 0, 0, 407299)
>      seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027
> 
> 
> I don't know audit that well, but I think it saves the syscall number on
> entry eg. in __audit_syscall_entry(). So it will record the wrong
> syscall happening in this case I think.
> 
> Seems like we should reload the syscall number before calling
> trace_sys_enter() & audit ?

Agreed. I wonder what the best way to build a regression test for this
is... hmmm.

-- 
Kees Cook
