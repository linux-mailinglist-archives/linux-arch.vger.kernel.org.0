Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12F316359E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 23:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRWAL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 17:00:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34868 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRWAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 17:00:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so25830486wrt.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Feb 2020 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXQHJwHEEnVHauBnQEp+K06dMcddSWeFIBEKwcqNjvY=;
        b=nreTZoRpOvqTwmumvsIXMrFVOQXcDbnv6W15HbKXapZS3n8EE++vulDuWNS626JKXw
         +zgAgLRoc6fC6Il9RExWb4VJrWYxeW9A3UWfjSLrUx417GidXbEIcvyt6DOW901H8KG8
         DiNoEwck1n/rwqtQ7ihZ0svt7RwwHRNHDwpmVdmUUUA40GjEvFcDcb9FkeuzTSiyzL81
         ccvxaeOFJ9URflRugRrRHN4FbYbQg2rBsn1R5N2O2PLq4xuXt4kzQfRvD/QBS3bbaoOg
         JsFkoI4Ejjtrng4tW/kSPuVNJ4IJ7HsjxshWOcGGeQ4LNLmP8r2hE3bJ27FuwV7azSJ2
         kpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXQHJwHEEnVHauBnQEp+K06dMcddSWeFIBEKwcqNjvY=;
        b=ZxypNBQTdJktjCTcLwzNjzi3MYqq622RrAyAduJmq+Cw6xnsL3o9RNH2v9XW2Pgm3a
         5W8EpWyjKjp5W2GPo0K6NnHP/dMFDvFMw8P6Jyqcg8TlQzJzqu9FfrcX7bGUL3h+tD0R
         +3jnFtL6qGRvAvh3tA35Y6w90R78FDem00VbBkmHQ66cfWTiOFCWDrSuVzP4BmgbS7nq
         YNXhLMXkYNoKJlvdJtWbE6jOitknAB7vNvtBMI+EfBbm1hsclfsqHYErBxx4rB7dU9gX
         xZBO5omyCast/hRToBtKJ6cJzs2CHv1uzWlSDUZf9il3KTi4kFY3++ay0QWNALaUdJbB
         26fQ==
X-Gm-Message-State: APjAAAUZjvXIP9K7XiQRb1ExyCk0/AscbUhgKW5VAlvyUn+iW+iL6IWF
        Yhs4eUEcTAfZ5Js2hZGfzlsLGdXEHn3akOrPGmKS5Q==
X-Google-Smtp-Source: APXvYqy6irBj57I3FWNNO68AlkFwJP+eCW7WSFRMfNtH7vP/kn7OPj/7/NLtMwqMwPtdUdZ5NYhKCB5JRZmiRVLY0As=
X-Received: by 2002:adf:e40f:: with SMTP id g15mr30563070wrm.223.1582063187500;
 Tue, 18 Feb 2020 13:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20191217180152.GO5624@arrakis.emea.arm.com> <20191220013639.212396-1-pcc@google.com>
 <20200212110903.GE488264@arrakis.emea.arm.com>
In-Reply-To: <20200212110903.GE488264@arrakis.emea.arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 18 Feb 2020 13:59:34 -0800
Message-ID: <CAMn1gO6bDenF95Rk2sUyGhm0f7PfEj6i_tmH+geVdU3ZqcRifw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mte: Do not service syscalls after async tag fault
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 3:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Dec 19, 2019 at 05:36:39PM -0800, Peter Collingbourne wrote:
> > When entering the kernel after an async tag fault due to a syscall, rather
> > than for another reason (e.g. preemption), we don't want to service the
> > syscall as it may mask the tag fault. Rewind the PC to the svc instruction
> > in order to give a userspace signal handler an opportunity to handle the
> > fault and resume, and skip all other syscall processing.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> [...]
> >  arch/arm64/kernel/syscall.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 9a9d98a443fc..49ea9bb47190 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -95,13 +95,29 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >  {
> >       unsigned long flags = current_thread_info()->flags;
> >
> > -     regs->orig_x0 = regs->regs[0];
> > -     regs->syscallno = scno;
> > -
> >       cortex_a76_erratum_1463225_svc_handler();
> >       local_daif_restore(DAIF_PROCCTX);
> >       user_exit();
> >
> > +#ifdef CONFIG_ARM64_MTE
> > +     if (flags & _TIF_MTE_ASYNC_FAULT) {
> > +             /*
> > +              * We entered the kernel after an async tag fault due to a
> > +              * syscall, rather than for another reason (e.g. preemption).
> > +              * In this case, we don't want to service the syscall as it may
> > +              * mask the tag fault. Rewind the PC to the svc instruction in
> > +              * order to give a userspace signal handler an opportunity to
> > +              * handle the fault and resume, and skip all other syscall
> > +              * processing.
> > +              */
> > +             regs->pc -= 4;
> > +             return;
> > +     }
> > +#endif
> > +
> > +     regs->orig_x0 = regs->regs[0];
> > +     regs->syscallno = scno;
>
> I'm slightly worried about the interaction with single-step, other
> signals. It might be better if we just use the existing syscall
> restarting mechanism. Untested diff below:
>
> -------------------8<-------------------------------
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index a12c0c88d345..db25f5d6a07c 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -102,6 +102,16 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>         local_daif_restore(DAIF_PROCCTX);
>         user_exit();
>
> +       if (system_supports_mte() && (flags & _TIF_MTE_ASYNC_FAULT)) {
> +               /*
> +                * Process the asynchronous tag check fault before the actual
> +                * syscall. do_notify_resume() will send a signal to userspace
> +                * before the syscall is restarted.
> +                */
> +               regs->regs[0] = -ERESTARTNOINTR;
> +               return;
> +       }
> +
>         if (has_syscall_work(flags)) {
>                 /* set default errno for user-issued syscall(-1) */
>                 if (scno == NO_SYSCALL)

That works for me, and I verified that my small test program as well
as some larger unit tests behave as expected.

Tested-by: Peter Collingbourne <pcc@google.com>


Peter
