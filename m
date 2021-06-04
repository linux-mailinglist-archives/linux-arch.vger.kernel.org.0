Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6F39BA3D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFDNw1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 09:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhFDNw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 09:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32DF9613C9;
        Fri,  4 Jun 2021 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622814640;
        bh=K/GY5g+siZhU8v4b9BjhoSm+Dq5y6/LVafctSr5ng7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuGi9PZakCL+fNw4WVIFTAUpGmeNIybdPOKJFFJC5ku5rdXeW5h+ZX58GLu00B9OY
         i2NrTyCO0YUn2C6PUJ+Td35BwvFrRUm9PjzSK48kXJ29qsVs4fp1JDGeF5r6D1c4WI
         cbwEWgvAFyHboCzZIyKX08XxYOWRNy6PQN/ZGWVFcSe77GLdBQ5LW29xFevZodXr6L
         LHsaZ5JJXGqq/n7ygGIRolH2hOF4JjgRd+Vww5zMG0rAM1kngHUZI3RT2RpNpQX3kR
         T46/bL7CIVZDfkVWxXa3KObEC5CIEaX/6nY+7+VJttaovuoSFQuthSUupnhdppyly6
         NrIFRbX8xMM8A==
Date:   Fri, 4 Jun 2021 14:50:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 02/19] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210604135033.GB2793@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-3-will@kernel.org>
 <20210603123715.GA48596@C02TD0UTHF1T.local>
 <20210603174413.GC1170@willie-the-truck>
 <20210604093808.GA64162@C02TD0UTHF1T.local>
 <20210604110526.GF2318@willie-the-truck>
 <20210604120352.GA67240@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604120352.GA67240@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 01:04:27PM +0100, Mark Rutland wrote:
> On Fri, Jun 04, 2021 at 12:05:27PM +0100, Will Deacon wrote:
> > On Fri, Jun 04, 2021 at 10:38:08AM +0100, Mark Rutland wrote:
> > > On Thu, Jun 03, 2021 at 06:44:14PM +0100, Will Deacon wrote:
> > > > On Thu, Jun 03, 2021 at 01:37:15PM +0100, Mark Rutland wrote:
> > > > > On Wed, Jun 02, 2021 at 05:47:02PM +0100, Will Deacon wrote:
> > > > > > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> 
> > > > > That said. I reckon this could be much cleaner if we maintained separate
> > > > > caps:
> > > > > 
> > > > > ARM64_ALL_CPUS_HAVE_32BIT_EL0
> > > > > ARM64_SOME_CPUS_HAVE_32BIT_EL0
> > > > > 
> > > > > ... and allow arm64_mismatched_32bit_el0 to be set dependent on
> > > > > ARM64_SOME_CPUS_HAVE_32BIT_EL0. With that, this can be simplified to:
> > > > > 
> > > > > static inline bool system_supports_32bit_el0(void)
> > > > > {
> > > > > 	return (cpus_have_const_cap(ARM64_ALL_CPUS_HAVE_32BIT_EL0)) ||
> > > > > 		static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > > > 
> > > > Something similar was discussed in November last year but this falls
> > > > apart with late onlining because its not generally possible to tell whether
> > > > you've seen all the CPUs or not.
> > > 
> > > Ah; is that for when your boot CPU set is all AArch32-capable, but a
> > > late-onlined CPU is not?
> > > 
> > > I assume that we require at least one of the set of boot CPUs to be
> > > AArch32 cpable, and don't settle the compat hwcaps after userspace has
> > > started.
> > 
> > Heh, you assume wrong :)
> > 
> > When we allow the mismatch, then we do actually defer initialisation of
> > the compat hwcaps until we see a 32-bit CPU. That's fine, as they won't
> > be visible to userspace until then anyway (PER_LINUX32 is unavailable).
> 
> That sounds quite scary, to me, though I don't have a concrete problem
> to hand. :/
> 
> Do we really need to support initializing that so late? For all other
> caps we've settled things when the boot CPUs come up, and it's
> unfortunate to have to treat this differently.

I think it's the nature of the beast, unfortunately. Since we're talking
about multiple generations of SoCs rather than just one oddball design,
then placing artificial restrictions on the boot CPUs doesn't feel like
it will last very long.

> I'll go see if there's anything that's liable to break today.

Please let me know if you find anything.

Will
