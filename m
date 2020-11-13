Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E012B1907
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKMK0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 05:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMK0l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 05:26:41 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F7922245;
        Fri, 13 Nov 2020 10:26:38 +0000 (UTC)
Date:   Fri, 13 Nov 2020 10:26:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <X65fXAo1CK6redfD@trantor>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-3-will@kernel.org>
 <20201111191043.GA5125@gaia>
 <20201113093630.GA21075@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093630.GA21075@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 09:36:30AM +0000, Will Deacon wrote:
> On Wed, Nov 11, 2020 at 07:10:44PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 09, 2020 at 09:30:18PM +0000, Will Deacon wrote:
> > > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > > +{
> > > +	if (!has_cpuid_feature(entry, scope))
> > > +		return allow_mismatched_32bit_el0;
> > 
> > I still don't like overriding the cpufeature mechanism in this way. What about
> > something like below? It still doesn't fit perfectly but at least the
> > capability represents what was detected in the system. We then decide in
> > system_supports_32bit_el0() whether to allow asymmetry. There is an
> > extra trick to park a non-AArch32 capable CPU in has_32bit_el0() if it
> > comes up late and the feature has already been advertised with
> > !allow_mismatched_32bit_el0.
> 
> I deliberately allow late onlining of 64-bit-only cores and I don't think
> this is something we should forbid

I agree and my patch allows this. That's a property of
WEAK_LOCAL_CPUFEATURE.

> (although it's not clear from your patch when
> allow_mismatched_32bit_el0 gets set).

It doesn't, that was meant as a discussion point around the cpufeature
framework but still relying on your other patches for cpumask, cmdline
argument.

> Furthermore, killing CPUs from the matches callback feels _very_ dodgy
> to me, as it's invoked indirectly by things such as
> this_cpu_has_cap().

Yeah, this part is not nice. What we want here is for a late 64-bit only
CPU to be parked if !allow_mismatched_32bit_el0 and we detected 32-bit
already (symmetric).

> > I find it clearer, though I probably stared at it more than at your
> > patch ;).
> 
> Yeah, swings and roundabouts...
> 
> I think we're quibbling on implementation details a bit here whereas we
> should probably be focussing on what to do about execve() and CPU hotplug.

Do we need to solve the execve() problem? If yes, we have to get the
scheduler involved. The hotplug case I think is simpler, just make sure
we have a last standing 32-bit capable CPU, no ABI changes.

For execve(), arguably we don't necessarily break the execve() ABI as
the affinity change may be done later when scheduling the task. But
given that it's a user opt-in for this feature anyway, we just document
the ABI changes.

> Your patch doesn't apply on top of my series or replace this one, so there's
> not an awful lot I can do with it. I'm about to post a v3 with a tentative
> solution for execve(), so please could you demonstrate your idea on top of
> that so I can see how it fits together?

I'll give it a go and if it looks any nicer, I'll post something. As you
say, it's more like personal preference on the implementation details.

On the functional aspects, we must preserve the current behaviour like
detecting symmetry and parking late CPUs if they don't comply in the
!allow_mismatched_32bit_el0 case. In the allow_mismatched_32bit_el0
case, we relax this to the equivalent of a weak feature (either missing
or present for early/late CPUs) but only report 32-bit if we found an
early 32-bit capable CPU (I ended up with a truth table on a piece of
paper).

-- 
Catalin
