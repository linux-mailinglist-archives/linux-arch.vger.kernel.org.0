Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDB2680BC
	for <lists+linux-arch@lfdr.de>; Sun, 13 Sep 2020 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMS12 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Sep 2020 14:27:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMS11 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Sep 2020 14:27:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600021644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMJtr2JqN0kiR0GwnxtFMazq99OS4VS1oSm7b6RaJJI=;
        b=JApFJsFIE09rG1/wKIq7C2ldW8nsOc/YlZnAzu4PoH4i5Vg5OTQ/Qq7BDop274ufYS4FvX
        KzZmUMcW1rjmi4dXDRQSSD6wD9+Qe+Scdxe5wMKqyxbc1B4jl2xoqT1I+7IhZAXMbANwn2
        V7hjNH8p84vVU4kWWLqlnZgGoYbktmvS4YSt9O/g+z0JUS+rpyu27zahpqJiaH2w/JYjKX
        62prwzOJfBS+4DX1bqQtRtcQWFNz5wfBEkZfLl49lHFkWWWCdO18BObk+a+noXUYufIalc
        r08KwpToXkToo2X+gemB6+YohtIODK7oWoMMiCZ7qXIsqgPRu77CnP3h4jns3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600021644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMJtr2JqN0kiR0GwnxtFMazq99OS4VS1oSm7b6RaJJI=;
        b=javeHOqMh8camHOqoHhky7mRCIFcwAQJ4n5f0CfBB7PyTjmoQFv9Qlwb1Za3nHcZjcAdkD
        0al/trQBmpGRaACw==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to change the syscall number at entry via orig_ax
In-Reply-To: <87d02qqfxy.fsf@mpe.ellerman.id.au>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com> <87blj6ifo8.fsf@nanos.tec.linutronix.de> <87a6xzrr89.fsf@mpe.ellerman.id.au> <202009111609.61E7875B3@keescook> <87d02qqfxy.fsf@mpe.ellerman.id.au>
Date:   Sun, 13 Sep 2020 20:27:23 +0200
Message-ID: <87o8m98rck.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 13 2020 at 17:44, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 18683598edbc..901361e2f8ea 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>                         return ret;
>         }
>  
> +       syscall = syscall_get_nr(current, regs);
> +
>         if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
>                 trace_sys_enter(regs, syscall);
>  
>         syscall_enter_audit(regs, syscall);
>  
>         /* The above might have changed the syscall number */
> -       return ret ? : syscall_get_nr(current, regs);
> +       return ret ? : syscall;
>  }

Yup, this looks right. Can you please send a proper patch?

Thanks,

        tglx
