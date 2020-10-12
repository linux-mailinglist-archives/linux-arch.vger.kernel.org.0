Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1428B4E6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgJLMqq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 08:46:46 -0400
Received: from foss.arm.com ([217.140.110.172]:43540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbgJLMqq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 08:46:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9D1D6E;
        Mon, 12 Oct 2020 05:46:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A293F66B;
        Mon, 12 Oct 2020 05:46:43 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:46:41 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201012124640.wnjqhbhknaova35a@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
 <20201009093957.GD23638@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009093957.GD23638@gaia>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/20 10:39, Catalin Marinas wrote:
> On Thu, Oct 08, 2020 at 07:16:40PM +0100, Qais Yousef wrote:
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
> As I replied to Greg, I think we can drop this field entirely. But, of
> course, please check that the kernel doesn't get tainted if booting on a
> non-32-bit capable CPU.

Faking asymmetry on Juno where CPU0 (boot CPU) is not 32bit capable

	dmesg | grep -i taint

returns nothing.

> 
> >  void cpuinfo_store_cpu(void)
> >  {
> >  	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
> >  	__cpuinfo_store_cpu(info);
> > +	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> > +		__cpuinfo_store_cpu_32bit(info);

 >>>>>>>

> > +	/*
> > +	 * With asymmetric AArch32 support, populate the boot CPU information
> > +	 * on the first 32-bit capable secondary CPU if the primary one
> > +	 * skipped this step.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_ASYMMETRIC_AARCH32) &&
> > +	    !boot_cpu_data.aarch32_valid &&
> > +	    id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> > +		__cpuinfo_store_cpu_32bit(&boot_cpu_data);
> > +		init_cpu_32bit_features(&boot_cpu_data);
> > +	}

<<<<<<<

> 
> Same here, we can probably drop the boot_cpu_data update here.

Removed the block above.

> 
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 077293b5115f..0b9aaee1df59 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1131,6 +1131,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> >  		if (!vcpu_has_sve(vcpu))
> >  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> >  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> > +
> > +		if (!system_supports_sym_32bit_el0()) {
> > +			/*
> > +			 * We could be running on asym aarch32 system.
> > +			 * Override to present a aarch64 only system.
> > +			 */
> > +			val &= ~(0xfUL << ID_AA64PFR0_EL0_SHIFT);
> > +			val |= (ID_AA64PFR0_EL0_64BIT_ONLY << ID_AA64PFR0_EL0_SHIFT);
> > +		}
> 
> With the sanitised registers using the lowest value of this field, I
> think we no longer need this explicit masking.

Indeed. Removed.

Thanks

--
Qais Yousef
