Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A98938ABBF
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbhETL1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 07:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241733AbhETLZZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 07:25:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3B0F61441;
        Thu, 20 May 2021 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621505807;
        bh=CNpVJE3RYe0c2aFu09c+Q6PiGWS30OlaJEezwJN5FyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrifPBqYl97wkhjbu0C1WYT9XYbJjq+dXoI+goHcgUxbOBMCkgHSIsisXCGHCOd+V
         9/uDX4pWVsJ7/4gWYua6WQVnoGsvGfjpiyHgLrip0Ay+I2hEeUhPlS6eg4DN/EJcxP
         7rZmpiAAd+XuFWzPCOjETwtSjwyDHowF/0jg6o/bLN33iPLVZ7ifjVWL7eGyMgWbyt
         oDr4uaXemk29XsbKlTVtc3nYo5ab8p8pKnb1b4DPU9ROo8CkEhsClmJQMjC0CVZSeR
         CO3xRolOhRwpZF5fbmXPQnseN22EwZ7LRA/n9nJ8q3Bjefs1a5XEKGQQ9Tmct08R1F
         22q60Emo0Zkqw==
Date:   Thu, 20 May 2021 11:16:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Quentin Perret <qperret@google.com>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <20210520101640.GA10065@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYoQ0ezahSC/RAg@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Juri,

On Thu, May 20, 2021 at 11:13:39AM +0200, Juri Lelli wrote:
> Apologies for the delay in replying.

Not at all!

> On 18/05/21 13:19, Quentin Perret wrote:
> > On Tuesday 18 May 2021 at 11:59:51 (+0100), Will Deacon wrote:
> > > On Tue, May 18, 2021 at 10:48:07AM +0000, Quentin Perret wrote:
> > > > On Tuesday 18 May 2021 at 11:28:34 (+0100), Will Deacon wrote:
> > > > > I don't have strong opinions on this, but I _do_ want the admission via
> > > > > sched_setattr() to be consistent with execve(). What you're suggesting
> > > > > ticks that box, but how many applications are prepared to handle a failed
> > > > > execve()? I suspect it will be fatal.
> > > > 
> > > > Yep, probably.
> > > > 
> > > > > Probably also worth pointing out that the approach here will at least
> > > > > warn in the execve() case when the affinity is overridden for a deadline
> > > > > task.
> > > > 
> > > > Right so I think either way will be imperfect, so I agree with the
> > > > above.
> > > > 
> > > > Maybe one thing though is that, IIRC, userspace _can_ disable admission
> > > > control if it wants to. In this case I'd have no problem with allowing
> > > > this weird behaviour when admission control is off -- the kernel won't
> > > > provide any guarantees. But if it's left on, then it's a different
> > > > story.
> > > > 
> > > > So what about we say, if admission control is off, we allow execve() and
> > > > sched_setattr() with appropriate warnings as you suggest, but if
> > > > admission control is on then we fail both?
> > > 
> > > That's an interesting idea. The part that I'm not super keen about is
> > > that it means admission control _also_ has an effect on the behaviour of
> > > execve()
> > 
> > Right, that's a good point. And it looks like fork() behaves the same
> > regardless of admission control being enabled or not -- it is forbidden
> > from DL either way. So I can't say there is a precedent :/
> > 
> > > so practically you'd have to have it disabled as long as you
> > > have the possibility of 32-bit deadline tasks anywhere in the system,
> > > which impacts 64-bit tasks which may well want admission control enabled.
> > 
> > Indeed, this is a bit sad, but I don't know if the kernel should pretend
> > it can guarantee to meet your deadlines and at the same time allow to do
> > something that wrecks the underlying theory.
> > 
> > I'd personally be happy with saying that admission control should be
> > disabled on these dumb systems (and have that documented), at least
> > until DL gets proper support for affinities. ISTR there was work going
> > in that direction, but some folks in the CC list will know better.
> > 
> > @Juri, maybe you would know if that's still planned?
> 
> I won't go as far as saying planned, but that is still under "our" radar
> for sure. Daniel was working on it, but I don't think he had any time to
> resume that bit of work lately.
> 
> So, until we have that, I think we have been as conservative as we could
> for this type of decisions. I'm a little afraid that allowing
> configuration to break admission control (even with a non fatal warning
> is emitted) is still risky. I'd go with fail hard if AC is on, let it
> pass if AC is off (supposedly the user knows what to do). But I'm not
> familiar with the mixed 32/64 apps usecase you describe, so I might be
> missing details.

Ok, thanks for the insight. In which case, I'll go with what we discussed:
require admission control to be disabled for sched_setattr() but allow
execve() to a 32-bit task from a 64-bit deadline task with a warning (this
is probably similar to CPU hotplug?).

I'll update that for v8, and this patch will disappear.

Will
