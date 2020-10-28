Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE529DF5F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 02:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbgJ2BBG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 21:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbgJ1WR1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C22452465B;
        Wed, 28 Oct 2020 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603874214;
        bh=YTIoP8jmk1dMFohZd6EK2lZ2rfu1qEiJDzHvGm4gTPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=br54aej6Fa3FCD729KUKrUAQOnkwSB34dXnqmrdB7pYHryrJ8bcuIUzMtqUpnnLul
         jZAzLh0Ol2qAkkHNXL9ZNYIbDrsmE1WhYab3+NbUHzeVI1AHuxbcg5mtfmUrA8Aiz1
         BDEpUgrVSB4Gml1vH9fNb6ZO0jOFZovQ9KBQptq8=
Date:   Wed, 28 Oct 2020 09:37:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 5/6] arm64: Advertise CPUs capable of running 32-bit
 applcations in sysfs
Message-ID: <20201028083746.GA1854746@kroah.com>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027215118.27003-6-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:51:17PM +0000, Will Deacon wrote:
> Since 32-bit applications will be killed if they are caught trying to
> execute on a 64-bit-only CPU in a mismatched system, advertise the set
> of 32-bit capable CPUs to userspace in sysfs.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  8 ++++++++
>  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b555df825447..19893fb8e870 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -472,6 +472,14 @@ Description:	AArch64 CPU registers
>  		'identification' directory exposes the CPU ID registers for
>  		 identifying model and revision of the CPU.
>  
> +What:		/sys/devices/system/cpu/aarch32_el0
> +Date:		October 2020
> +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> +Description:	Identifies the subset of CPUs in the system that can execute
> +		AArch32 (32-bit ARM) applications. If absent, then all or none
> +		of the CPUs can execute AArch32 applications and execve() will
> +		behave accordingly.

How is this value represented?  A hint here would be nice.

> +
>  What:		/sys/devices/system/cpu/cpu#/cpu_capacity
>  Date:		December 2016
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 2e2219cbd54c..9f29d4d1ef7e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -67,6 +67,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/sort.h>
>  #include <linux/stop_machine.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>
>  #include <linux/mm.h>
>  #include <linux/cpu.h>
> @@ -1236,6 +1237,24 @@ bool system_has_mismatched_32bit_el0(void)
>  	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
>  }
>  
> +static ssize_t aarch32_el0_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	const struct cpumask *mask = system_32bit_el0_cpumask();
> +	return sprintf(buf, "%*pbl\n", cpumask_pr_args(mask));

sysfs_emit()?

And a blank line to make checkpatch.pl happy :)

> +}
> +static const struct kobj_attribute aarch32_el0_attr = __ATTR_RO(aarch32_el0);

DEVICE_ATTR_RO()?

> +
> +static int __init aarch32_el0_sysfs_init(void)
> +{
> +	if (!__allow_mismatched_32bit_el0)
> +		return 0;
> +
> +	return sysfs_create_file(&cpu_subsys.dev_root->kobj,
> +				 &aarch32_el0_attr.attr);

device_create_file() please, dev_root is a struct device, no need to
"thunk" down to a "raw" sysfs call.

thanks,

greg k-h
