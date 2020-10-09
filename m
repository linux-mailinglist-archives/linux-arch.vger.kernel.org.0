Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5328865F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbgJIJvR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 05:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIJvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 05:51:17 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C1B2225D;
        Fri,  9 Oct 2020 09:51:15 +0000 (UTC)
Date:   Fri, 9 Oct 2020 10:51:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009095112.GE23638@gaia>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
 <20201009092559.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009092559.GE2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 11:25:59AM +0200, Peter Zijlstra wrote:
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

Another thought: should the arm64 compat_elf_check_arch() and
sys_arm64_personality(PER_LINUX32) validate the user cpumask before
returning success/failure? It won't prevent the user from changing the
affinity at run-time but at least it won't randomly get killed just
because the kernel advertises 32-bit support.

-- 
Catalin
