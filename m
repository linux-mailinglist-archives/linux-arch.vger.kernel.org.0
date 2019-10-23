Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9DE26FD
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 01:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfJWXYF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 19:24:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfJWXYF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 19:24:05 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNPyy-0002iM-Q5; Thu, 24 Oct 2019 01:24:00 +0200
Date:   Thu, 24 Oct 2019 01:23:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
In-Reply-To: <20191023220109.jmbrluyjxenblcij@treble>
Message-ID: <alpine.DEB.2.21.1910240121460.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.084086112@linutronix.de> <20191023220109.jmbrluyjxenblcij@treble>
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

On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
> On Wed, Oct 23, 2019 at 02:27:10PM +0200, Thomas Gleixner wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1500,10 +1500,13 @@ static noinline void
> >  		return;
> >  
> >  	/* Was the fault on kernel-controlled part of the address space? */
> > -	if (unlikely(fault_in_kernel_space(address)))
> > +	if (unlikely(fault_in_kernel_space(address))) {
> >  		do_kern_addr_fault(regs, hw_error_code, address);
> > -	else
> > +	} else {
> >  		do_user_addr_fault(regs, hw_error_code, address);
> > +		if (regs->flags & X86_EFLAGS_IF)
> > +			local_irq_disable();
> > +	}
> 
> The corresponding irq enable is in do_user_addr_fault(), why not do the
> disable there?

Yeah, will do. Was just as lazy as Peter and did not want to touch the
gazillion of returns. :)

Thanks,

	tglx
