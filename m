Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239EC2C6303
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 11:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgK0KZK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 05:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK0KZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98ED206CA;
        Fri, 27 Nov 2020 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606472709;
        bh=2E1vIV9WnC2/+5ozoJCme5XRfPDFKCmwHxOWaJmPmv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1er4mSE0+RwnRxB+1ywN1f9x45KNBivHEscg4AhQbFkz/X9fABHS9P3cOHSnY8H6K
         QFE7raO2cuN6ng4ap9esIBmM4utga/L82JrIueYIB0ZrfcEq0+ssWrcBthWuuGqnjp
         mhStEivaG9RuEAuLnGNBu6evknwRaSp2929PG+Qk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kiaw6-00E1z6-Hw; Fri, 27 Nov 2020 10:25:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Nov 2020 10:25:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 02/14] arm64: Allow mismatched 32-bit EL0 support
In-Reply-To: <20201124155039.13804-3-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-3-will@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d7dfc12ca87d65fad79bfe2cd697a28d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, qperret@google.com, tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-24 15:50, Will Deacon wrote:
> When confronted with a mixture of CPUs, some of which support 32-bit
> applications and others which don't, we quite sensibly treat the system
> as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> 
> Unfortunately, some crazy folks have decided to build systems like this
> with the intention of running 32-bit applications, so relax our
> sanitisation logic to continue to advertise 32-bit support to userspace
> on these systems and track the real 32-bit capable cores in a cpumask
> instead. For now, the default behaviour remains but will be tied to
> a command-line option in a later patch.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/cpucaps.h    |   2 +-
>  arch/arm64/include/asm/cpufeature.h |   8 ++-
>  arch/arm64/kernel/cpufeature.c      | 106 ++++++++++++++++++++++++++--
>  3 files changed, 107 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h 
> b/arch/arm64/include/asm/cpucaps.h
> index e7d98997c09c..e6f0eb4643a0 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -20,7 +20,7 @@
>  #define ARM64_ALT_PAN_NOT_UAO			10
>  #define ARM64_HAS_VIRT_HOST_EXTN		11
>  #define ARM64_WORKAROUND_CAVIUM_27456		12
> -#define ARM64_HAS_32BIT_EL0			13
> +#define ARM64_HAS_32BIT_EL0_DO_NOT_USE		13
>  #define ARM64_HARDEN_EL2_VECTORS		14
>  #define ARM64_HAS_CNP				15
>  #define ARM64_HAS_NO_FPSIMD			16
> diff --git a/arch/arm64/include/asm/cpufeature.h
> b/arch/arm64/include/asm/cpufeature.h
> index 97244d4feca9..f447d313a9c5 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -604,9 +604,15 @@ static inline bool 
> cpu_supports_mixed_endian_el0(void)
>  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
>  }
> 
> +const struct cpumask *system_32bit_el0_cpumask(void);
> +DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> +
>  static inline bool system_supports_32bit_el0(void)
>  {
> -	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
> +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +
> +	return id_aa64pfr0_32bit_el0(pfr0) ||
> +	       static_branch_unlikely(&arm64_mismatched_32bit_el0);

nit: swapping the two sides of this expression has the potential
for slightly better code, resulting in better performance on
these asymmetric systems. Not a big real, but since this lands
on the fast path on vcpu exit, I'll take every bit of optimisation.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
