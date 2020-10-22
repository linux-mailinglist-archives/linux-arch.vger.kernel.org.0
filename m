Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9F2959F9
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443476AbgJVIQb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 04:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894748AbgJVIQ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 04:16:29 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549D621481;
        Thu, 22 Oct 2020 08:16:27 +0000 (UTC)
Date:   Thu, 22 Oct 2020 09:16:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022081624.GA1229@gaia>
References: <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
 <20201021160730.komcgrp7q2tly55w@e107158-lin>
 <20201021172345.GF18071@willie-the-truck>
 <20201021195736.mj4njbi6pxkbpbyf@e107158-lin>
 <20201021202626.GA18494@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021202626.GA18494@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 09:26:27PM +0100, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 08:57:36PM +0100, Qais Yousef wrote:
> > On 10/21/20 18:23, Will Deacon wrote:
> > > On Wed, Oct 21, 2020 at 05:07:30PM +0100, Qais Yousef wrote:
> > > > > > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > > > > > a bool as it currently is. Or we can make it a cmdline parameter too.
> > > > > > In both cases some admin (bootloader or init process) has to ensure to fill it
> > > > > > correctly for the target platform. The bootloader should be able to read the
> > > > > > registers to figure out the mask. So more weight to make it a cmdline param.
> > > > > 
> > > > > I think this is adding complexity for the sake of it. I'm much more in
> > > > 
> > > > I actually think it reduces complexity. No special ABI to generate the mask
> > > > from the kernel. The same opt-in flag is the cpumask too.
> > > 
> > > Maybe I'm misunderstanding your proposal but having a cpumask instead of
> > 
> > What I meant is that if we change the requirement to opt-in from a boolean
> > switch
> > 
> > 	sysctl.enable_32bit_asym=1
> > 
> > to require the bootloader/init scripts provide the mask of aarch32 capable cpus
> > 
> > 	sysctl.asym_32bit_cpus=0xf0
[...]
> > 	* We don't need a separate API to export which cpus are 32bit capable.
> > 	  They can read it directly from /proc/sys/kernel/asym_32bit_cpus.
> > 	  When it's 0 it means the system is not asymmetric.
> 
> I don't see how this is better than a separate cpumask for this purpose.
> It feels like you're trying to overload the control and the identification,
> but that just makes things confusing and hard to use as I now need to know
> which logical CPUs correspond to which physical CPUs in order to set the
> command-line.

I agree. Let's leave the identification to the kernel as it has access
to the CPUID registers and can provide the cpumask. The control in this
case doesn't need to be more than a boolean and its meaning is that the
user knows what it is doing.

-- 
Catalin
