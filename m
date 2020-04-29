Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9011BD98A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgD2K0c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 06:26:32 -0400
Received: from foss.arm.com ([217.140.110.172]:36810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2K0c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADEBDC14;
        Wed, 29 Apr 2020 03:26:31 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 445393F73D;
        Wed, 29 Apr 2020 03:26:30 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:26:28 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 10/23] arm64: mte: Handle synchronous and asynchronous
 tag check faults
Message-ID: <20200429102628.GB30377@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-11-catalin.marinas@arm.com>
 <20200427165822.GE15808@arm.com>
 <20200428134301.GI3868@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428134301.GI3868@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 28, 2020 at 02:43:01PM +0100, Catalin Marinas wrote:
> On Mon, Apr 27, 2020 at 05:58:22PM +0100, Dave P Martin wrote:
> > On Tue, Apr 21, 2020 at 03:25:50PM +0100, Catalin Marinas wrote:
> > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > 
> > > The Memory Tagging Extension has two modes of notifying a tag check
> > > fault at EL0, configurable through the SCTLR_EL1.TCF0 field:
> > > 
> > > 1. Synchronous raising of a Data Abort exception with DFSC 17.
> > > 2. Asynchronous setting of a cumulative bit in TFSRE0_EL1.
> > > 
> > > Add the exception handler for the synchronous exception and handling of
> > > the asynchronous TFSRE0_EL1.TF0 bit setting via a new TIF flag in
> > > do_notify_resume().
> > > 
> > > On a tag check failure in user-space, whether synchronous or
> > > asynchronous, a SIGSEGV will be raised on the faulting thread.
> > 
> > Has there been any discussion on whether this should be SIGSEGV or
> > SIGBUS?
> > 
> > Probably neither is much more appropriate than the other.
> 
> You could argue either way. I don't recall a firm conclusion on this, so
> I picked one that follows SPARC ADI.

Agreed, that precedent is good enough for me.  I hadn't refreshed my
memory of how sparc was using these signals.

> 
> > > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > > index 339882db5a91..e377d77c065e 100644
> > > --- a/arch/arm64/kernel/signal.c
> > > +++ b/arch/arm64/kernel/signal.c
> > > @@ -732,6 +732,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> > >  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
> > >  	regs->pc = (unsigned long)ka->sa.sa_handler;
> > >  
> > > +	/* TCO (Tag Check Override) always cleared for signal handlers */
> > > +	regs->pstate &= ~PSR_TCO_BIT;
> > > +
> > >  	if (ka->sa.sa_flags & SA_RESTORER)
> > >  		sigtramp = ka->sa.sa_restorer;
> > >  	else
> > > @@ -923,6 +926,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> > >  			if (thread_flags & _TIF_UPROBE)
> > >  				uprobe_notify_resume(regs);
> > >  
> > > +			if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> > > +				clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> > > +				force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);
> > > +			}
> > > +
> > 
> > Should this definitely be a force_signal_inject()?
> > 
> > SEGV_MTEAERR is not intrinsically fatal: it must be possible to run past
> > the error, because that's the whole point -- chances are we already did.
> > 
> > Compare this with MTESERR where running past the signal would lead to a
> > spin.
> 
> Good point. This can be a send_sig_fault() (I need to check the right
> API).

Sounds fair.

Cheers
---Dave
