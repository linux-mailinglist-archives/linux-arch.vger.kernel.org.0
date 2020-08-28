Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B83255B8B
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1Nsg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 09:48:36 -0400
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgH1Nsf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 09:48:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24321FB;
        Fri, 28 Aug 2020 06:48:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD1EF3F71F;
        Fri, 28 Aug 2020 06:48:31 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:48:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     peterz@infradead.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 04/23] arm64: kprobes: Use generic kretprobe
 trampoline handler
Message-ID: <20200828134825.GB71981@C02TD0UTHF1T.local>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861764221.992023.10214437014901668680.stgit@devnote2>
 <20200828133131.GA71981@C02TD0UTHF1T.local>
 <20200828133718.GB1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828133718.GB1362448@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 03:37:18PM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 02:31:31PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > On Fri, Aug 28, 2020 at 09:27:22PM +0900, Masami Hiramatsu wrote:
> > > Use the generic kretprobe trampoline handler, and use the
> > > kernel_stack_pointer(regs) for framepointer verification.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  arch/arm64/kernel/probes/kprobes.c |   78 +-----------------------------------
> > >  1 file changed, 3 insertions(+), 75 deletions(-)
> > 
> > > +	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
> > > +					(void *)kernel_stack_pointer(regs));
> > >  }
> > >  
> > >  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > >  				      struct pt_regs *regs)
> > >  {
> > >  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> > > +	ri->fp = (void *)kernel_stack_pointer(regs);
> > 
> > This is probably a nomenclature problem, but what exactly is
> > kretprobe_instance::fp used for?
> > 
> > I ask because arm64's frame pointer lives in x29 (and is not necessarily
> > the same as the stack pointer at function boundaries), so the naming
> > is potentially misleading and possibly worth a comment or rename.
> 
> IIUC ri->rp is used for matching up the frame between the moment we
> install the return trampoline on the stack and actually hitting that
> trampoline.

Hmm, I see (and this is not a new problem with this series, just
existing weirdness).

It looks like that's inconsistently an arch's stack pointer (e.g. x86,
arm64) or frame pointer (e.g. arm). IMO it'd be nicer if we could make
that the stack pointer consistently, but that's a separate cleanup, and
apparently not a big deal.

Thanks,
Mark.
