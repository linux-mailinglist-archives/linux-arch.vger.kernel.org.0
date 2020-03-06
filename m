Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4017C73D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 21:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFUqB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 15:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFUqA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 15:46:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2313C206CC;
        Fri,  6 Mar 2020 20:45:58 +0000 (UTC)
Date:   Fri, 6 Mar 2020 15:45:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306154556.6a829484@gandalf.local.home>
In-Reply-To: <609624365.20355.1583526166349.JavaMail.zimbra@efficios.com>
References: <20200221133416.777099322@infradead.org>
        <20200221134216.051596115@infradead.org>
        <20200306104335.GF3348@worktop.programming.kicks-ass.net>
        <20200306113135.GA8787@worktop.programming.kicks-ass.net>
        <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
        <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
        <20200306125500.6aa75c0d@gandalf.local.home>
        <609624365.20355.1583526166349.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Mar 2020 15:22:46 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I agree with the overall approach. Just a bit of nitpicking on the API:
> 
> I understand that the "prio" argument is a separate argument because it can take
> many values. However, "rcu" is just a boolean, so I wonder if we should not rather
> introduce a "int flags" with a bitmask enum, e.g.

I thought about this approach, but thought it was a bit overkill. As the
kernel doesn't have an internal API, I figured we can switch this over to
flags when we get another flag to add. Unless you can think of one in the
near future.

> 
> int tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe,
>                                          void *data, int prio, int flags)
> 
> where flags would be populated through OR between labels of this enum:
> 
> enum tracepoint_flags {
>   TRACEPOINT_FLAG_RCU = (1U << 0),
> };
> 
> We can then be future-proof for additional flags without ending up calling e.g.
> 
> tracepoint_probe_register_featurea_featureb_featurec(tp, probe, data, 0, 1, 0, 1)

No, as soon as there is another boolean to add, the rcu version would be
switched to flags. I even thought about making the rcu and prio into one,
and change prio to be a SHRT_MAX max, and have the other 16 bits be for
flags.

-- Steve


> 
> which seems rather error-prone and less readable than a set of flags.

