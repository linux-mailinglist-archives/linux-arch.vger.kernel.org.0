Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25E2B9839
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgKSQjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgKSQjg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:39:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F288D2220B;
        Thu, 19 Nov 2020 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605803975;
        bh=M+kNcVmgZDYx9/XBbh47SkB+8hU/YO4GMxDOKxbKuBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoOlcSvldEoYJaIMOCSULQUSD80i3+NbGdDZG2nY6iHp5pNC4I9LUAnGAinnxtl4f
         7f1V3LDx2osEyhUeP0Kkx3gz6/BltwwCqzJobo7nf+By2d5n+ub9kuVHo8kxcijdOc
         V/1ovyniJzscos2uhY0+wCVoZHZ6tl5kMFaVX5n4=
Date:   Thu, 19 Nov 2020 16:39:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 00/14] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201119163928.GC4582@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201119161127.GQ3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119161127.GQ3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 05:11:27PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 13, 2020 at 09:37:05AM +0000, Will Deacon wrote:
> 
> > The aim of this series is to allow 32-bit ARM applications to run on
> > arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> > 
> > There are some major changes in v3:
> > 
> >   * Add some scheduler hooks for restricting a task's affinity mask
> >   * Implement these hooks for arm64 so that we can avoid 32-bit tasks
> >     running on 64-bit-only cores
> >   * Restrict affinity mask of 32-bit tasks on execve()
> >   * Prevent hot-unplug of all 32-bit CPUs if we have a mismatched system
> >   * Ensure 32-bit EL0 cpumask is zero-initialised (oops)
> > 
> > It's worth mentioning that this approach goes directly against my
> > initial proposal for punting the affinity management to userspace,
> > because it turns out that doesn't really work. There are cases where the
> > kernel has to muck with the affinity mask explicitly, such as execve(),
> > CPU hotplug and cpuset balancing. Ensuring that these don't lead to
> > random SIGKILLs as far as userspace is concerned means avoiding any
> 
> Mooo, I thought we were okay with that... Use does stupid, user gets
> SIGKIL. What changed?

See my other reply, but there are 64-bit apps that execve() a 32-bit
payload. I was hoping this could be handling in the C library, but that
has no idea about what it's exec'ing beyond the path.

Will
