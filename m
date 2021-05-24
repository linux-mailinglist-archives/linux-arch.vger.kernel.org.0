Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6A38F48F
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 22:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhEXUsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 16:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233183AbhEXUsl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 16:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 053B961405;
        Mon, 24 May 2021 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621889233;
        bh=UgjQUQLFaMWyKj6Zcvq2RbMKVtls6JxUFa1a/1pBQ0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmJw8NGKyGMgFxlc0lX9EYXvjA5+XvjYQ2D4Zu+nqkxRHcDppn8oRJgDQ3PDFz7OO
         yykoE128gO8ILMXjJb0gFQKGqTLClSfdJ+//io7qhCydw6Lk96ueXWs3giEmFS8AzZ
         4Vc/RQtNUGFdEMKUVB/mLUNMhU8JphsWgmNJU8nt8+4KKkazRQUeCYQGRTwEiZ966B
         sbhQqxhQln/+12J0jqml3wRpjinRDCnO1ZUDewyv2ooaXqyZSGPZ1fN4ZXAJcK/xc1
         t6uKIF68FC6c5PW7syyfdjPLwtKBS0n1ZwF3XC89EbPrw7w/7x7qs+IUBQ+kI6z0Y3
         VxKFQmJYLg8aA==
Date:   Mon, 24 May 2021 21:47:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <20210524204706.GE15545@willie-the-truck>
References: <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
 <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 03:00:42PM +0200, Daniel Bristot de Oliveira wrote:
> On 5/21/21 12:37 PM, Will Deacon wrote:
> > Interesting, thanks. Thinking about this some more, it strikes me that with
> > these silly asymmetric systems there could be an interesting additional
> > problem with hotplug and deadline tasks. Imagine the following sequence of
> > events:
> > 
> >   1. All online CPUs are 32-bit-capable
> >   2. sched_setattr() admits a 32-bit deadline task
> >   3. A 64-bit-only CPU is onlined
> 
> At the point 3, the global scheduler assumption is broken. For instance, in a
> system with four CPUs and five ready 32-bit-capable tasks, when the fifth CPU as
> added, the working conserving rule is violated because the five highest priority
> thread are not running (only four are) :-(.
> 
> So, at this point, for us to keep to the current behavior, the addition should
> be.. blocked? :-((
> 
> >   4. Some of the 32-bit-capable CPUs are offlined
> 
> Assuming that point 3 does not exist (i.e., all CPUs are 32-bit-capable). At
> this point, we will have an increase in the pressure on the 32-bit-capable CPUs.
> 
> This can also create bad effects for 64-bit tasks, as the "contended" 32-bit
> tasks will still be "queued" in a future time where they were supposed to be
> done (leaving time for the 64-bit tasks).

That's a really interesting point that I hadn't previously considered. It
means that the effects of 32-bit tasks with forced affinity are far
reaching when it comes to deadline tasks.

> > I wonder if we can get into a situation where we think we have enough
> > bandwidth available, but in reality the 32-bit task is in trouble because
> > it can't make use of the 64-bit-only CPU.
> 
> I would have to think more, but there might be a case where this contended
> 32-bit tasks could cause deadline misses for the 64-bit too.
> 
> > If so, then it seems to me that admission control is really just
> > "best-effort" for 32-bit deadline tasks on these systems because it's based
> > on a snapshot in time of the available resources.
> 
> The admission test as is now is "best-effort" in the sense that it allows a
> workload higher than it could handle (it is necessary, but not sufficient AC).
> But it should not be considered "best-effort" because of violations in the
> working conserving property as a result of arbitrary affinities among tasks.
> Overall, we have been trying to close any "exception left" to this later case.
> 
> I know, it is a complex situation, I am just trying to illustrate our concerns,
> because, in the near future we might have a scheduler that handles arbitrary
> affinity correctly. But that might require us to stick to an AC. The AC is
> something precious for us.

I've implemented AC on execve() of a 32-bit program so we'll fail that system
call with -ENOEXEC if the root domain contains 64-bit-only CPUs. As expected,
the failure mode is awful because it seems as though the ELF binary is then
treated like a shell script by userspace and passed to /bin/sh:

$ sudo chrt -d -T 5000000 -P 16666666 0 ./hello32
./hello32: 1: Syntax error: word unexpected (expecting ")")

Anyway, I'll include this in v7.

Cheers,

Will
