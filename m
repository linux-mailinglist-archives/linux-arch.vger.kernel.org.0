Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE0295011
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502585AbgJUPjS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 11:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502581AbgJUPjS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 11:39:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4BB21534;
        Wed, 21 Oct 2020 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603294757;
        bh=HMltzI7JnukdVvUZIEtRhwrce8tuBnmFpEYGLyjz240=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljSVHbUnJUOtqcxT6R0KrcH3JY5yRUWluUYRcsr/ALYfe+GJCeEMfwdLA1jpZxUBT
         g/Um+qs6yzafxaoL/EXsTh4/34v0tQ1s2rTtxi14b0upzEbLXeV2hotrzxsf0yNInv
         72NNimcyzmm1OJhq8w4mIbFbZQhQAcR8PYdTYWYc=
Date:   Wed, 21 Oct 2020 16:39:12 +0100
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
Subject: Re: [RFC PATCH v2 2/4] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201021153911.GC18071@willie-the-truck>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021104611.2744565-3-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 11:46:09AM +0100, Qais Yousef wrote:
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

[...]

> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 5e784e16ee89..312974ab2c85 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -67,6 +67,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
> +#define TIF_CHECK_32BIT_AFFINITY 6	/* Check thread affinity for asymmetric AArch32 */

I've looked through the patch and I still can't figure out why this extra
flag is needed. We know if a CPU supports 32-bit EL0, and we know whether
or not a task is 32-bit. So why the extra flag? Is it just a hangover from
the old series?

Cheers,

Will
