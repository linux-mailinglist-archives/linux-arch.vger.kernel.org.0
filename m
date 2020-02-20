Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E857316589A
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 08:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBTHkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 02:40:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgBTHkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 02:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TtE3mlL5t0f9qnTzN7/JiHJ/6OUI4BCT1mqa2/farcY=; b=2CTht/UP19chea61+8j2T0TbdB
        gmcz+vagWKsoDDg5x/HshwlgWGMnt5LofDcxxWMqkbTSefaRXyZvA8ADzB3Q7ayxHACgFhGq4vMhd
        qIG/5mANVsp25mEC/YPw3csAfpSpyhS+o++k+4Hg37dmX1nqVf3q/m/B3HPE/aoP1UyJ+QJEk5wyS
        CRbGb/a3U9WM2OmfjuWJze2L8g1Q/jf3EW129qQPVexfAbPqON5sPLuHIQkWGNi93lBalOZCfLDpQ
        um7Kdmxrrkoe8hmT9VCSqYzdfjbgtPbApBxiOqqYVF+mCct/J6+YkMg3u5mA6/zCq2pFMneSAGQug
        6iUsIfrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4gQb-0007Nh-Jz; Thu, 20 Feb 2020 07:39:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69E16305E21;
        Thu, 20 Feb 2020 08:37:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25E5120AFA9A9; Thu, 20 Feb 2020 08:39:18 +0100 (CET)
Date:   Thu, 20 Feb 2020 08:39:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Message-ID: <20200220073918.GR18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
 <20200219173358.GP18400@hirez.programming.kicks-ass.net>
 <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 02:12:13PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 19, 2020 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Do you really want to create code that unwinds enough of nmi_enter() to
> > get you to a preemptible context? *shudder*
> 
> Well, there's another way to approach this:
> 
> void notrace nonothing do_machine_check(struct pt_regs *regs)
> {
>   if (user_mode(regs))
>     do_sane_machine_check(regs);
>   else
>     do_awful_machine_check(regs);
> }
> 
> void do_sane_machine_check(regs)
> {
>   nothing special here.  just a regular exception, more or less.
> }
> 
> void do_awful_macine_check(regs)
> {
>   basically an NMI.  No funny business, no recovery possible.
> task_work_add() not allowed.
> }

Right, that looks like major surgery to the current code though; I'd
much prefer someone that knows that code do that.

> I suppose the general consideration I'm trying to get at is: is
> task_work_add() actually useful at all here?  For the case when a
> kernel thread does memcpy_mcsafe() or similar, task work registered
> using task_work_add() will never run.

task_work isn't at all useful when we didn't come from userspace. In
that case irq_work is the best option, but that doesn't provide a
preemptible context.
