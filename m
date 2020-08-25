Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3A2516E9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgHYKzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 06:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKy7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 06:54:59 -0400
Received: from C02TF0J2HF1T.local (unknown [213.205.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA0F2068E;
        Tue, 25 Aug 2020 10:54:53 +0000 (UTC)
Date:   Tue, 25 Aug 2020 11:54:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
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
Message-ID: <20200825105450.GA22233@C02TF0J2HF1T.local>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
 <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 25, 2020 at 09:53:16AM +0100, Marc Zyngier wrote:
> On 2020-08-24 19:27, Catalin Marinas wrote:
> > diff --git a/arch/arm64/include/asm/kvm_arm.h
> > b/arch/arm64/include/asm/kvm_arm.h
> > index 8a1cbfd544d6..6c3b2fc922bb 100644
> > --- a/arch/arm64/include/asm/kvm_arm.h
> > +++ b/arch/arm64/include/asm/kvm_arm.h
> > @@ -78,7 +78,7 @@
> >  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> >  			 HCR_FMO | HCR_IMO)
> >  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> > -#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
> > +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
> >  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
> 
> Why is HCR_ATA only set for nVHE? HCR_EL2.ATA seems to apply to both,
> doesn't it?

We need HCR_EL2.ATA to be set when !VHE so that the host kernel can use
MTE. That said, I think we need to turn it off when running a guest.
Even if we hide the ID register, the guest may still attempt to enable
tags on some memory that doesn't support it, leading to unpredictable
behaviour (well, only if we expose device memory to guests directly;
Steve's patches will deal with this but for now we just disable MTE in
guests).

With VHE, HCR_EL2.ATA only affects the guests, so it can stay off. The
host's use of tags is controlled by SCTLR_EL1/EL2.ATA (i.e. HCR_EL2.ATA
has no effect if E2H and TGE are both 1; qemu has a bug here which I
discovered yesterday).

> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 077293b5115f..59b91f58efec 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu
> > *vcpu,
> >  		if (!vcpu_has_sve(vcpu))
> >  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> >  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> > +	} else if (id == SYS_ID_AA64PFR1_EL1) {
> > +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> 
> Hiding the capability is fine, but where is the handling of trapping
> instructions done? They should result in an UNDEF being injected.

They are a few new MTE-specific MSR/MRS which are trapped at EL2 but
since KVM doesn't understand them yet, shouldn't it already inject
undef back at EL1? That would be safer regardless of MTE support.

-- 
Catalin
