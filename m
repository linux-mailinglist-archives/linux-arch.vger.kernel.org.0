Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0728858A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbgJIIu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 04:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgJIIu6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 04:50:58 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2F522273;
        Fri,  9 Oct 2020 08:50:55 +0000 (UTC)
Date:   Fri, 9 Oct 2020 09:50:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201009085053.GB23638@gaia>
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

Exactly ;). Anyway, depending on how user-friendly the feature becomes
(like the kernel transparently handling task placement), we may drop
this condition or replace it with a command line option. By default
current kernels block ELF32 processes on such platform.

> > +	help
> > +	  Enable this option to allow support for asymmetric AArch32 EL0
> > +	  CPU configurations. Once the AArch32 EL0 support is detected
> > +	  on a CPU, the feature is made available to user space to allow
> > +	  the execution of 32-bit (compat) applications. If the affinity
> > +	  of the 32-bit application contains a non-AArch32 capable CPU
> > +	  or the last AArch32 capable CPU is offlined, the application
> > +	  will be killed.
> > +
> > +	  If unsure say N.
> > +
> >  config SYSVIPC_COMPAT
> >  	def_bool y
> >  	depends on COMPAT && SYSVIPC
> > diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> > index 7faae6ff3ab4..c920fa45e502 100644
> > --- a/arch/arm64/include/asm/cpu.h
> > +++ b/arch/arm64/include/asm/cpu.h
> > @@ -15,6 +15,7 @@
> >  struct cpuinfo_arm64 {
> >  	struct cpu	cpu;
> >  	struct kobject	kobj;
> > +	bool		aarch32_valid;
> 
> Do you mean to cause holes in this structure?  :)

No matter where you put it, there's still a hole (could move the hole at
the end though), unless we make it a 32-bit value.

Thinking about this, since we only check it on the boot_cpu_data
structure, we could probably make it a stand-alone variable or drop it
altogether (see below).

> Isn't "valid" the common thing?  Do you now have to explicitly enable
> this everywhere instead of just dealing with the uncommon case of this
> cpu variant?

We have a whole infrastructure for dealing with asymmetric features and
in most cases we only want the common functionality. The CPUID register
fields across all CPUs are normally sanitised to the lowest common
value. For some secondary CPU feature not matching the boot CPU we taint
the kernel.

In the original patch (that ended up on some Google gerrit), we relaxed
the 32-bit support checking so that the sanitised register contains the
highest value. However, if booting on a (big) CPU that did not have
32-bit, the kernel would end up tainted. The reason for aarch32_valid
was to delay populating the boot CPU information until a secondary CPU
comes up with 32-bit support and subsequently avoid the tainting.

With a last minute change (yesterday), we reverted the sanitised 32-bit
support field to the lowest value and introduced a new feature check
that's enabled when at least one of the CPUs has 32-bit support (we do
something similar for errata detection). With this in place, I think the
aarch32_valid setting/checking and delayed boot_cpu_data update can go.

> I don't see this information being exported to userspace anywhere.  I
> know Intel has submitted a patch to export this "type" of thing to the
> cpu sysfs directories, can you do the same thing here?
> 
> Otherwise, how is userspace supposed to know where to place programs
> that are 32bit?

In this series, we tried to avoid this by introducing an automatic
affinity setting/hacking (patch 3). So it's entirely transparent to the
user, it doesn't need to explicitly ask for specific task placement.

Given that Peter is against overriding the user cpumask and that a void
intersection between the 32-bit cpumask and the user one would lead to
SIGKILL, we probably have to expose the information somewhere. Currently
we have the midr_el1 register exposed in sysfs and this tells the
specific CPU implementation. It doesn't, however, state whether 32-bit
is supported unless one checks the specifications. I'd prefer to extend
the current arm64 sysfs cpu interface to include the rest of the id_*
registers, unless we find a way to create a common interface with what
the x86 guys are doing. But I'm slightly doubtful that we can find a
common interface. While 32-bit is common across other architectures, we
may want this for other features which don't have any correspondent.

-- 
Catalin
