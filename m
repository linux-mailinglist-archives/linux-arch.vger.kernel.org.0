Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D904F64B
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2019 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFVOqy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Jun 2019 10:46:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVOqy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jun 2019 10:46:54 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hehHh-00084j-Nz; Sat, 22 Jun 2019 16:46:30 +0200
Date:   Sat, 22 Jun 2019 16:46:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
In-Reply-To: <20190614211710.GQ1513@sasha-vm>
Message-ID: <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-19-vincenzo.frascino@arm.com> <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com> <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Jun 2019, Sasha Levin wrote:
> On Fri, Jun 14, 2019 at 01:15:23PM +0200, Thomas Gleixner wrote:
> > On Thu, 30 May 2019, Michael Kelley wrote:
> > > Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
> > > I have that moves all of the Hyper-V clock/timer code into a separate
> > > clocksource driver in drivers/clocksource, with an include file in
> > > includes/clocksource.  That new include file should be able to work
> > > instead of your new mshyperv-tsc.h.  It also has the benefit of being
> > > ISA neutral, so it will work with my in-progress patch set to support
> > > Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
> > > for the new clocksource driver patch set.
> > 
> > Grrr. That's queued in hyperv-next for whatever reasons.
> 
> I queue up our future pull requests there to give them some soaking in
> -next.

What? You queue completely unreviewed stuff which touches two other
subsystems to let it soak in next?

> > Sasha, can you please provide me the branch to pull from so I can have a
> > common base for all the various changes floating around?
> 
> I'll send you a unified pull request for these changes.

Which has not materialized yet.

TBH, I'm pretty grumpy about those clocksource changes. Here is the
diffstat:

 MAINTAINERS                          |    2 
 arch/x86/entry/vdso/vclock_gettime.c |    1 
 arch/x86/entry/vdso/vma.c            |    2 
 arch/x86/hyperv/hv_init.c            |   91 ---------
 arch/x86/include/asm/hyperv-tlfs.h   |    6 
 arch/x86/include/asm/mshyperv.h      |   81 +-------
 arch/x86/kernel/cpu/mshyperv.c       |    2 
 arch/x86/kvm/x86.c                   |    1 
 drivers/clocksource/Makefile         |    1 
 drivers/clocksource/hyperv_timer.c   |  322 +++++++++++++++++++++++++++++++++++
 drivers/hv/Kconfig                   |    3 
 drivers/hv/hv.c                      |  156 ----------------
 drivers/hv/hv_util.c                 |    1 
 drivers/hv/hyperv_vmbus.h            |    3 
 drivers/hv/vmbus_drv.c               |   42 ++--
 include/clocksource/hyperv_timer.h   |  105 +++++++++++

While the world and some more people have been CC'ed on those patches,
neither the clocksource nor the x86 maintainer have been.

When I gave Vincenzo the advise to base his code on that hyper-v branch, I
expected that I find the related patches in my mail backlog. No, they have
not been there because I was not on CC.

Folks, please stop chosing Cc lists as you like. We have well established
rules for that. And please stop queueing random unreviewed patches in
next. Next is not a playground for not ready and unreviewed stuff. No, the
hyper-v inbreed Reviewed-by is not sufficient for anything x86 and
clocksource related.

After chasing and looking at those patches, which have horrible subject
lines and changelogs btw, I was not able to judge quickly whether that
stuff is self contained or not. So no, I fixed up the fallout and rebased
Vincenzos VDSO stuff on mainline w/o those hyperv changes simply because if
they are not self contained they will break bisection badly.

I'm going to push out the VDSO series later today. That will nicely break
in combination with the hyper-next branch. Stephen, please drop that and do
not try to handle the fallout. That stuff needs to go through the proper
channels or at least be acked/reviewed by the relevant maintainers. So the
hyper-v folks can rebase themself and post it proper.

Yours grumpy,

	tglx
