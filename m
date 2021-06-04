Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6639B8AD
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFDMG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 08:06:26 -0400
Received: from foss.arm.com ([217.140.110.172]:37578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDMG0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 08:06:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ADBF2B;
        Fri,  4 Jun 2021 05:04:40 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51AD43F73D;
        Fri,  4 Jun 2021 05:04:35 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:04:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20210604120352.GA67240@C02TD0UTHF1T.local>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-3-will@kernel.org>
 <20210603123715.GA48596@C02TD0UTHF1T.local>
 <20210603174413.GC1170@willie-the-truck>
 <20210604093808.GA64162@C02TD0UTHF1T.local>
 <20210604110526.GF2318@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604110526.GF2318@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:05:27PM +0100, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 10:38:08AM +0100, Mark Rutland wrote:
> > On Thu, Jun 03, 2021 at 06:44:14PM +0100, Will Deacon wrote:
> > > On Thu, Jun 03, 2021 at 01:37:15PM +0100, Mark Rutland wrote:
> > > > On Wed, Jun 02, 2021 at 05:47:02PM +0100, Will Deacon wrote:
> > > > > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h

> > > > That said. I reckon this could be much cleaner if we maintained separate
> > > > caps:
> > > > 
> > > > ARM64_ALL_CPUS_HAVE_32BIT_EL0
> > > > ARM64_SOME_CPUS_HAVE_32BIT_EL0
> > > > 
> > > > ... and allow arm64_mismatched_32bit_el0 to be set dependent on
> > > > ARM64_SOME_CPUS_HAVE_32BIT_EL0. With that, this can be simplified to:
> > > > 
> > > > static inline bool system_supports_32bit_el0(void)
> > > > {
> > > > 	return (cpus_have_const_cap(ARM64_ALL_CPUS_HAVE_32BIT_EL0)) ||
> > > > 		static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > > 
> > > Something similar was discussed in November last year but this falls
> > > apart with late onlining because its not generally possible to tell whether
> > > you've seen all the CPUs or not.
> > 
> > Ah; is that for when your boot CPU set is all AArch32-capable, but a
> > late-onlined CPU is not?
> > 
> > I assume that we require at least one of the set of boot CPUs to be
> > AArch32 cpable, and don't settle the compat hwcaps after userspace has
> > started.
> 
> Heh, you assume wrong :)
> 
> When we allow the mismatch, then we do actually defer initialisation of
> the compat hwcaps until we see a 32-bit CPU. That's fine, as they won't
> be visible to userspace until then anyway (PER_LINUX32 is unavailable).

That sounds quite scary, to me, though I don't have a concrete problem
to hand. :/

Do we really need to support initializing that so late? For all other
caps we've settled things when the boot CPUs come up, and it's
unfortunate to have to treat this differently.

I'll go see if there's anything that's liable to break today.

Thanks,
Mark
