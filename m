Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B3295067
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502795AbgJUQHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 12:07:35 -0400
Received: from foss.arm.com ([217.140.110.172]:37200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502794AbgJUQHe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 12:07:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D558BD6E;
        Wed, 21 Oct 2020 09:07:33 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 857553F719;
        Wed, 21 Oct 2020 09:07:32 -0700 (PDT)
Date:   Wed, 21 Oct 2020 17:07:30 +0100
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
Message-ID: <20201021160730.komcgrp7q2tly55w@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201021150313.ecxawwxsowweye43@e107158-lin>
 <20201021152310.GA18071@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021152310.GA18071@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 16:23, Will Deacon wrote:
> > > If a cpumask is easier to implement and easier to use, then I think that's
> > > what we should do. It's also then dead easy to disable if necessary by
> > > just returning 0. The only alternative I would prefer is not having to
> > > expose this information altogether, but I'm not sure that figuring this
> > > out from MIDR/REVIDR alone is reliable.
> > 
> > I did suggest this before, but I'll try gain. If we want to assume a custom
> > bootloader and custom user space, we can make them provide the mask.
> 
> Who mentioned a custom bootloader? In the context of Android, we're

Custom bootloader as in a bootloader that needs to opt-in to enable the
feature (pass the right cmdline param). Catalin suggested to make this a sysctl
to allow also for runtime toggling. But the initial intention was to have this
to enable it at cmdline.

> talking about a user-space that already manages scheduling affinity.
> 
> > For example, the new sysctl_enable_asym_32bit could be a cpumask instead of
> > a bool as it currently is. Or we can make it a cmdline parameter too.
> > In both cases some admin (bootloader or init process) has to ensure to fill it
> > correctly for the target platform. The bootloader should be able to read the
> > registers to figure out the mask. So more weight to make it a cmdline param.
> 
> I think this is adding complexity for the sake of it. I'm much more in

I actually think it reduces complexity. No special ABI to generate the mask
from the kernel. The same opt-in flag is the cpumask too.

> favour of keeping the implementation and ABI as simple as possible: expose
> the fact that the system is heterogenous, have an opt-in for userspace to
> say it can handle that and let it handle it.

It still has to do that. It's just the origin of the cpumask will change.

So it really depends how you view the opt-in. Ie: it needs to be discovered vs
the user space knows it exists and it just wants to enable it. So far we've
been going in the latter direction AFAICT. My current implementation is
terrible for discovery.

I don't feel strongly about it anyway. Just an idea. I can understand the lack
of appeal. Not sure if there's a none ugly solution yet :-)

Thanks

--
Qais Yousef
