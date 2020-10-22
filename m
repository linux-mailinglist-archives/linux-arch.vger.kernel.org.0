Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33374295C53
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896232AbgJVJ6G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 05:58:06 -0400
Received: from foss.arm.com ([217.140.110.172]:52880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411154AbgJVJ6F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 05:58:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8230DD6E;
        Thu, 22 Oct 2020 02:58:05 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32A923F66E;
        Thu, 22 Oct 2020 02:58:04 -0700 (PDT)
Date:   Thu, 22 Oct 2020 10:58:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022095801.4xb4xrvxm35cmz5b@e107158-lin>
References: <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
 <20201021160730.komcgrp7q2tly55w@e107158-lin>
 <20201021172345.GF18071@willie-the-truck>
 <20201021195736.mj4njbi6pxkbpbyf@e107158-lin>
 <20201021202626.GA18494@willie-the-truck>
 <20201022081624.GA1229@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022081624.GA1229@gaia>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/22/20 09:16, Catalin Marinas wrote:
> On Wed, Oct 21, 2020 at 09:26:27PM +0100, Will Deacon wrote:
> > On Wed, Oct 21, 2020 at 08:57:36PM +0100, Qais Yousef wrote:
> > > On 10/21/20 18:23, Will Deacon wrote:
> > > > On Wed, Oct 21, 2020 at 05:07:30PM +0100, Qais Yousef wrote:
> > > > > > > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > > > > > > a bool as it currently is. Or we can make it a cmdline parameter too.
> > > > > > > In both cases some admin (bootloader or init process) has to ensure to fill it
> > > > > > > correctly for the target platform. The bootloader should be able to read the
> > > > > > > registers to figure out the mask. So more weight to make it a cmdline param.
> > > > > > 
> > > > > > I think this is adding complexity for the sake of it. I'm much more in
> > > > > 
> > > > > I actually think it reduces complexity. No special ABI to generate the mask
> > > > > from the kernel. The same opt-in flag is the cpumask too.
> > > > 
> > > > Maybe I'm misunderstanding your proposal but having a cpumask instead of
> > > 
> > > What I meant is that if we change the requirement to opt-in from a boolean
> > > switch
> > > 
> > > 	sysctl.enable_32bit_asym=1
> > > 
> > > to require the bootloader/init scripts provide the mask of aarch32 capable cpus
> > > 
> > > 	sysctl.asym_32bit_cpus=0xf0
> [...]
> > > 	* We don't need a separate API to export which cpus are 32bit capable.
> > > 	  They can read it directly from /proc/sys/kernel/asym_32bit_cpus.
> > > 	  When it's 0 it means the system is not asymmetric.
> > 
> > I don't see how this is better than a separate cpumask for this purpose.
> > It feels like you're trying to overload the control and the identification,
> > but that just makes things confusing and hard to use as I now need to know
> > which logical CPUs correspond to which physical CPUs in order to set the
> > command-line.

I tend to disagree with some of the statements. But I'll leave it at that.
Whatever makes the ship move :)

> I agree. Let's leave the identification to the kernel as it has access
> to the CPUID registers and can provide the cpumask. The control in this
> case doesn't need to be more than a boolean and its meaning is that the
> user knows what it is doing.

Thanks

--
Qais Yousef
