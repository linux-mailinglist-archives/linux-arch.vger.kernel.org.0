Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE72C3225
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgKXUsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgKXUsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 15:48:17 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42454C0613D6
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2020 12:48:15 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so11168541lja.5
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2020 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3epUm83csRRkQAmpLttIRKsjugTlLX4yDOx4MmdoI9k=;
        b=DjCc4MN3vMIBSsP3wMB1bLF2wtdbXdnfZxeQ9qPMcxN/OPEf2DicGu828Nlsf1wu9D
         9LH4T8fYP9cfCnOIPGDY5frb0XXy9n/ULjV8In8XV09w7lu7HXPSB29VJLDdQGrCdjL6
         p7FbyinBchyxWzJazFdcblKWTiGJEX0HpbhtFjwSd1iHiiupe9yvEETMdkbb24Du3Jax
         yFSQfuvAPhFUtL2zp7oZRvFxh9BPLBdVrefwdf8xlXfQ6UNUVC0dnwhLBMyxkV1H17ch
         LWfzRPq7SI5wROFuo961qd1W1GKdYt17MO6YtZ0Feh5a7+5QHGeSMK5lWYOU3nkrCIDM
         k/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3epUm83csRRkQAmpLttIRKsjugTlLX4yDOx4MmdoI9k=;
        b=qaTM97NFWc0VgFGCN81z9Gm434ftZZPGRpo0LETi9wu2yvnQTo+3BcySZ0EAyjN3W8
         I4OrDd2MZ8yGWHsNPdQmihMrpERszHym68mgC3YfZQWY1HhzouDT8RzfH4u7psbxaUNb
         RWOUrLCM4ep62u32mIhUGj7v62+twL+us6uMPHAVgRkmvUUTSYW865/Bo9A7SGIUC8Uc
         c14S5XLnoEJIJ95p14KF4cRFf06g2EESBFMjN1UstlVVe2r0mCa/RHPWepVLv9+iCtBU
         Vwf2NloQVsumfAswsbvK9JWkUKZ3yPTOip+HCuPI+LLcpYycaz3akh8GnC9RUnozaALe
         CVdg==
X-Gm-Message-State: AOAM53262kKfb/wVdlGGbQ2k0/q29wKZbAvOi0zauhP+1fzF2R+ED8QJ
        9MBEwpQFPxT7GpDGbK8A+QxM0abSNyEnj/eAlHdjIQ==
X-Google-Smtp-Source: ABdhPJy9rSK07pxI0k30vVunlMZK4763KQjWwx2Esh+gUkxGiy0qRGDBofmooW5ebFiAW4nQaGooCZ0Hj/KyFVPB4UE=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr29527ljc.377.1606250893439;
 Tue, 24 Nov 2020 12:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-4-chang.seok.bae@intel.com> <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
 <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com> <CAG48ez1JK6pMT2UD1v0FwiCQq48FbE5Eb0d3tK=kK4Sg0TG7OQ@mail.gmail.com>
 <15AB5469-3DBD-4518-9C15-DDCE7C70B1B5@intel.com>
In-Reply-To: <15AB5469-3DBD-4518-9C15-DDCE7C70B1B5@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Nov 2020 21:47:47 +0100
Message-ID: <CAG48ez3=0P+yiAjxGy=uEZeDUvFh+M2GUnVaGPfRoQHbJ+2qKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 24, 2020 at 9:43 PM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> > On Nov 24, 2020, at 10:41, Jann Horn <jannh@google.com> wrote:
> > On Tue, Nov 24, 2020 at 7:22 PM Bae, Chang Seok
> > <chang.seok.bae@intel.com> wrote:
> >>> On Nov 20, 2020, at 15:04, Jann Horn <jannh@google.com> wrote:
> >>> On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>>>
> >>>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> >>>> index ee6f1ceaa7a2..cee41d684dc2 100644
> >>>> --- a/arch/x86/kernel/signal.c
> >>>> +++ b/arch/x86/kernel/signal.c
> >>>> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
> >>>>
> >>>>       /* This is the X/Open sanctioned signal stack switching.  */
> >>>>       if (ka->sa.sa_flags & SA_ONSTACK) {
> >>>> -               if (sas_ss_flags(sp) == 0)
> >>>> +               if (sas_ss_flags(sp) == 0) {
> >>>> +                       /* If the altstack might overflow, die with SIGSEGV: */
> >>>> +                       if (!altstack_size_ok(current))
> >>>> +                               return (void __user *)-1L;
> >>>> +
> >>>>                       sp = current->sas_ss_sp + current->sas_ss_size;
> >>>> +               }
> >>>
> >>> A couple lines further down, we have this (since commit 14fc9fbc700d):
> >>>
> >>>       /*
> >>>        * If we are on the alternate signal stack and would overflow it, don't.
> >>>        * Return an always-bogus address instead so we will die with SIGSEGV.
> >>>        */
> >>>       if (onsigstack && !likely(on_sig_stack(sp)))
> >>>               return (void __user *)-1L;
> >>>
> >>> Is that not working?
> >>
> >> onsigstack is set at the beginning here. If a signal hits under normal stack,
> >> this flag is not set. Then it will miss the overflow.
> >>
> >> The added check allows to detect the sigaltstack overflow (always).
> >
> > Ah, I think I understand what you're trying to do. But wouldn't the
> > better approach be to ensure that the existing on_sig_stack() check is
> > also used if we just switched to the signal stack? Something like:
> >
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index be0d7d4152ec..2f57842fb4d6 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -237,7 +237,7 @@ get_sigframe(struct k_sigaction *ka, struct
> > pt_regs *regs, size_t frame_size,
> >        unsigned long math_size = 0;
> >        unsigned long sp = regs->sp;
> >        unsigned long buf_fx = 0;
> > -       int onsigstack = on_sig_stack(sp);
> > +       bool onsigstack = on_sig_stack(sp);
> >        int ret;
> >
> >        /* redzone */
> > @@ -246,8 +246,10 @@ get_sigframe(struct k_sigaction *ka, struct
> > pt_regs *regs, size_t frame_size,
> >
> >        /* This is the X/Open sanctioned signal stack switching.  */
> >        if (ka->sa.sa_flags & SA_ONSTACK) {
> > -               if (sas_ss_flags(sp) == 0)
> > +               if (sas_ss_flags(sp) == 0) {
> >                        sp = current->sas_ss_sp + current->sas_ss_size;
> > +                       onsigstack = true;
> > +               }
> >        } else if (IS_ENABLED(CONFIG_X86_32) &&
> >                   !onsigstack &&
> >                   regs->ss != __USER_DS &&
>
> Yeah, but wouldn't it better to avoid overwriting user data if we can? The old
> check raises segfault *after* overwritten.

Where is that overwrite happening? Between the point where your check
happens, and the point where the old check is, the only calls are to
fpu__alloc_mathframe() and align_sigframe(), right?
fpu__alloc_mathframe() just does some size calculations and doesn't
write anything. align_sigframe() also just does size calculations. Am
I missing something?
