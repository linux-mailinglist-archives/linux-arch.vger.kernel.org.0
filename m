Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B729532A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410410AbgJUT5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 15:57:41 -0400
Received: from foss.arm.com ([217.140.110.172]:39346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390855AbgJUT5l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 15:57:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4880D6E;
        Wed, 21 Oct 2020 12:57:40 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612F63F719;
        Wed, 21 Oct 2020 12:57:39 -0700 (PDT)
Date:   Wed, 21 Oct 2020 20:57:36 +0100
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
Message-ID: <20201021195736.mj4njbi6pxkbpbyf@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
 <20201021160730.komcgrp7q2tly55w@e107158-lin>
 <20201021172345.GF18071@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021172345.GF18071@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 18:23, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 05:07:30PM +0100, Qais Yousef wrote:
> > On 10/21/20 16:23, Will Deacon wrote:
> > > > > If a cpumask is easier to implement and easier to use, then I think that's
> > > > > what we should do. It's also then dead easy to disable if necessary by
> > > > > just returning 0. The only alternative I would prefer is not having to
> > > > > expose this information altogether, but I'm not sure that figuring this
> > > > > out from MIDR/REVIDR alone is reliable.
> > > > 
> > > > I did suggest this before, but I'll try gain. If we want to assume a custom
> > > > bootloader and custom user space, we can make them provide the mask.
> > > 
> > > Who mentioned a custom bootloader? In the context of Android, we're
> > 
> > Custom bootloader as in a bootloader that needs to opt-in to enable the
> > feature (pass the right cmdline param). Catalin suggested to make this a sysctl
> > to allow also for runtime toggling. But the initial intention was to have this
> > to enable it at cmdline.
> 
> Hmm, ok, I don't think allowing the cmdline to be specified means its a
> custom bootloader.

True it could be just added to chosen property in the DT file without any
bootloader changes.

Bad usage of English probably. I just meant the bootloader might need to be
made aware of the opt-in process too. So it can potentially co-operate more.

> > > talking about a user-space that already manages scheduling affinity.
> > > 
> > > > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > > > a bool as it currently is. Or we can make it a cmdline parameter too.
> > > > In both cases some admin (bootloader or init process) has to ensure to fill it
> > > > correctly for the target platform. The bootloader should be able to read the
> > > > registers to figure out the mask. So more weight to make it a cmdline param.
> > > 
> > > I think this is adding complexity for the sake of it. I'm much more in
> > 
> > I actually think it reduces complexity. No special ABI to generate the mask
> > from the kernel. The same opt-in flag is the cpumask too.
> 
> Maybe I'm misunderstanding your proposal but having a cpumask instead of

What I meant is that if we change the requirement to opt-in from a boolean
switch

	sysctl.enable_32bit_asym=1

to require the bootloader/init scripts provide the mask of aarch32 capable cpus

	sysctl.asym_32bit_cpus=0xf0

This will achieve multiple things at the same time:

	* Defer cpus specification to platform designers who want to
	  enable this feature on their platform.

	* We don't need a separate API to export which cpus are 32bit capable.
	  They can read it directly from /proc/sys/kernel/asym_32bit_cpus.
	  When it's 0 it means the system is not asymmetric.

	* If/when we want to disable this support in the future. The sysctl
	  handler will just have to return 0 all the time and ignore all
	  writes.

So it's changing the way user space opts-in. The kernel will still treat it as
a boolean, and probably sanity check the cpus to make sure they match what it
sees.

> a bool means you now have to consider policy on a per-cpu basis, which
> adds an extra dimension to this. For example, do you allow that mask to
> be changed at runtime so that differents sets of CPUs now support 32-bit?
> Do you preserve it across hotplug?

I can see how cpumask word was confusing. I hope the above is clearer.
We don't change how the kernel works, but rather what the user space have to do
to opt-in. Hopefully hitting 2 birds with one stone :-)

Thanks!

--
Qais Yousef
