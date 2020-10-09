Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE4288570
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgJIIkO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 04:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgJIIkO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 04:40:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3A12087D;
        Fri,  9 Oct 2020 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602232812;
        bh=3FnNRrdFZy8dpkVRh9duQr65KKRLcp5XuZqmODbiGFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMeSUc9JZDrvNMltlX3QyR/dLxuPDyT2wQ+MEhojEqCyMgsTc5n3+Gi3/7Eh3bQis
         XZtZdASUjMV37MkDMtvIXGfeAnmy1MeFniAk617NWFq4v/O0+lbL2KBSdBliNIT5yQ
         jcyk1TQItgRC5flgX9F2GhlE2kG2sMHvb2/ropu4=
Date:   Fri, 9 Oct 2020 09:40:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201009084007.GB29594@willie-the-truck>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
 <20201009061356.GA120580@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009061356.GA120580@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 08:13:56AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 08, 2020 at 07:16:40PM +0100, Qais Yousef wrote:
> > When the CONFIG_ASYMMETRIC_AARCH32 option is enabled (EXPERT), the type
> > of the ARM64_HAS_32BIT_EL0 capability becomes WEAK_LOCAL_CPU_FEATURE.
> > The kernel will now return true for system_supports_32bit_el0() and
> > checks 32-bit tasks are affined to AArch32 capable CPUs only in
> > do_notify_resume(). If the affinity contains a non-capable AArch32 CPU,
> > the tasks will get SIGKILLed. If the last CPU supporting 32-bit is
> > offlined, the kernel will SIGKILL any scheduled 32-bit tasks (the
> > alternative is to prevent offlining through a new .cpu_disable feature
> > entry).
> > 
> > In addition to the relaxation of the ARM64_HAS_32BIT_EL0 capability,
> > this patch factors out the 32-bit cpuinfo and features setting into
> > separate functions: __cpuinfo_store_cpu_32bit(),
> > init_cpu_32bit_features(). The cpuinfo of the booting CPU
> > (boot_cpu_data) is now updated on the first 32-bit capable CPU even if
> > it is a secondary one. The ID_AA64PFR0_EL0_64BIT_ONLY feature is relaxed
> > to FTR_NONSTRICT and FTR_HIGHER_SAFE when the asymmetric AArch32 support
> > is enabled. The compat_elf_hwcaps are only verified for the
> > AArch32-capable CPUs to still allow hotplugging AArch64-only CPUs.
> > 
> > Make sure that KVM never sees the asymmetric 32bit system. Guest can
> > still ignore ID registers and force run 32bit at EL0.
> > 
> > Co-developed-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  arch/arm64/Kconfig                   | 14 ++++++
> >  arch/arm64/include/asm/cpu.h         |  2 +
> >  arch/arm64/include/asm/cpucaps.h     |  3 +-
> >  arch/arm64/include/asm/cpufeature.h  | 20 +++++++-
> >  arch/arm64/include/asm/thread_info.h |  5 +-
> >  arch/arm64/kernel/cpufeature.c       | 66 +++++++++++++++-----------
> >  arch/arm64/kernel/cpuinfo.c          | 71 ++++++++++++++++++----------
> >  arch/arm64/kernel/process.c          | 17 +++++++
> >  arch/arm64/kernel/signal.c           | 18 +++++++
> >  arch/arm64/kvm/arm.c                 |  5 +-
> >  arch/arm64/kvm/guest.c               |  2 +-
> >  arch/arm64/kvm/sys_regs.c            | 14 +++++-
> >  12 files changed, 176 insertions(+), 61 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d232837cbee..591853504dc4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1868,6 +1868,20 @@ config DMI
> >  
> >  endmenu
> >  
> > +config ASYMMETRIC_AARCH32
> > +	bool "Allow support for asymmetric AArch32 support"
> > +	depends on COMPAT && EXPERT
> 
> Why EXPERT?  You don't want this able to be enabled by anyone?

TBH, I'd be inclined to drop the Kconfig option altogether. We're not
looking at a lot of code here, so all it does is further fragment the
build testing we get from CI (or it just ends up being enabled all of the
time).

A cmdline option, on the other hand, makes a tonne of sense to me, as it
acts as an "opt-in" that the distribution is ready to handle the madness
(because userspace will need to care about this even with the scheduler
hacks proposed here).

Will
