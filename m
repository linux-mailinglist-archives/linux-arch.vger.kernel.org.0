Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A348004
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhCXSH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237314AbhCXSHI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:07:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AFC861A1B
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616609227;
        bh=rntKfLiZjIJur0cJE9GfWsqklpTRAWKt+oAJMuQR90k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLUte6mBidZkeN/akNI+rinyYjj1gEpTLC2YfAWVIvHBUAzaCZnPGjWUEHPm//jqb
         JFOWMkLu+BQtDOZ7VWREkNc+gk4UYfVxqFppY6fGvnsz2iP5D7FhbxAw1s061Ps6wI
         lipcm4BN7sFbqSwopH5Nllhxo8XeJzzxU4Me6qm+HJXjgr4L1bGfA4XW909ZRDEXBI
         2SvPBqbSGF8BYQtJ8HJHoloN2CpEajQi0dwsi/4ilIf8CW1d8nhKzu2ldQwa/EYzsF
         i9WZ4htR545gDIFtjLXejP6SZMQpkhVqx80LKSJBqb2PMbSstxqkaDYUlrmtniEGeU
         jOvFtErrApokw==
Received: by mail-ed1-f48.google.com with SMTP id b16so28726338eds.7
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 11:07:07 -0700 (PDT)
X-Gm-Message-State: AOAM530OVGqpok4cd7uPlsaiZts0mj0QBnLRsWPNARzeGpWcvOqOpshx
        Eb52Gq8VJtUBZtEaVC1JTe1qN8cLuRN6fM6+1Okfjg==
X-Google-Smtp-Source: ABdhPJwnCnWNhSCvq9avZ/yNEjkfbD+BzcJo4XPAGTCeaReeESXeH9KLLx+kOTzjAvQvpBbMMKfzBuwMJNpiw/zw+S0=
X-Received: by 2002:aa7:da98:: with SMTP id q24mr5005159eds.84.1616609225868;
 Wed, 24 Mar 2021 11:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
 <your-ad-here.call-01616607308-ext-0852@work.hours>
In-Reply-To: <your-ad-here.call-01616607308-ext-0852@work.hours>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Mar 2021 11:06:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXrj563KJP3p2+_GM=wARGDqM_BpRP-AACN8TXK8j4ypQ@mail.gmail.com>
Message-ID: <CALCETrXrj563KJP3p2+_GM=wARGDqM_BpRP-AACN8TXK8j4ypQ@mail.gmail.com>
Subject: Re: Is s390's new generic-using syscall code actually correct?
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 10:39 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> Hi Andy,
>
> On Sat, Mar 20, 2021 at 08:48:34PM -0700, Andy Lutomirski wrote:
> > Hi all-
> >
> > I'm working on my kentry patchset, and I encountered:
> >
> > commit 56e62a73702836017564eaacd5212e4d0fa1c01d
> > Author: Sven Schnelle <svens@linux.ibm.com>
> > Date:   Sat Nov 21 11:14:56 2020 +0100
> >
> >     s390: convert to generic entry
> >
> > As part of this work, I was cleaning up the generic syscall helpers,
> > and I encountered the goodies in do_syscall() and __do_syscall().
> >
> > I'm trying to wrap my head around the current code, and I'm rather confused.
> >
> > 1. syscall_exit_to_user_mode_work() does *all* the exit work, not just
> > the syscall exit work.  So a do_syscall() that gets called twice will
> > do the loopy part of the exit work (e.g. signal handling) twice.  Is
> > this intentional?  If so, why?
> >
> > 2. I don't understand how this PIF_SYSCALL_RESTART thing is supposed
> > to work.  Looking at the code in Linus' tree, if a signal is pending
> > and a syscall returns -ERESTARTSYS, the syscall will return back to
> > do_syscall().  The work (as in (1)) gets run, calling do_signal(),
> > which will notice -ERESTARTSYS and set PIF_SYSCALL_RESTART.
> > Presumably it will also push the signal frame onto the stack and aim
> > the return address at the svc instruction mentioned in the commit
> > message from "s390: convert to generic entry".  Then __do_syscall()
> > will turn interrupts back on and loop right back into do_syscall().
> > That seems incorrect.
> >
> > Can you enlighten me?  My WIP tree is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/kentry
> >
>
> For all the details to that change we'd have to wait for Sven, who is back
> next week.
>
> > Here are my changes to s390, and I don't think they're really correct:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/diff/arch/s390/kernel/syscall.c?h=x86/kentry&id=58a459922be0fb8e0f17aeaebcb0ac8d0575a62c
>
> Couple of things: syscall_exit_to_user_mode_prepare is static,
> and there is another code path in arch/s390/kernel/traps.c using
> enter_from_user_mode/exit_to_user_mode.
>
> Anyhow I gave your branch a spin and got few new failures on strace test
> suite, in particular on restart_syscall test. I'll try to find time to
> look into details.

I refreshed the branch, but I confess I haven't compile tested it. :)

I would guess that the new test case failures are a result of the
buggy syscall restart logic.  I think that all of the "restart" cases
except execve() should just be removed.  Without my patch, I suspect
that signal delivery with -ERESTARTSYS would create the signal frame,
do an accidental "restarted" syscall that was a no-op, and then
deliver the signal.  With my patch, it may simply repeat the original
interrupted signal forever.

--Andy
