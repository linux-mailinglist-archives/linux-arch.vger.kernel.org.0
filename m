Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68642251A39
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 15:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHYNxu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 09:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgHYNxu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 09:53:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814ED20738;
        Tue, 25 Aug 2020 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598363629;
        bh=dg7cDSh3lmu70QYdEm2jRVJHyaupRiNoFaTejHvwkvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xquzrLu34R3/yVdi6EqBHGcQrSbBM/36qwGgxbE0w9p9pEgTvWEw58wFg7+xaxIS/
         vu0/dhG7U6jQENM7pCsgvoZe2eZfw/MKTE+KopRl6513JpmeZK2GH38XTwiYUy4zn+
         vLepNMRAYmA+/RzO5BbscQxFJc+G+QMpTzgHGCfg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAZOW-006YOg-1I; Tue, 25 Aug 2020 14:53:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 14:53:47 +0100
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
In-Reply-To: <20200825105450.GA22233@C02TF0J2HF1T.local>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
 <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
 <20200825105450.GA22233@C02TF0J2HF1T.local>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <8ef4b3d5d860346e47f4238bdb0f2a91@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, vincenzo.frascino@arm.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, will@kernel.org, Dave.Martin@arm.com, szabolcs.nagy@arm.com, kevin.brodsky@arm.com, andreyknvl@google.com, pcc@google.com, akpm@linux-foundation.org, Suzuki.Poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-08-25 11:54, Catalin Marinas wrote:
> On Tue, Aug 25, 2020 at 09:53:16AM +0100, Marc Zyngier wrote:
>> On 2020-08-24 19:27, Catalin Marinas wrote:
>> > diff --git a/arch/arm64/include/asm/kvm_arm.h
>> > b/arch/arm64/include/asm/kvm_arm.h
>> > index 8a1cbfd544d6..6c3b2fc922bb 100644
>> > --- a/arch/arm64/include/asm/kvm_arm.h
>> > +++ b/arch/arm64/include/asm/kvm_arm.h
>> > @@ -78,7 +78,7 @@
>> >  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
>> >  			 HCR_FMO | HCR_IMO)
>> >  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
>> > -#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
>> > +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
>> >  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
>> 
>> Why is HCR_ATA only set for nVHE? HCR_EL2.ATA seems to apply to both,
>> doesn't it?
> 
> We need HCR_EL2.ATA to be set when !VHE so that the host kernel can use
> MTE. That said, I think we need to turn it off when running a guest.
> Even if we hide the ID register, the guest may still attempt to enable
> tags on some memory that doesn't support it, leading to unpredictable
> behaviour (well, only if we expose device memory to guests directly;
> Steve's patches will deal with this but for now we just disable MTE in
> guests).
> 
> With VHE, HCR_EL2.ATA only affects the guests, so it can stay off. The
> host's use of tags is controlled by SCTLR_EL1/EL2.ATA (i.e. HCR_EL2.ATA
> has no effect if E2H and TGE are both 1; qemu has a bug here which I
> discovered yesterday).

Ah, I missed that too.

> 
>> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> > index 077293b5115f..59b91f58efec 100644
>> > --- a/arch/arm64/kvm/sys_regs.c
>> > +++ b/arch/arm64/kvm/sys_regs.c
>> > @@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu
>> > *vcpu,
>> >  		if (!vcpu_has_sve(vcpu))
>> >  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>> >  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>> > +	} else if (id == SYS_ID_AA64PFR1_EL1) {
>> > +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>> 
>> Hiding the capability is fine, but where is the handling of trapping
>> instructions done? They should result in an UNDEF being injected.
> 
> They are a few new MTE-specific MSR/MRS which are trapped at EL2 but
> since KVM doesn't understand them yet, shouldn't it already inject
> undef back at EL1? That would be safer regardless of MTE support.

An UNDEF will be injected, but not without spitting a nastygram in
the kernel log (look at emulate_sys_reg()).

The best course of action is to have an entry in the sysreg table
that would explicitly do the handling.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
