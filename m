Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4187E38B5AE
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhETSDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 14:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235935AbhETSDH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 14:03:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 000336101D;
        Thu, 20 May 2021 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621533705;
        bh=VuH0uDCYxYFobOO1melI2DB00iQVhYlPjm02AAHgSXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5pc1Px8rzn8IhwbdUoSYWWWejC1TgCV17xBQCMOLjXEBZEjlMswG0AI53R8TGe0X
         ziQotYU6LyAPJ1/oBDH7ifo7/RLwT888UuYvlm+466ewL4txm3yT2R2mlwJNNaNP+s
         pIr5i6APPSQqxaDzIdJ7kuJuwmlENdcwzHN95MSbJahJPoHxpL1tWt57gzvpnBCoTx
         23TZChJjXt/Vd3Mg38fYBq5UFA4yBGqJ71GeAX0DV56PVHsgibamPPt7EeiCVRtrwy
         RlhQXPMc/n1D+1dtPwV3j0/8ST8rCHltHJaZAPVYhx288Wy54PuB8H8j/lNYuutzm1
         gWiPFeRQbu0BQ==
Date:   Thu, 20 May 2021 19:01:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <20210520180138.GA10523@willie-the-truck>
References: <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> On 5/20/21 12:33 PM, Quentin Perret wrote:
> > On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> >> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> >> require admission control to be disabled for sched_setattr() but allow
> >> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> >> is probably similar to CPU hotplug?).
> > 
> > Still not sure that we can let execve go through ... It will break AC
> > all the same, so it should probably fail as well if AC is on IMO
> > 
> 
> If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> the admission control needs to be re-executed, and it could fail. So I see this
> operation equivalent to sched_setaffinity(). This will likely be true for future
> schedulers that will allow arbitrary affinities (AC should run on affinity
> change, and could fail).
> 
> I would vote with Juri: "I'd go with fail hard if AC is on, let it
> pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> complains until we add better support for affinity, and use this as a motivation
> to get back on this front).

I can have a go at implementing it, but I don't think it's a great solution
and here's why:

Failing an execve() is _very_ likely to be fatal to the application. It's
also very likely that the task calling execve() doesn't know whether the
program it's trying to execute is 32-bit or not. Consequently, if we go
with failing execve() then all that will happen is that people will disable
admission control altogether. That has a negative impact on "pure" 64-bit
applications and so I think we end up with the tail wagging the dog because
admission control will be disabled for everybody just because there is a
handful of 32-bit programs which may get executed. I understand that it
also means that RT throttling would be disabled.

Allowing the execve() to continue with a warning is very similar to the
case in which all the 64-bit CPUs are hot-unplugged at the point of
execve(), and this is much closer to the illusion that this patch series
intends to provide.

So, personally speaking, I would prefer the behaviour where we refuse to
admit 32-bit tasks vioa sched_set_attr() if the root domain contains
64-bit CPUs, but we _don't_ fail execve() of a 32-bit program from a
64-bit deadline task.

However, you're the deadline experts so ultimately I'll implement what
you prefer. I just wanted to explain why I think it's a poor interface.

Have I changed anybody's mind?

Will
