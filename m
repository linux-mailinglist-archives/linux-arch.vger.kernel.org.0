Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF815D093
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 04:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBNDc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 22:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDc5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 22:32:57 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22493217F4;
        Fri, 14 Feb 2020 03:32:56 +0000 (UTC)
Date:   Thu, 13 Feb 2020 22:32:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Message-ID: <20200213223254.668a340d@oasis.local.home>
In-Reply-To: <20200214024244.GH36551@google.com>
References: <20200212210139.382424693@infradead.org>
        <20200212210750.312024711@infradead.org>
        <20200214022839.GG36551@google.com>
        <20200214024244.GH36551@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Feb 2020 11:42:45 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > +++ b/kernel/trace/trace_event_perf.c
> > > @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
> > >  {
> > >  	struct ftrace_ops *ops = &event->ftrace_ops;
> > >  
> > > -	ops->flags   = FTRACE_OPS_FL_RCU;
> > > +	ops->flags   = 0;  
> > 
> > FTRACE_OPS_FL_ENABLED?  
> 
> No, never mind.

:-)

-- Steve
