Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549DF295178
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502680AbgJURXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 13:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503440AbgJURXw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 13:23:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990332224E;
        Wed, 21 Oct 2020 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603301031;
        bh=xq9F3BNwrdzcMaeiCuh+tv2UemTAqtVTeWOtyKnQsxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+ncN65MDIe17KRnakxuyrEDqKSURzcGQnDCDtguNYVz5cMwquYGFvIsC9X1JESTi
         LIUDla4jGek6RZFQOW2xN+Am7dTAnKEtji9WiqXtqm/sdV9WYRg8eGetOQXovF36VS
         1TI7oAb6XM+8lIKEuFc6ItikkaH/wNzlJgO8YoPs=
Date:   Wed, 21 Oct 2020 18:23:46 +0100
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
Message-ID: <20201021172345.GF18071@willie-the-truck>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
 <20201021160730.komcgrp7q2tly55w@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021160730.komcgrp7q2tly55w@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 05:07:30PM +0100, Qais Yousef wrote:
> On 10/21/20 16:23, Will Deacon wrote:
> > > > If a cpumask is easier to implement and easier to use, then I think that's
> > > > what we should do. It's also then dead easy to disable if necessary by
> > > > just returning 0. The only alternative I would prefer is not having to
> > > > expose this information altogether, but I'm not sure that figuring this
> > > > out from MIDR/REVIDR alone is reliable.
> > > 
> > > I did suggest this before, but I'll try gain. If we want to assume a custom
> > > bootloader and custom user space, we can make them provide the mask.
> > 
> > Who mentioned a custom bootloader? In the context of Android, we're
> 
> Custom bootloader as in a bootloader that needs to opt-in to enable the
> feature (pass the right cmdline param). Catalin suggested to make this a sysctl
> to allow also for runtime toggling. But the initial intention was to have this
> to enable it at cmdline.

Hmm, ok, I don't think allowing the cmdline to be specified means its a
custom bootloader.

> > talking about a user-space that already manages scheduling affinity.
> > 
> > > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > > a bool as it currently is. Or we can make it a cmdline parameter too.
> > > In both cases some admin (bootloader or init process) has to ensure to fill it
> > > correctly for the target platform. The bootloader should be able to read the
> > > registers to figure out the mask. So more weight to make it a cmdline param.
> > 
> > I think this is adding complexity for the sake of it. I'm much more in
> 
> I actually think it reduces complexity. No special ABI to generate the mask
> from the kernel. The same opt-in flag is the cpumask too.

Maybe I'm misunderstanding your proposal but having a cpumask instead of
a bool means you now have to consider policy on a per-cpu basis, which
adds an extra dimension to this. For example, do you allow that mask to
be changed at runtime so that differents sets of CPUs now support 32-bit?
Do you preserve it across hotplug?

Will
