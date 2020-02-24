Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64016B37F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 23:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBXWCf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 17:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgBXWCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 17:02:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B6F20CC7;
        Mon, 24 Feb 2020 22:02:33 +0000 (UTC)
Date:   Mon, 24 Feb 2020 17:02:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200224170231.3807931d@gandalf.local.home>
In-Reply-To: <20200224213139.GO11457@worktop.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.328642621@infradead.org>
        <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
        <20200221202246.GA14897@hirez.programming.kicks-ass.net>
        <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
        <20200224112708.4f307ba3@gandalf.local.home>
        <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
        <20200224114754.0fb798c1@gandalf.local.home>
        <20200224213139.GO11457@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 24 Feb 2020 22:31:39 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Just want to confirm that printk_nmi_enter(), lockdep_off(),
> > and ftrace_nmi_enter() are all marked fully with NOKPROBE.  
> 
> *sigh*, right you are, I only looked at notrace, not nokprobe.
> 
> In particular the ftrace one is a bit off a mess, let me sort through
> that.

ftrace_nmi_enter() has two purposes. One, for archs that need to deal with
NMIs while they still use stop machine. Although, it appears sh is the only
arch that does that. I can look to see if it can be ripped out.

The other is for the hwlat detector that measures the time it was in an
NMI, as NMIs appear as a hardware latency too.

-- Steve
