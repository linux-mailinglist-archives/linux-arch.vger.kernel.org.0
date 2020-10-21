Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F92294F74
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443828AbgJUPDT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 11:03:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443608AbgJUPDT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 11:03:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BF1D31B;
        Wed, 21 Oct 2020 08:03:17 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391343F66B;
        Wed, 21 Oct 2020 08:03:16 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:03:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021150313.ecxawwxsowweye43@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021144112.GA17912@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 15:41, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> > > On 2020-10-21 11:46, Qais Yousef wrote:
> > > > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > > > printed out
> > > > although it's set as FTR_HIDDEN.
> > > > 
> > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 
> > > > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > > > 
> > > > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > > 0x0000000000000012
> > > > 0x0000000000000012
> > > > 0x0000000000000011
> > > > 0x0000000000000011
> > > 
> > > This looks like a terrible userspace interface. It exposes unrelated
> > > features,
> > 
> > Not sure why the EL1 field ended up in here, that's not relevant to the
> > user.
> > 
> > > and doesn't expose the single useful information that the kernel has:
> > > the cpumask describing the CPUs supporting  AArch32 at EL0. Why not expose
> > > this synthetic piece of information which requires very little effort from
> > > userspace and doesn't spit out unrelated stuff?
> > 
> > I thought the whole idea is to try and avoid the "very little effort"
> > part ;).
> > 
> > > Not to mention the discrepancy with what userspace gets while reading
> > > the same register via the MRS emulation.
> > > 
> > > Granted, the cpumask doesn't fit the cpu*/regs/identification hierarchy,
> > > but I don't think this fits either.
> > 
> > We already expose MIDR and REVIDR via the current sysfs interface. We
> > can expand it to include _all_ the other ID_* regs currently available
> > to user via the MRS emulation and we won't have to debate what a new
> > interface would look like. The MRS emulation and the sysfs info should
> > probably match, though that means we need to expose the
> > ID_AA64PFR0_EL1.EL0 field which we currently don't.
> > 
> > I do agree that an AArch32 cpumask is an easier option both from the
> > kernel implementation perspective and from the application usability
> > one, though not as easy as automatic task placement by the scheduler (my
> > first preference, followed by the id_* regs and the aarch32 mask, though
> > not a strong preference for any).
> 
> If a cpumask is easier to implement and easier to use, then I think that's
> what we should do. It's also then dead easy to disable if necessary by
> just returning 0. The only alternative I would prefer is not having to
> expose this information altogether, but I'm not sure that figuring this
> out from MIDR/REVIDR alone is reliable.

I did suggest this before, but I'll try gain. If we want to assume a custom
bootloader and custom user space, we can make them provide the mask.

For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
a bool as it currently is. Or we can make it a cmdline parameter too.
In both cases some admin (bootloader or init process) has to ensure to fill it
correctly for the target platform. The bootloader should be able to read the
registers to figure out the mask. So more weight to make it a cmdline param.

Then the rest of user space can easily parse the cpumask from
/proc/sys/kernel/enable_asym_32bit or from /proc/cmdline.


Thanks

--
Qais Yousef
