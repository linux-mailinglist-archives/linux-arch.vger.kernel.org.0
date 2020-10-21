Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7E294FEA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502329AbgJUPXS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 11:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502303AbgJUPXS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 11:23:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798252177B;
        Wed, 21 Oct 2020 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603293797;
        bh=80+F/rS39OaAv82faW86LFYzPhStpfh5kVT+wc50cTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ne6+cBPy7G0QjkpVV/vRlit89BKDZur0WUpbxJqgk0c6u5vuOVw71i+SsDVbpF5uP
         QX1OQBDkBRc5P+27/Y7bJ7SS2ej+gbo9584uXnefw6bBUAmpURIYr1FivQXSysBX2f
         T0mhfYcuwUAmBbBd7YLWB8gj+w24BVGrvjGrAq1g=
Date:   Wed, 21 Oct 2020 16:23:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021152310.GA18071@willie-the-truck>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021150313.ecxawwxsowweye43@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 04:03:13PM +0100, Qais Yousef wrote:
> On 10/21/20 15:41, Will Deacon wrote:
> > On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > > On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> > > > On 2020-10-21 11:46, Qais Yousef wrote:
> > > > > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > > > > printed out
> > > > > although it's set as FTR_HIDDEN.
> > > > > 
> > > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 
> > > > > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > > > > 
> > > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > > 0x0000000000000012
> > > > > 0x0000000000000012
> > > > > 0x0000000000000011
> > > > > 0x0000000000000011
> > > > 
> > > > This looks like a terrible userspace interface. It exposes unrelated
> > > > features,
> > > 
> > > Not sure why the EL1 field ended up in here, that's not relevant to the
> > > user.
> > > 
> > > > and doesn't expose the single useful information that the kernel has:
> > > > the cpumask describing the CPUs supporting  AArch32 at EL0. Why not expose
> > > > this synthetic piece of information which requires very little effort from
> > > > userspace and doesn't spit out unrelated stuff?
> > > 
> > > I thought the whole idea is to try and avoid the "very little effort"
> > > part ;).
> > > 
> > > > Not to mention the discrepancy with what userspace gets while reading
> > > > the same register via the MRS emulation.
> > > > 
> > > > Granted, the cpumask doesn't fit the cpu*/regs/identification hierarchy,
> > > > but I don't think this fits either.
> > > 
> > > We already expose MIDR and REVIDR via the current sysfs interface. We
> > > can expand it to include _all_ the other ID_* regs currently available
> > > to user via the MRS emulation and we won't have to debate what a new
> > > interface would look like. The MRS emulation and the sysfs info should
> > > probably match, though that means we need to expose the
> > > ID_AA64PFR0_EL1.EL0 field which we currently don't.
> > > 
> > > I do agree that an AArch32 cpumask is an easier option both from the
> > > kernel implementation perspective and from the application usability
> > > one, though not as easy as automatic task placement by the scheduler (my
> > > first preference, followed by the id_* regs and the aarch32 mask, though
> > > not a strong preference for any).
> > 
> > If a cpumask is easier to implement and easier to use, then I think that's
> > what we should do. It's also then dead easy to disable if necessary by
> > just returning 0. The only alternative I would prefer is not having to
> > expose this information altogether, but I'm not sure that figuring this
> > out from MIDR/REVIDR alone is reliable.
> 
> I did suggest this before, but I'll try gain. If we want to assume a custom
> bootloader and custom user space, we can make them provide the mask.

Who mentioned a custom bootloader? In the context of Android, we're
talking about a user-space that already manages scheduling affinity.

> For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> a bool as it currently is. Or we can make it a cmdline parameter too.
> In both cases some admin (bootloader or init process) has to ensure to fill it
> correctly for the target platform. The bootloader should be able to read the
> registers to figure out the mask. So more weight to make it a cmdline param.

I think this is adding complexity for the sake of it. I'm much more in
favour of keeping the implementation and ABI as simple as possible: expose
the fact that the system is heterogenous, have an opt-in for userspace to
say it can handle that and let it handle it.

Will
