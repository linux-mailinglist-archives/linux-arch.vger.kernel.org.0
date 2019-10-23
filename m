Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD831E26F7
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436987AbfJWXUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 19:20:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436985AbfJWXUy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 19:20:54 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNPvv-0002gP-4W; Thu, 24 Oct 2019 01:20:51 +0200
Date:   Thu, 24 Oct 2019 01:20:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 14/17] entry: Provide generic exit to usermode
 functionality
In-Reply-To: <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910240119090.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.978254388@linutronix.de> <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
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

On Wed, 23 Oct 2019, Andy Lutomirski wrote:

> On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Provide a generic facility to handle the exit to usermode work. That's
> > aimed to replace the pointlessly different copies in each architecture.
> 
> 
> >  /**
> > + * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
> > + * @ti_work:   Cached TIF flags gathered with interrupts disabled
> > + *
> > + * Defaults to local_irq_enable(). Can be supplied by architecture specific
> > + * code.
> 
> What did you have in mind here?

Look at the previous version which had the ARM64 conversion. ARM64 does
magic different stuff vs. local_irq_enable() in the exit path. It's not
using the regular one. I'm happy to ditch that :)

Thanks,

	tglx
