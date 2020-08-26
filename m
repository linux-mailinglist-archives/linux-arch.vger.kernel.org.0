Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752552532C3
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZPEL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 11:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgHZPEJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 11:04:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93EC2074A;
        Wed, 26 Aug 2020 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598454248;
        bh=3J4mlmGUq1KCPpFx1r6FI0kJrGpq/S7RWK+kHz81TpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XyvtMHNPkPQjD7r9bPd9dMGa6i3xyNx47rwSOyUsRAGz29Ke3pP5vWAN81hwY80Zi
         gID4L7ry9yfxnfikfc+R4CEzwI/z79nVj1FJdSyi/QTLLLYIQLcAK1mdRNWvMGafK2
         VE7g0A2stU+EJHTUDBlQE+dVKAHWqc6wSr+LfpM4=
Date:   Thu, 27 Aug 2020 00:04:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] arm: kprobes: Use generic kretprobe
 trampoline handler
Message-Id: <20200827000405.60aa815dbb6f1417dc9da867@kernel.org>
In-Reply-To: <20200826141025.GU35926@hirez.programming.kicks-ass.net>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
        <159844960343.510284.15315372011917043979.stgit@devnote2>
        <20200826140852.GG1362448@hirez.programming.kicks-ass.net>
        <20200826141025.GU35926@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 26 Aug 2020 16:10:25 +0200
peterz@infradead.org wrote:

> On Wed, Aug 26, 2020 at 04:08:52PM +0200, peterz@infradead.org wrote:
> > On Wed, Aug 26, 2020 at 10:46:43PM +0900, Masami Hiramatsu wrote:
> > >  static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
> > >  {
> > > +	return (void *)kretprobe_trampoline_handler(regs,
> > > +				(unsigned long)&kretprobe_trampoline,
> > > +				regs->ARM_fp);
> > >  }
> > 
> > Does it make sense to have the generic code have a weak
> > trampoline_handler() implemented like the above? It looks like a number
> > of architectures have this trivial variant and it seems pointless to
> > duplicate this.
> 
> Argh, I replied to the wrong variant, I mean the one that uses
> kernel_stack_pointer(regs).

Would you mean using kernel_stack_pointer() for the frame_pointer?
Some arch will be OK, but others can not get the framepointer by that.
(that is because the stack layout is different on the function prologue
and returned address, e.g. x86...)

> 
> Then the architecture only needs to implement kernel_stack_pointer() if
> there is nothing else to do.

There are 2 patterns of kretprobe trampoline handling, one is using
a kprobe which hooks the trampoline code. In this case, the
trampoline handler is a kprobe pre_handler. And another is not
using kprobe, but trampoline code saves (a part of)pt_regs and call
the trampoline handler. In this case the trampoline handler will get
the (maybe incomplete) pt_regs. Actually, arm kretprobe handler doesn't
save the sp register for some reason...

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
