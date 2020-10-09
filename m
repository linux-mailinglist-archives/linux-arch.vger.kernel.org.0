Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55947288616
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgJIJkD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 05:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgJIJkD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 05:40:03 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8ACA22258;
        Fri,  9 Oct 2020 09:40:00 +0000 (UTC)
Date:   Fri, 9 Oct 2020 10:39:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201009093957.GD23638@gaia>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008181641.32767-3-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 08, 2020 at 07:16:40PM +0100, Qais Yousef wrote:
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 7faae6ff3ab4..c920fa45e502 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -15,6 +15,7 @@
>  struct cpuinfo_arm64 {
>  	struct cpu	cpu;
>  	struct kobject	kobj;
> +	bool		aarch32_valid;

As I replied to Greg, I think we can drop this field entirely. But, of
course, please check that the kernel doesn't get tainted if booting on a
non-32-bit capable CPU.

>  void cpuinfo_store_cpu(void)
>  {
>  	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
>  	__cpuinfo_store_cpu(info);
> +	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> +		__cpuinfo_store_cpu_32bit(info);
> +	/*
> +	 * With asymmetric AArch32 support, populate the boot CPU information
> +	 * on the first 32-bit capable secondary CPU if the primary one
> +	 * skipped this step.
> +	 */
> +	if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) &&
> +	    !boot_cpu_data.aarch32_valid &&
> +	    id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> +		__cpuinfo_store_cpu_32bit(&boot_cpu_data);
> +		init_cpu_32bit_features(&boot_cpu_data);
> +	}

Same here, we can probably drop the boot_cpu_data update here.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 077293b5115f..0b9aaee1df59 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1131,6 +1131,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		if (!vcpu_has_sve(vcpu))
>  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> +
> +		if (!system_supports_sym_32bit_el0()) {
> +			/*
> +			 * We could be running on asym aarch32 system.
> +			 * Override to present a aarch64 only system.
> +			 */
> +			val &= ~(0xfUL << ID_AA64PFR0_EL0_SHIFT);
> +			val |= (ID_AA64PFR0_EL0_64BIT_ONLY << ID_AA64PFR0_EL0_SHIFT);
> +		}

With the sanitised registers using the lowest value of this field, I
think we no longer need this explicit masking.

-- 
Catalin
