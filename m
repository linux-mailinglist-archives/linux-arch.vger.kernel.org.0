Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78F1288902
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgJIMkc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 08:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJIMkb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 08:40:31 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6701222284;
        Fri,  9 Oct 2020 12:40:29 +0000 (UTC)
Date:   Fri, 9 Oct 2020 13:40:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009124025.GH23638@gaia>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
 <20201009083146.GA29594@willie-the-truck>
 <20201009093340.GC23638@gaia>
 <20201009113155.to5euj6sekmwt7lg@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009113155.to5euj6sekmwt7lg@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 12:31:56PM +0100, Qais Yousef wrote:
> On 10/09/20 10:33, Catalin Marinas wrote:
> > On Fri, Oct 09, 2020 at 09:31:47AM +0100, Will Deacon wrote:
> > > Honestly, I don't understand why we're trying to hide this asymmetry from
> > > userspace by playing games with affinity masks in the kernel. Userspace
> > > is likely to want to move things about _anyway_ because even amongst the
> > > 32-bit capable cores, you may well have different clock frequencies to
> > > contend with.
> > > 
> > > So I'd be *much* happier to let the schesduler do its thing, and if one
> > > of these 32-bit tasks ends up on a core that can't deal with it, then
> > > tough, it gets killed. Give userspace the information it needs to avoid
> > > that happening in the first place, rather than implicitly limit the mask.
> > > 
> > > That way, the kernel support really boils down to two parts:
> > > 
> > >   1. Remove the sanity checks we have to prevent 32-bit applications running
> > >      on asymmetric systems
> > > 
> > >   2. Tell userspace about the problem
> > 
> > This works for me as well as long as it is default off with a knob to
> > turn it on. I'd prefer a sysctl (which can be driven from the command
> > line in recent kernels IIRC) so that one can play with it a run-time.
> > This way it's also a userspace choice and not an admin or whoever
> > controls the cmdline (well, that's rather theoretical since the target
> > is Android).
> 
> I like the cmdline option more. It implies a custom bootloader and user space
> are required to enable this. Which in return implies they can write their own
> custom driver to manage exporting this info to user-space. Reliefing us from
> maintaining any ABI in mainline kernel.

Regardless of whether it's cmdline or sysctl, I'm strongly opposed to
custom drivers for exposing this information to user. It leads to
custom incompatible ABIs scattered around.

Note that user can already check the MIDR_EL1 value if it knows which
CPU type and revision has 32-bit support.

-- 
Catalin
