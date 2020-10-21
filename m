Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422A295374
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505295AbgJUU0e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 16:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505284AbgJUU0d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 16:26:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5F121D6C;
        Wed, 21 Oct 2020 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603311992;
        bh=knWpq9ayYtvYaJd6mEQADTiLp39WF7GfDQ1m3dk+0SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/8uO/z30xFF1JPBo6UdIS+C5kgfgLhrdSDJeTwUqero71OOgSwlnALCTzNy3TNWH
         5FeTPhwZdgcj/oI6eXgGXQiWwUFEz8BTWdDIVfQZ4OyRoRe685eFvvhtYkcK2GdEBn
         Z6yPeWKH/FYj+JIvBXV3YjjXH0/1rwNG/LRxGzKE=
Date:   Wed, 21 Oct 2020 21:26:27 +0100
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
Message-ID: <20201021202626.GA18494@willie-the-truck>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
 <20201021160730.komcgrp7q2tly55w@e107158-lin>
 <20201021172345.GF18071@willie-the-truck>
 <20201021195736.mj4njbi6pxkbpbyf@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021195736.mj4njbi6pxkbpbyf@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 08:57:36PM +0100, Qais Yousef wrote:
> On 10/21/20 18:23, Will Deacon wrote:
> > On Wed, Oct 21, 2020 at 05:07:30PM +0100, Qais Yousef wrote:
> > > > > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > > > > a bool as it currently is. Or we can make it a cmdline parameter too.
> > > > > In both cases some admin (bootloader or init process) has to ensure to fill it
> > > > > correctly for the target platform. The bootloader should be able to read the
> > > > > registers to figure out the mask. So more weight to make it a cmdline param.
> > > > 
> > > > I think this is adding complexity for the sake of it. I'm much more in
> > > 
> > > I actually think it reduces complexity. No special ABI to generate the mask
> > > from the kernel. The same opt-in flag is the cpumask too.
> > 
> > Maybe I'm misunderstanding your proposal but having a cpumask instead of
> 
> What I meant is that if we change the requirement to opt-in from a boolean
> switch
> 
> 	sysctl.enable_32bit_asym=1
> 
> to require the bootloader/init scripts provide the mask of aarch32 capable cpus
> 
> 	sysctl.asym_32bit_cpus=0xf0
> 
> This will achieve multiple things at the same time:
> 
> 	* Defer cpus specification to platform designers who want to
> 	  enable this feature on their platform.

What do you mean by this? The kernel will obviously have to check that
the mask is correct (i.e. it doesn't contain 64-bit only CPUs), at which
point it's a boolean in disguise.

> 	* We don't need a separate API to export which cpus are 32bit capable.
> 	  They can read it directly from /proc/sys/kernel/asym_32bit_cpus.
> 	  When it's 0 it means the system is not asymmetric.

I don't see how this is better than a separate cpumask for this purpose.
It feels like you're trying to overload the control and the identification,
but that just makes things confusing and hard to use as I now need to know
which logical CPUs correspond to which physical CPUs in order to set the
command-line.

> 	* If/when we want to disable this support in the future. The sysctl
> 	  handler will just have to return 0 all the time and ignore all
> 	  writes.

It can do that as a boolean too, right?

Will
