Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD762881FE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgJIGOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 02:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbgJIGN7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 02:13:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE3121527;
        Fri,  9 Oct 2020 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602224039;
        bh=BpBCyZtqZokE3MkM9aNGAmttL9r/254fEF1BvkawdrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTMvjHeVPdr5ffAAySVPXLlAS3AEd+rahcbf+nkgtnKqT93zCxSMUHRTXhQGEP4aG
         tZK+qjonRfA8mPMqlgxQnCPjU4LALz38mQhDNXsBDsTcMWjQ68yqFHYLaIV5OMI5C8
         Jz3aexXqVTtDxaskaX14J94d3ghCMbiaX5iQQi+8=
Date:   Fri, 9 Oct 2020 08:13:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201009061356.GA120580@kroah.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008181641.32767-3-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 08, 2020 at 07:16:40PM +0100, Qais Yousef wrote:
> When the CONFIG_ASYMMETRIC_AARCH32 option is enabled (EXPERT), the type
> of the ARM64_HAS_32BIT_EL0 capability becomes WEAK_LOCAL_CPU_FEATURE.
> The kernel will now return true for system_supports_32bit_el0() and
> checks 32-bit tasks are affined to AArch32 capable CPUs only in
> do_notify_resume(). If the affinity contains a non-capable AArch32 CPU,
> the tasks will get SIGKILLed. If the last CPU supporting 32-bit is
> offlined, the kernel will SIGKILL any scheduled 32-bit tasks (the
> alternative is to prevent offlining through a new .cpu_disable feature
> entry).
> 
> In addition to the relaxation of the ARM64_HAS_32BIT_EL0 capability,
> this patch factors out the 32-bit cpuinfo and features setting into
> separate functions: __cpuinfo_store_cpu_32bit(),
> init_cpu_32bit_features(). The cpuinfo of the booting CPU
> (boot_cpu_data) is now updated on the first 32-bit capable CPU even if
> it is a secondary one. The ID_AA64PFR0_EL0_64BIT_ONLY feature is relaxed
> to FTR_NONSTRICT and FTR_HIGHER_SAFE when the asymmetric AArch32 support
> is enabled. The compat_elf_hwcaps are only verified for the
> AArch32-capable CPUs to still allow hotplugging AArch64-only CPUs.
> 
> Make sure that KVM never sees the asymmetric 32bit system. Guest can
> still ignore ID registers and force run 32bit at EL0.
> 
> Co-developed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  arch/arm64/Kconfig                   | 14 ++++++
>  arch/arm64/include/asm/cpu.h         |  2 +
>  arch/arm64/include/asm/cpucaps.h     |  3 +-
>  arch/arm64/include/asm/cpufeature.h  | 20 +++++++-
>  arch/arm64/include/asm/thread_info.h |  5 +-
>  arch/arm64/kernel/cpufeature.c       | 66 +++++++++++++++-----------
>  arch/arm64/kernel/cpuinfo.c          | 71 ++++++++++++++++++----------
>  arch/arm64/kernel/process.c          | 17 +++++++
>  arch/arm64/kernel/signal.c           | 18 +++++++
>  arch/arm64/kvm/arm.c                 |  5 +-
>  arch/arm64/kvm/guest.c               |  2 +-
>  arch/arm64/kvm/sys_regs.c            | 14 +++++-
>  12 files changed, 176 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..591853504dc4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1868,6 +1868,20 @@ config DMI
>  
>  endmenu
>  
> +config ASYMMETRIC_AARCH32
> +	bool "Allow support for asymmetric AArch32 support"
> +	depends on COMPAT && EXPERT

Why EXPERT?  You don't want this able to be enabled by anyone?

> +	help
> +	  Enable this option to allow support for asymmetric AArch32 EL0
> +	  CPU configurations. Once the AArch32 EL0 support is detected
> +	  on a CPU, the feature is made available to user space to allow
> +	  the execution of 32-bit (compat) applications. If the affinity
> +	  of the 32-bit application contains a non-AArch32 capable CPU
> +	  or the last AArch32 capable CPU is offlined, the application
> +	  will be killed.
> +
> +	  If unsure say N.
> +
>  config SYSVIPC_COMPAT
>  	def_bool y
>  	depends on COMPAT && SYSVIPC
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 7faae6ff3ab4..c920fa45e502 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -15,6 +15,7 @@
>  struct cpuinfo_arm64 {
>  	struct cpu	cpu;
>  	struct kobject	kobj;
> +	bool		aarch32_valid;

Do you mean to cause holes in this structure?  :)

Isn't "valid" the common thing?  Do you now have to explicitly enable
this everywhere instead of just dealing with the uncommon case of this
cpu variant?

I don't see this information being exported to userspace anywhere.  I
know Intel has submitted a patch to export this "type" of thing to the
cpu sysfs directories, can you do the same thing here?

Otherwise, how is userspace supposed to know where to place programs
that are 32bit?

thanks,

greg k-h
