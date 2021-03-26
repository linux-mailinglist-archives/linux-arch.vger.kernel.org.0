Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB55734A0B8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 05:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCZE5e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 00:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhCZE5V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 00:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C961861A44
        for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2021 04:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616734637;
        bh=Jo0P5Muvb8+8gfjPQRi5hsZaxh6GN7AU308texcxIAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DA+GzhnNXjZ1nnTteLALR+Catssi3ud00zohi3LtxDDuSeJ7bDzDJH4jGbLnuhy2r
         HtnPCr0263Z1wj08m2IJzhN3ThSUASTu9VQxrLpxCWLr4WARYUJTACwCiliFbf6cVu
         2vkD/oCO6FwyQXPMd6h4tXi69t8m9owoEGMQuiWAdBHHNIxuZYMjMgThfVSMbsy7q+
         Ut818JRaMB8LFFuHnIE8HEcTXUhsi6eJs1J3+exrbBMTyAxOwcS0V5xnIKZ4COBk0H
         FO5Ij6lwmtTMu2FgM6GnsfHxGL4QQRlpj5ABDdd4aqTZFPh+GjqPfRfCpNcOYDThwf
         rUYFoIFJbdJVA==
Received: by mail-ej1-f41.google.com with SMTP id k10so6557397ejg.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:57:16 -0700 (PDT)
X-Gm-Message-State: AOAM532GdsejJPZ04rXQyPwzONRNuYu4rN7W1Cnr+iBDEUIVSMHQ7u4p
        5OAmOkRUvehkFyDgfbfzCsRyJDnK9n1pkCyRB99aXw==
X-Google-Smtp-Source: ABdhPJzQUC5kz4KsMNdtYz20rohKj/gTGnfe27XhqBn77MDhO+QCO6+ZjKJL54krol5eOLqpgHby8Vz1sy8kLqXHsAs=
X-Received: by 2002:a17:907:2809:: with SMTP id eb9mr12915334ejc.204.1616734624746;
 Thu, 25 Mar 2021 21:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com> <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
In-Reply-To: <20210325185435.GB32296@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Mar 2021 21:56:53 -0700
X-Gmail-Original-Message-ID: <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
Message-ID: <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
To:     Borislav Petkov <bp@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 11:54 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Mar 25, 2021 at 11:13:12AM -0700, Andy Lutomirski wrote:
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index ea794a083c44..53781324a2d3 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -237,7 +237,8 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
> >       unsigned long math_size = 0;
> >       unsigned long sp = regs->sp;
> >       unsigned long buf_fx = 0;
> > -     int onsigstack = on_sig_stack(sp);
> > +     bool already_onsigstack = on_sig_stack(sp);
> > +     bool entering_altstack = false;
> >       int ret;
> >
> >       /* redzone */
> > @@ -246,15 +247,25 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
> >
> >       /* This is the X/Open sanctioned signal stack switching.  */
> >       if (ka->sa.sa_flags & SA_ONSTACK) {
> > -             if (sas_ss_flags(sp) == 0)
> > +             /*
> > +              * This checks already_onsigstack via sas_ss_flags().
> > +              * Sensible programs use SS_AUTODISARM, which disables
> > +              * that check, and programs that don't use
> > +              * SS_AUTODISARM get compatible but potentially
> > +              * bizarre behavior.
> > +              */
> > +             if (sas_ss_flags(sp) == 0) {
> >                       sp = current->sas_ss_sp + current->sas_ss_size;
> > +                     entering_altstack = true;
> > +             }
> >       } else if (IS_ENABLED(CONFIG_X86_32) &&
> > -                !onsigstack &&
> > +                !already_onsigstack &&
> >                  regs->ss != __USER_DS &&
> >                  !(ka->sa.sa_flags & SA_RESTORER) &&
> >                  ka->sa.sa_restorer) {
> >               /* This is the legacy signal stack switching. */
> >               sp = (unsigned long) ka->sa.sa_restorer;
> > +             entering_altstack = true;
> >       }
>
> What a mess this whole signal handling is. I need a course in signal
> handling to understand what's going on here...
>
> >
> >       sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
> > @@ -267,8 +278,16 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
> >        * If we are on the alternate signal stack and would overflow it, don't.
> >        * Return an always-bogus address instead so we will die with SIGSEGV.
> >        */
> > -     if (onsigstack && !likely(on_sig_stack(sp)))
> > +     if (unlikely(entering_altstack &&
> > +                  (sp <= current->sas_ss_sp ||
> > +                   sp - current->sas_ss_sp > current->sas_ss_size))) {
>
> You could've simply done
>
>         if (unlikely(entering_altstack && !on_sig_stack(sp)))
>
> here.

Nope.  on_sig_stack() is a horrible kludge and won't work here.  We
could have something like __on_sig_stack() or sp_is_on_sig_stack() or
something, though.

>
>
> > +             if (show_unhandled_signals && printk_ratelimit()) {
> > +                     pr_info("%s[%d] overflowed sigaltstack",
> > +                             tsk->comm, task_pid_nr(tsk));
> > +             }
>
> Why do you even wanna issue that? It looks like callers will propagate
> an error value up and people don't look at dmesg all the time.

I figure that the people whose programs spontaneously crash should get
a hint why if they look at dmesg.  Maybe the message should say
"overflowed sigaltstack -- try noavx512"?

We really ought to have a SIGSIGFAIL signal that's sent, double-fault
style, when we fail to send a signal.
