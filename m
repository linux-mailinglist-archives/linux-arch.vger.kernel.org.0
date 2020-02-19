Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550DB164B6E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSRFW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRFW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:05:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9AF2464E;
        Wed, 19 Feb 2020 17:05:20 +0000 (UTC)
Date:   Wed, 19 Feb 2020 12:05:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove()
 notrace/NOKPROBE
Message-ID: <20200219120519.22ba89c4@gandalf.local.home>
In-Reply-To: <20200219162747.GX2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.604459293@infradead.org>
        <20200219103614.2299ff61@gandalf.local.home>
        <20200219154031.GE18400@hirez.programming.kicks-ass.net>
        <20200219155715.GD14946@hirez.programming.kicks-ass.net>
        <20200219160442.GE14946@hirez.programming.kicks-ass.net>
        <20200219111228.44c2999b@gandalf.local.home>
        <20200219162747.GX2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 08:27:47 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Or, we could just cut and paste the current memmove and make a notrace
> > version too. Then we don't need to worry bout bugs like this.  
> 
> OK, I will bite...
> 
> Can we just make the core be an inline function and make a notrace and
> a trace caller?  Possibly going one step further and having one call
> the other?  (Presumably the traceable version invoking the notrace
> version, but it has been one good long time since I have looked at
> function preambles.)

Sure. Looking at the implementation (which is big and ugly), we could
have a

static always_inline void __memmove(...)
{
	[..]
}

__visible void *memmove(...)
{
	return __memmove(...);
}

__visible notrace void *memmove_notrace(...)
{
	return __memmove(...);
}

-- Steve
