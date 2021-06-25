Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA233B3FB1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFYIs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 04:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhFYIs6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 04:48:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C89E6141C;
        Fri, 25 Jun 2021 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624610798;
        bh=k0YWqkCUy3RGtdCsOBfK8gvBJN3ud9zj7lvL3kFNjAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDR5ci+oNRMJ4uzMyayoa0PvasYVgTmfXR2pSWETboH7V7+cS51AASr0Z6aR92gAN
         MTCp5Vjd4rERsvOesewcd8MV1yCzn/AvJJJpTCuRHy90L1OJRHkBwrL6/BuYj1ivLq
         ol2b4fBev5kO1MLHZLiBIdcNpQuP8WWv5vbblAdA=
Date:   Fri, 25 Jun 2021 10:46:35 +0200
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
Message-ID: <YNWX64TIVkGyNsbs@kroah.com>
References: <20210623173848.318-1-will@kernel.org>
 <20210623173848.318-14-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623173848.318-14-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 23, 2021 at 06:38:45PM +0100, Will Deacon wrote:
> Since 32-bit applications will be killed if they are caught trying to
> execute on a 64-bit-only CPU in a mismatched system, advertise the set
> of 32-bit capable CPUs to userspace in sysfs.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
>  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index fe13baa53c59..899377b2715a 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -494,6 +494,15 @@ Description:	AArch64 CPU registers
>  		'identification' directory exposes the CPU ID registers for
>  		identifying model and revision of the CPU.
>  
> +What:		/sys/devices/system/cpu/aarch32_el0
> +Date:		May 2021
> +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> +Description:	Identifies the subset of CPUs in the system that can execute
> +		AArch32 (32-bit ARM) applications. If present, the same format as
> +		/sys/devices/system/cpu/{offline,online,possible,present} is used.
> +		If absent, then all or none of the CPUs can execute AArch32
> +		applications and execve() will behave accordingly.
> +
>  What:		/sys/devices/system/cpu/cpu#/cpu_capacity
>  Date:		December 2016
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 2f9fe57ead97..23eaa7f06f76 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -67,6 +67,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/sort.h>
>  #include <linux/stop_machine.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>
>  #include <linux/minmax.h>
>  #include <linux/mm.h>
> @@ -1319,6 +1320,24 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>  	return cpu_possible_mask;
>  }
>  
> +static ssize_t aarch32_el0_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	const struct cpumask *mask = system_32bit_el0_cpumask();
> +
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
> +}
> +static const DEVICE_ATTR_RO(aarch32_el0);

I just realized that we have a problem with this type of representation
overflowing PAGE_SIZE on larger systems.  There is ongoing work to fix
this up but that requires converting these to binary sysfs files, which
is a pain to preserve the original format here.

Yes, for now you will be fine on these arm32 systems, but in the future
this will have to be changed.  Because of that, should you just make
this an individual cpu attribute (one file per cpu) and not a single
file that lists all cpus?

what tool is going to read this and why can't they just pick it up from
the individual cpu files instead?

thanks,

greg k-h
