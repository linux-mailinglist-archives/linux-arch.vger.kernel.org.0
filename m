Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994352514A0
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYIxU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 04:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHYIxT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 04:53:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67C42065F;
        Tue, 25 Aug 2020 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598345599;
        bh=qVtzvPt8utxsO0tcKG1A7vsPaEcIuMmBWjFifpCIBCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UGw4fE3bO3bG0OD/6ngOZpNCwnpSNW1lWwt9CdFx/4xLXnKBbUzoGdelwmUa2k+4h
         NbPndi7P0kyFKZ7ULQeKTuUEjXWxQzwemugWpvhd7DlH0Q5zNdxgLtb01zm1FMVzaK
         aCiGznnDpvglZIab7NdenzVoQnWT7dLWdDRNjdbM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAUhg-006TYE-R5; Tue, 25 Aug 2020 09:53:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 09:53:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v8 03/28] arm64: mte: CPU feature detection and initial
 sysreg configuration
In-Reply-To: <20200824182758.27267-4-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, vincenzo.frascino@arm.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, will@kernel.org, Dave.Martin@arm.com, szabolcs.nagy@arm.com, kevin.brodsky@arm.com, andreyknvl@google.com, pcc@google.com, akpm@linux-foundation.org, Suzuki.Poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-08-24 19:27, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Add the cpufeature and hwcap entries to detect the presence of MTE. Any
> secondary CPU not supporting the feature, if detected on the boot CPU,
> will be parked.
> 
> Add the minimum SCTLR_EL1 and HCR_EL2 bits for enabling MTE. The Normal
> Tagged memory type is configured in MAIR_EL1 before the MMU is enabled
> in order to avoid disrupting other CPUs in the CnP domain.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> ---
> 
> Notes:
>     v8:
>     - Move the SCTLR_EL1, MAIR_EL1, GCR_EL1 and TFSR*_EL1 
> initialisation to
>       __cpu_setup before the MMU is enabled. While early MAIR_EL1 is
>       desirable to avoid conflicting with other CPUs in a CnP domain 
> the
>       TFSR_EL1 and GCR_EL1 will only come in handy later when support 
> for
>       in-kernel MTE is added.
> 
>     v7:
>     - Hide the MTE ID register field for guests until MTE gains support 
> for KVM.
> 
>  arch/arm64/include/asm/cpucaps.h    |  3 ++-
>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>  arch/arm64/include/asm/hwcap.h      |  2 +-
>  arch/arm64/include/asm/kvm_arm.h    |  2 +-
>  arch/arm64/include/asm/sysreg.h     |  1 +
>  arch/arm64/include/uapi/asm/hwcap.h |  2 +-
>  arch/arm64/kernel/cpufeature.c      | 17 +++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c         |  2 +-
>  arch/arm64/kvm/sys_regs.c           |  2 ++
>  arch/arm64/mm/proc.S                | 24 ++++++++++++++++++++++++
>  10 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h 
> b/arch/arm64/include/asm/cpucaps.h
> index 07b643a70710..1937653b05a3 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -64,7 +64,8 @@
>  #define ARM64_BTI				54
>  #define ARM64_HAS_ARMv8_4_TTL			55
>  #define ARM64_HAS_TLB_RANGE			56
> +#define ARM64_MTE				57
> 
> -#define ARM64_NCAPS				57
> +#define ARM64_NCAPS				58
> 
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/cpufeature.h
> b/arch/arm64/include/asm/cpufeature.h
> index 89b4f0142c28..680b5b36ddd5 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -681,6 +681,12 @@ static __always_inline bool
> system_uses_irq_prio_masking(void)
>  	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
>  }
> 
> +static inline bool system_supports_mte(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_MTE) &&
> +		cpus_have_const_cap(ARM64_MTE);
> +}
> +
>  static inline bool system_has_prio_mask_debugging(void)
>  {
>  	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
> diff --git a/arch/arm64/include/asm/hwcap.h 
> b/arch/arm64/include/asm/hwcap.h
> index 22f73fe09030..0d4a6741b6a5 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -95,7 +95,7 @@
>  #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
>  #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
>  #define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
> -/* reserved for KERNEL_HWCAP_MTE	__khwcap2_feature(MTE) */
> +#define KERNEL_HWCAP_MTE		__khwcap2_feature(MTE)
> 
>  /*
>   * This yields a mask that user programs can use to figure out what
> diff --git a/arch/arm64/include/asm/kvm_arm.h 
> b/arch/arm64/include/asm/kvm_arm.h
> index 8a1cbfd544d6..6c3b2fc922bb 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -78,7 +78,7 @@
>  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
>  			 HCR_FMO | HCR_IMO)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> -#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
> +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
>  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)

Why is HCR_ATA only set for nVHE? HCR_EL2.ATA seems to apply to both,
doesn't it?

> 
>  /* TCR_EL2 Registers bits */

[...]

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 077293b5115f..59b91f58efec 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu 
> *vcpu,
>  		if (!vcpu_has_sve(vcpu))
>  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> +	} else if (id == SYS_ID_AA64PFR1_EL1) {
> +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);

Hiding the capability is fine, but where is the handling of trapping
instructions done? They should result in an UNDEF being injected.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
