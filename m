Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02505DDE53
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2019 13:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJTLtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Oct 2019 07:49:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfJTLtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Oct 2019 07:49:17 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM9hw-00084H-0h; Sun, 20 Oct 2019 13:49:12 +0200
Date:   Sun, 20 Oct 2019 13:49:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC patch 01/15] entry: Provide generic syscall entry
 functionality
In-Reply-To: <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910201347460.2090@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.521907403@linutronix.de> <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 20 Sep 2019, Andy Lutomirski wrote:
> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > +#ifndef _TIF_AUDIT
> > +# define _TIF_AUDIT                    (0)
> > +#endif
> 
> I'm wondering if these should be __TIF (double-underscore) or
> MAYBE_TIF_ or something to avoid errors where people do flags |=
> TIF_WHATEVER and get surprised.

That's what exists today already. See arch/*/include/asm/threadinfo.h
 
> > +/**
> > + * syscall_enter_from_usermode - Check and handle work before invoking
> > + *                              a syscall
> > + * @regs:      Pointer to currents pt_regs
> > + * @syscall:   The syscall number
> > + *
> > + * Invoked from architecture specific syscall entry code with interrupts
> > + * enabled.
> > + *
> > + * Returns: The original or a modified syscall number
> > + */
> 
> Maybe document that it can return -1 to skip the syscall and that, if
> this happens, it may use syscall_set_error() or
> syscall_set_return_value() first.  If neither of those is called and
> -1 is returned, then the syscall will fail with ENOSYS.

Sure.

Thanks,

	tglx

