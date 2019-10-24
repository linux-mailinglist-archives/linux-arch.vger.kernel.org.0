Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3FE3DD2
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJXUyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 16:54:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbfJXUyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 16:54:38 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNk7u-0001L9-Jk; Thu, 24 Oct 2019 22:54:34 +0200
Date:   Thu, 24 Oct 2019 22:54:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
In-Reply-To: <20191024174044.GJ4114@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1910242253540.1783@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de> <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com> <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
 <20191024174044.GJ4114@hirez.programming.kicks-ass.net>
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

On Thu, 24 Oct 2019, Peter Zijlstra wrote:
> On Thu, Oct 24, 2019 at 09:24:13AM -0700, Andy Lutomirski wrote:
> > On Wed, Oct 23, 2019 at 2:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > Interrupt state tracing can be safely done in C code. The few stack
> > > > operations in assembly do not need to be covered.
> > > >
> > > > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > > > swapgs_restore_regs_and_return_to_usermode directly.
> > >
> > > This doesn't look right.
> > 
> > Well, I feel a bit silly.  I read this:

Happened to me before. Don't worry.

> > >
> > > >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > > > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> > 
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > and I applied the diff in my head to the wrong function, and I didn't
> > notice that it didn't really apply there.  Oddly, gitweb gets this
> 
> I had the same when reviewing these patches; I was almost going to ask
> tglx about it on IRC when the penny dropped.

diff is weird at times.

Thanks,

	tglx

