Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D7255BC1
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1N6V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 09:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1N6L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 09:58:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8925520776;
        Fri, 28 Aug 2020 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598623090;
        bh=SpTHr264Yj5qROOV9l4xhdNrZFLq921O7KsjMz/LhwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i9sl61eavdgFXBk/XhPbbdtnUTUefunlnuMhrscT4UhB4pFLbXw7w5QKEU3zChxrQ
         8Qy782YHhMt06VeOi1Q2dqq4dRAsBx0N039QvWmWDErpIvaiXJV6AGbthFUPsUJoXv
         jL5VYguh/esGbsL0NsDAtVJEsT53PI3PTnVVhbF4=
Date:   Fri, 28 Aug 2020 22:58:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 04/23] arm64: kprobes: Use generic kretprobe
 trampoline handler
Message-Id: <20200828225805.01b685e634c62f99913ddc87@kernel.org>
In-Reply-To: <20200828133718.GB1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861764221.992023.10214437014901668680.stgit@devnote2>
        <20200828133131.GA71981@C02TD0UTHF1T.local>
        <20200828133718.GB1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 15:37:18 +0200
peterz@infradead.org wrote:

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

Yeah, it is confusing, sorry. On x86, CONFIG_FRAME_POINTER can be disabled,
so we used the address of stack entry where arch_prepare_kretprobe() stores
the trampoline address.
For arm64 which doesn't use a stack entry for call, I decided to use the
stack address when the target function is called.
Indeed, it should be commented.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
