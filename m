Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA8288613
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbgJIJjx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 05:39:53 -0400
Received: from foss.arm.com ([217.140.110.172]:46158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgJIJjw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 05:39:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BEED6E;
        Fri,  9 Oct 2020 02:39:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D177F3F66B;
        Fri,  9 Oct 2020 02:39:50 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:39:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009093948.jqaw5oepotggrev5@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
 <20201009092559.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009092559.GE2628@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/20 11:25, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 10:13:12AM +0200, Morten Rasmussen wrote:
> > On Fri, Oct 09, 2020 at 09:29:43AM +0200, Peter Zijlstra wrote:
> 
> > > Fundamentally, you're not supposed to change the userspace provided
> > > affinity mask. If we want to do something like this, we'll have to teach
> > > the scheduler about this second mask such that it can compute an
> > > effective mask as the intersection between the 'feature' and user mask.
> > 
> > I agree that we shouldn't mess wit the user-space mask directly. Would it
> > be unthinkable to go down the route of maintaining a new mask which is
> > the intersection of the feature mask (controlled and updated by arch
> > code) and the user-space mask?
> > 
> > It shouldn't add overhead in the scheduler as it would use the
> > intersection mask instead of the user-space mask, the main complexity
> > would be around making sure the intersection mask is updated correctly
> > (cpusets, hotplug, ...).
> 
> IFF we _need_ to go there, then yes that was the plan, compose the
> intersection when either the (arch) feature(set) mask or the userspace
> mask changes.

On such systems these tasks are only valid to run on a subset of cpus. It makes
a lot of sense to me if we want to go down that route to fixup the affinity
when a task is spawned and make sure sched_setaffinity() never allows it to go
outside this range. The tasks can't physically run on those cpus, so I don't
see us breaking user-space affinity here. Just reflecting the reality.

Only if it moved to a cpuset with no intersection it would be killed. Which
I think is the behavior anyway today.

Thanks

--
Qais Yousef
