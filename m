Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009953F28DD
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhHTJJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhHTJJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Aug 2021 05:09:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37824C061575
        for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2021 02:09:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x12so13118826wrr.11
        for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2021 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=homr7BhZfULKwJxsWSjpHLSXBNKoWFprBlqIBvyqEBs=;
        b=MC4qaWaJVo8zKFIO6THLrRaPic7q3pRfvJAQMscoWQf0c5NGL5eWXxaFCHUG8Gp6Fk
         7d0wyudIxPLWXU7zOYig+uvWrIZ5lE4T5dNz7bmECVOo5sh6tL/Uqt6svUwgQwZVPBT8
         w4BCe7aG+vf5rpgHXJ36MWLGlj9V4zfRU87TQNrNWyBsMlmEcyemGtJoRLvjHWd7X0fX
         zAGBPkiaBSzlh3PCYtPQsZsBUmrDrravSv2zFyfTdWCZeE3cbTnY1fwVSFV7z0Zc2X3d
         i3bOPc9RdJY929xSzJx3KeD7US+IdvWBp5G4nb3skOud1jY9rMtjEQfiGhIZbIpAcuiH
         pg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=homr7BhZfULKwJxsWSjpHLSXBNKoWFprBlqIBvyqEBs=;
        b=RHeMVp8m7EnQR6dPVT5ALAThZUzCJnuzyDusvcuEAcYkaimCeE4qHfHN5w0NN8oVUu
         0fQDO7NcOCYnudzsE7bUfQv9cQx3t2B1SNSpMtCKyPjP3UN2vU8fkzL3AY3WiHE12PPY
         LDaWN4YkBJB5UyRTOk/hQc4bv2SMCCu45lXPN5uyiCbNSM7Q0kdwmVxMQ5/Hw0KGt2uN
         +1lD+e9SP9oKoMw/8fHNaYzlNRxLJVvKDZ/J+G6aGA+oawAA8aYtqbvGH8Y8OygrMjUb
         j1ijFOiyyzpH1Et+1k0PwRqLlYeTF3yLl8Nd8BnsqSkH0XR3l0CShY79YBppImZD6e5s
         irqw==
X-Gm-Message-State: AOAM5310OJjCz9VgrdaLRjOAzgAXBsp6Njj7VGKI8QbVZ2+J1OMFzFM3
        gGq93YpMHu82uPJzP9EqOgulFQ==
X-Google-Smtp-Source: ABdhPJwhE5FQaIWpAGA3IIIMKo9FNG/bGjI0OpuiyGbVaM8+tx0NBClA4NGvau3RWS6MGdI3dsa45g==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr8787846wrt.306.1629450542713;
        Fri, 20 Aug 2021 02:09:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e4b3:2bb8:a25f:81c7])
        by smtp.gmail.com with ESMTPSA id 11sm920948wmi.15.2021.08.20.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 02:09:02 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:08:56 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: arm64: Convert the host S2 over to
 __load_guest_stage2()
Message-ID: <YR9xKHYl7i2LN+/C@google.com>
References: <20210806113109.2475-1-will@kernel.org>
 <20210806113109.2475-5-will@kernel.org>
 <YQ07sPoa4ACizYrp@google.com>
 <87tujkr1cq.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tujkr1cq.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 20 Aug 2021 at 09:01:41 (+0100), Marc Zyngier wrote:
> On Fri, 06 Aug 2021 14:40:00 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > On Friday 06 Aug 2021 at 12:31:07 (+0100), Will Deacon wrote:
> > > From: Marc Zyngier <maz@kernel.org>
> > > 
> > > The protected mode relies on a separate helper to load the
> > > S2 context. Move over to the __load_guest_stage2() helper
> > > instead.
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Jade Alglave <jade.alglave@arm.com>
> > > Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/kvm_mmu.h              | 11 +++--------
> > >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
> > >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  2 +-
> > >  3 files changed, 5 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > > index 05e089653a1a..934ef0deff9f 100644
> > > --- a/arch/arm64/include/asm/kvm_mmu.h
> > > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > > @@ -267,9 +267,10 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
> > >   * Must be called from hyp code running at EL2 with an updated VTTBR
> > >   * and interrupts disabled.
> > >   */
> > > -static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
> > > +static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
> > > +						struct kvm_arch *arch)
> > >  {
> > > -	write_sysreg(vtcr, vtcr_el2);
> > > +	write_sysreg(arch->vtcr, vtcr_el2);
> > >  	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
> > >  
> > >  	/*
> > > @@ -280,12 +281,6 @@ static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long
> > >  	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
> > >  }
> > >  
> > > -static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
> > > -						struct kvm_arch *arch)
> > > -{
> > > -	__load_stage2(mmu, arch->vtcr);
> > > -}
> > > -
> > >  static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
> > >  {
> > >  	return container_of(mmu->arch, struct kvm, arch);
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > index 9c227d87c36d..a910648bc71b 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > > @@ -29,7 +29,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
> > >  static __always_inline void __load_host_stage2(void)
> > >  {
> > >  	if (static_branch_likely(&kvm_protected_mode_initialized))
> > > -		__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> > > +		__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
> > >  	else
> > >  		write_sysreg(0, vttbr_el2);
> > >  }
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index d938ce95d3bd..d4e74ca7f876 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -126,7 +126,7 @@ int __pkvm_prot_finalize(void)
> > >  	kvm_flush_dcache_to_poc(params, sizeof(*params));
> > >  
> > >  	write_sysreg(params->hcr_el2, hcr_el2);
> > > -	__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> > > +	__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
> > 
> > Nit: clearly we're not loading a guest stage-2 here, so maybe the
> > function should take a more generic name?
> 
> How about we rename __load_guest_stage2() to __load_stage2() instead,
> with the same parameters?

Yep, that'd work for me.

Thanks,
Quentin
