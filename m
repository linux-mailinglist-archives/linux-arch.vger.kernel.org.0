Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D897387701
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbhERLBQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 07:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348192AbhERLBP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 07:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 345F661285;
        Tue, 18 May 2021 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621335598;
        bh=GAu4rojTdKt4OvWm/lfPAfaF+P0Bv2/Zuy8m9Dpr8Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTvC5ILgSDMPBB8Q9/Fxmdl3wZl2k2z0lugQX1WTE6EO+qimQX0L2JoXL0BQ++6XT
         Rv2RQVPF0QOZxJsiIzJmcoIBI8/qdm6AxvyJExYfMwqoawA2Iqg74sZDL0ytyt5vDD
         HZa3gQhf2m+scTQtuvvpcDLjfUEdalI2Gov/1/rMQNQLu+aYInC5QOy7tb6qqyke6e
         R/A1hui4xM2JA4lki0nnUaiUaLWVQ8Q7xnGGSwdvkwIy3GW7xjbTUntn4dR3uOOg5j
         n63+dCR7pS6yDz6/NAXlT5KcX5jS93daKIuB34/x0mVvwiSKeixbtMpGuPxYm9CE6a
         q7IrFG7a2UZuA==
Date:   Tue, 18 May 2021 11:59:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <20210518105951.GC7770@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKObZ1GcfVIVWRWt@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:48:07AM +0000, Quentin Perret wrote:
> On Tuesday 18 May 2021 at 11:28:34 (+0100), Will Deacon wrote:
> > I don't have strong opinions on this, but I _do_ want the admission via
> > sched_setattr() to be consistent with execve(). What you're suggesting
> > ticks that box, but how many applications are prepared to handle a failed
> > execve()? I suspect it will be fatal.
> 
> Yep, probably.
> 
> > Probably also worth pointing out that the approach here will at least
> > warn in the execve() case when the affinity is overridden for a deadline
> > task.
> 
> Right so I think either way will be imperfect, so I agree with the
> above.
> 
> Maybe one thing though is that, IIRC, userspace _can_ disable admission
> control if it wants to. In this case I'd have no problem with allowing
> this weird behaviour when admission control is off -- the kernel won't
> provide any guarantees. But if it's left on, then it's a different
> story.
> 
> So what about we say, if admission control is off, we allow execve() and
> sched_setattr() with appropriate warnings as you suggest, but if
> admission control is on then we fail both?

That's an interesting idea. The part that I'm not super keen about is
that it means admission control _also_ has an effect on the behaviour of
execve(), so practically you'd have to have it disabled as long as you
have the possibility of 32-bit deadline tasks anywhere in the system,
which impacts 64-bit tasks which may well want admission control enabled.

So perhaps my initial position of trying to keep sched_setattr() and
execve() consistent with each other is flawed and actually we can say:

  * Disable admission control if you want to admit a 32-bit task explicitly
    via sched_setattr()

  * If a 64-bit deadline task execve()s a 32-bit program then we warn
    and override the affinity (i.e. you should avoid doing this if you
    care about the deadlines).

That amounts to dropping this patch and tweaking the documentation.

Dunno, what do you think?

Will
