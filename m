Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8C2CA91F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbgLAQ5K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392189AbgLAQ5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED51208FE;
        Tue,  1 Dec 2020 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841789;
        bh=g3X3ttP3AwCBVr8F5vieRLoKEI3HdmrwGG8BQB3NfyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySzyQkKm6yR3vZvsp0wlY8TIKOrpgzGkQX1U5nGecPhgodrD9cowBALu8935/+nSD
         qtatbNsSWuaHIyZi5TiK2AFdgcuxlt6IdBoPOdFQ3CVqyZUlttmfEz9XGX3d23LnMu
         Vy1g9BW8884IkjFJ4FtFXV6NAQULalRWc6aEf3qM=
Date:   Tue, 1 Dec 2020 16:56:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 02/14] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201201165621.GB27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-3-will@kernel.org>
 <20201127130941.pr3grbcir6jdtzwa@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127130941.pr3grbcir6jdtzwa@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 01:09:41PM +0000, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> > When confronted with a mixture of CPUs, some of which support 32-bit
> 
> Confronted made me laugh, well chosen word! :D
> 
> For some reason made me think of this :p
> 
> 	https://www.youtube.com/watch?v=NJbXPzSPzxc&t=1m33s

I think it just about sums it up!

> > applications and others which don't, we quite sensibly treat the system
> > as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> > 
> > Unfortunately, some crazy folks have decided to build systems like this
> > with the intention of running 32-bit applications, so relax our
> > sanitisation logic to continue to advertise 32-bit support to userspace
> > on these systems and track the real 32-bit capable cores in a cpumask
> > instead. For now, the default behaviour remains but will be tied to
> > a command-line option in a later patch.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpucaps.h    |   2 +-
> >  arch/arm64/include/asm/cpufeature.h |   8 ++-
> >  arch/arm64/kernel/cpufeature.c      | 106 ++++++++++++++++++++++++++--
> >  3 files changed, 107 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > index e7d98997c09c..e6f0eb4643a0 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -20,7 +20,7 @@
> >  #define ARM64_ALT_PAN_NOT_UAO			10
> >  #define ARM64_HAS_VIRT_HOST_EXTN		11
> >  #define ARM64_WORKAROUND_CAVIUM_27456		12
> > -#define ARM64_HAS_32BIT_EL0			13
> > +#define ARM64_HAS_32BIT_EL0_DO_NOT_USE		13
> 
> nit: would UNUSED be better here? Worth adding a comment as to why too?

UNUSED sounds like you could delete it, but I'll add a comment.

> >  #define ARM64_HARDEN_EL2_VECTORS		14
> >  #define ARM64_HAS_CNP				15
> >  #define ARM64_HAS_NO_FPSIMD			16
> 
> [...]
> 
> > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > +{
> > +	if (!has_cpuid_feature(entry, scope))
> > +		return allow_mismatched_32bit_el0;
> 
> If a user passes the command line by mistake on a 64bit only system, this will
> return true. I'll be honest, I'm not entirely sure what the impact is. I get
> lost in the features maze. It is nicely encapsulated, but hard to navigate for
> the none initiated :-)

The thing is, we can't generally detect a 64-bit-only system because a
32-bit-capable CPU could be hotplugged on late. So passing this option
just controls what the behaviour is at the point that the 32-bit-capable
CPU appears. If one doesn't appear, then there won't be a difference.

Will
