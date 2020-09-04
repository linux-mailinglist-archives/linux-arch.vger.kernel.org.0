Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2625D5B6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgIDKKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDKKn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:10:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6522D206D4;
        Fri,  4 Sep 2020 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599214242;
        bh=Iglnk7utwYjnaeEpyW3RYyUwfqjkaWTMLTJ/sOFzZV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+cGOChxoZsVZhIFYOHnHWJvffa2+doBVS3MKM7rWxt+YTeEEoB1iukqAjob7LqVG
         uKdsFalbmBWPfh8/YU6zrhHyVi2q4Ysa4OBFxqPvcLnWMwoZS4QsAESPdHjR0u6png
         WOJ2dggU9c2ZV00SvjtkHrwrB6RTutxx9djjw/+M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kE8g4-0098AJ-Qa; Fri, 04 Sep 2020 11:10:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Sep 2020 11:10:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
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
In-Reply-To: <20200826170826.GC24545@gaia>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
 <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
 <20200825105450.GA22233@C02TF0J2HF1T.local>
 <8ef4b3d5d860346e47f4238bdb0f2a91@kernel.org> <20200826170826.GC24545@gaia>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <220424c4145ac4093c47531e8819a070@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, vincenzo.frascino@arm.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, will@kernel.org, Dave.Martin@arm.com, szabolcs.nagy@arm.com, kevin.brodsky@arm.com, andreyknvl@google.com, pcc@google.com, akpm@linux-foundation.org, Suzuki.Poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-08-26 18:08, Catalin Marinas wrote:
> On Tue, Aug 25, 2020 at 02:53:47PM +0100, Marc Zyngier wrote:
>> On 2020-08-25 11:54, Catalin Marinas wrote:
>> > On Tue, Aug 25, 2020 at 09:53:16AM +0100, Marc Zyngier wrote:
>> > > On 2020-08-24 19:27, Catalin Marinas wrote:
>> > > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> > > > index 077293b5115f..59b91f58efec 100644
>> > > > --- a/arch/arm64/kvm/sys_regs.c
>> > > > +++ b/arch/arm64/kvm/sys_regs.c
>> > > > @@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu
>> > > > *vcpu,
>> > > >  		if (!vcpu_has_sve(vcpu))
>> > > >  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>> > > >  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>> > > > +	} else if (id == SYS_ID_AA64PFR1_EL1) {
>> > > > +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>> > >
>> > > Hiding the capability is fine, but where is the handling of trapping
>> > > instructions done? They should result in an UNDEF being injected.
>> >
>> > They are a few new MTE-specific MSR/MRS which are trapped at EL2 but
>> > since KVM doesn't understand them yet, shouldn't it already inject
>> > undef back at EL1? That would be safer regardless of MTE support.
>> 
>> An UNDEF will be injected, but not without spitting a nastygram in
>> the kernel log (look at emulate_sys_reg()).
>> 
>> The best course of action is to have an entry in the sysreg table
>> that would explicitly do the handling.
> 
> Something like below. I'll put them in a separate patch, to be reverted
> when we get proper MTE support in KVM.
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 59b91f58efec..c7d5d1bae044 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1384,6 +1384,13 @@ static bool access_ccsidr(struct kvm_vcpu
> *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
> 
> +static bool access_mte_regs(struct kvm_vcpu *vcpu, struct 
> sys_reg_params *p,
> +			    const struct sys_reg_desc *r)
> +{
> +	kvm_inject_undefined(vcpu);
> +	return false;
> +}
> +
>  /* sys_reg_desc initialiser for known cpufeature ID registers */
>  #define ID_SANITISED(name) {			\
>  	SYS_DESC(SYS_##name),			\
> @@ -1549,6 +1556,10 @@ static const struct sys_reg_desc sys_reg_descs[] 
> = {
>  	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 
> 0x00C50078 },
>  	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
>  	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
> +
> +	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs },
> +	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs },
> +
>  	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility =
> sve_visibility },
>  	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
>  	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
> @@ -1573,6 +1584,9 @@ static const struct sys_reg_desc sys_reg_descs[] 
> = {
>  	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
>  	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
> 
> +	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs },
> +	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs },
> +
>  	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
>  	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },

Yup, looks good.

> (still testing, it takes ages to boot a VM inside inside FVP)

You aren't allowed to moan about it until you have tried that with NV! 
;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
