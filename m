Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0032F3B40D1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFYJvZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 05:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhFYJvZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 05:51:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A360613EF;
        Fri, 25 Jun 2021 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624614544;
        bh=d9x1GgK+lTfueH+JmaX0uEBee0/XFzFih5wvyzp7QdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJAAcC5Fr5Pvr4sDVlcsKcc0EGejxUVDh1LzUAN8WhCmnzm9oXJzkqmqijNpPkGXN
         NoiHI/DfFomuXX2ci+zPtxegkJLZW31z+fV3VdSAWDR8HJkJDQWjS/CZTQWL0tf90n
         2VTXekvvgFuniP+grj70E9odSuuCCuLr+Pbih+Ps=
Date:   Fri, 25 Jun 2021 11:49:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v10 13/16] arm64: Advertise CPUs capable of running
 32-bit applications in sysfs
Message-ID: <YNWmjeuXlyQ+iGk6@kroah.com>
References: <20210623173848.318-1-will@kernel.org>
 <20210623173848.318-14-will@kernel.org>
 <YNWX64TIVkGyNsbs@kroah.com>
 <20210625093648.GB2782@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625093648.GB2782@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 25, 2021 at 10:36:49AM +0100, Will Deacon wrote:
> Hi Greg,
> 
> On Fri, Jun 25, 2021 at 10:46:35AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 23, 2021 at 06:38:45PM +0100, Will Deacon wrote:
> > > Since 32-bit applications will be killed if they are caught trying to
> > > execute on a 64-bit-only CPU in a mismatched system, advertise the set
> > > of 32-bit capable CPUs to userspace in sysfs.
> > > 
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
> > >  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > index fe13baa53c59..899377b2715a 100644
> > > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > @@ -494,6 +494,15 @@ Description:	AArch64 CPU registers
> > >  		'identification' directory exposes the CPU ID registers for
> > >  		identifying model and revision of the CPU.
> > >  
> > > +What:		/sys/devices/system/cpu/aarch32_el0
> > > +Date:		May 2021
> > > +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> > > +Description:	Identifies the subset of CPUs in the system that can execute
> > > +		AArch32 (32-bit ARM) applications. If present, the same format as
> > > +		/sys/devices/system/cpu/{offline,online,possible,present} is used.
> > > +		If absent, then all or none of the CPUs can execute AArch32
> > > +		applications and execve() will behave accordingly.
> > > +
> > >  What:		/sys/devices/system/cpu/cpu#/cpu_capacity
> > >  Date:		December 2016
> > >  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 2f9fe57ead97..23eaa7f06f76 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -67,6 +67,7 @@
> > >  #include <linux/crash_dump.h>
> > >  #include <linux/sort.h>
> > >  #include <linux/stop_machine.h>
> > > +#include <linux/sysfs.h>
> > >  #include <linux/types.h>
> > >  #include <linux/minmax.h>
> > >  #include <linux/mm.h>
> > > @@ -1319,6 +1320,24 @@ const struct cpumask *system_32bit_el0_cpumask(void)
> > >  	return cpu_possible_mask;
> > >  }
> > >  
> > > +static ssize_t aarch32_el0_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > > +
> > > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
> > > +}
> > > +static const DEVICE_ATTR_RO(aarch32_el0);
> > 
> > I just realized that we have a problem with this type of representation
> > overflowing PAGE_SIZE on larger systems.  There is ongoing work to fix
> > this up but that requires converting these to binary sysfs files, which
> > is a pain to preserve the original format here.
> 
> Urgh. Do you have a link to the work trying to fix this for the other sysfs
> files which are affected by this problem, please?

https://lore.kernel.org/r/20210617101910.13228-1-song.bao.hua@hisilicon.com
has the details.

> 
> > Yes, for now you will be fine on these arm32 systems, but in the future
> > this will have to be changed.  Because of that, should you just make
> > this an individual cpu attribute (one file per cpu) and not a single
> > file that lists all cpus?
> 
> Practically, I don't see this will ever be an issue for this case:
> 
>   1. 32-bit support is going to go away from the hardware, so this file
>      will simply be empty in the future.

It should not be "empty", it should just not be present if there are no
cpus of this type.

>   2. The 32-bit-capable CPUs aren't dotted around randomly, but rather
>      exist as contiguous ranges, so the format is reasonably compact.

We can dream :)

But again, why not just put a single file in the individual sysfs
directories for the cpus that are affected?  What is saved by providing
a range here?

> > what tool is going to read this and why can't they just pick it up from
> > the individual cpu files instead?
> 
> The idea is that controlling the affinity of 32-bit applications explicitly
> in userspace can be done by either creating cpusets where all CPUs are
> 32-bit capable, or simply setting their affinity to include only
> 32-bit-capable CPUs. The really nice properties about the way this is
> currently exposed are that it is the same as the
> /sys/devices/system/cpu/{offline,online,possible,present} files and is
> readibly usable by scripts. Moving the information into a per-cpu file gets
> rid of both of those advantages :(
> 
> A middle ground would be to expose it as a mask (i.e. "%*pb") and use one
> bit per CPU. NR_CPUS is capped to 4k on arm64 so that would be sufficient,
> although then the format is weirdly different to the other masks in the same
> directory.

See the link above for the details.  I would like to prevent the
addition of files that we know are already starting to cause problems in
real systems if at all possible.  If there really is no other way, ok,
but be aware of the future problems here please.

Yes, the odds of a lot of 32bit cpus in a single system are low, but
hardware engineers have done crazier things in the past...

thanks,

greg k-h
