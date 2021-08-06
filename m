Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4042F3E2BB0
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbhHFNk2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbhHFNkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Aug 2021 09:40:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D5C0617A0
        for <linux-arch@vger.kernel.org>; Fri,  6 Aug 2021 06:40:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so6158124wmg.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Aug 2021 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fp2FsksUpuC70lwZPSSi0nDjJByoDoO4PpzbqKW0cT4=;
        b=icR9Int0QvvI0heodeFJD0pbyAXz7QjoptO/0cpBITayVgP+KEmgyE3q91jHhPzHVI
         lYJw8LFsckdwvdFPQMEtHdnm3Uf2LDM4NItv569axeYl+AjCA/t626QzX0lO2iplkG6N
         3OaHzooQYDQ9QfMyjYg3BI9lRYZHyNtcOvtmx9sOx+krNFV2uVxVblsGpTqYFwh7JPB+
         x3mc5O8XuPLPW3G8h8kPgmvmBwxG3WoV5/wuAYY+egCFkWssTPFoUnJX22FHO0pnWuVF
         2SX/pJ8mI73ryLUNvPXmnC/EpD57Fp42Ag08haakgb2+h9WcVcpSATaZtkupBV0rDt4X
         /W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fp2FsksUpuC70lwZPSSi0nDjJByoDoO4PpzbqKW0cT4=;
        b=mkmH0UpEsecHpyVS6oZxU1FHDAfiCRWnOc2gd8DfAeSfVCMA7ks3PK8WcHSIEa7Y42
         ZsJaqCQK7ifBLUvizwDs10VNTZu9xOfqzf0ZSNJLIjcn4K3pwDrAlEqbEhWDB+ewZuMR
         PIjO1lkkg9WDcu1NiX55HfuFq5/P98qbA3tvaoPj0Fa6CxxW7CU+h3ERFbH0mKEPt7eV
         +ZEd0EDmmtWyMwkqNjLrZ88Ui7rdMccqUiqHxDwjViv8jwvtDo5uCQKozFWDrQq9jzjb
         p8+wXmCAR9ohZKLsvqDd/Zmq6f4Spz3VNJ6gj7o3nwdxfJPF5MVheOQVYTR+v8njECMf
         b8HA==
X-Gm-Message-State: AOAM533cXItaUUpEM0WjTuq5Q3JNdkAmJEDDIzblXH1swaxa+5ZXOklg
        w4pJzl7dnbIP551KZPsMD95AMw==
X-Google-Smtp-Source: ABdhPJwMgXpUIgZ3CNM/dKFQroYWHpilibQOGQpLE/mgmpvBuB7hT+mGvH4kRQZS3oJY1s8Xi9S9Zg==
X-Received: by 2002:a05:600c:ad6:: with SMTP id c22mr3502882wmr.114.1628257204149;
        Fri, 06 Aug 2021 06:40:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:41d5:61f3:25d7:c384])
        by smtp.gmail.com with ESMTPSA id i14sm5642824wmq.40.2021.08.06.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 06:40:03 -0700 (PDT)
Date:   Fri, 6 Aug 2021 14:40:00 +0100
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: arm64: Convert the host S2 over to
 __load_guest_stage2()
Message-ID: <YQ07sPoa4ACizYrp@google.com>
References: <20210806113109.2475-1-will@kernel.org>
 <20210806113109.2475-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806113109.2475-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 06 Aug 2021 at 12:31:07 (+0100), Will Deacon wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> The protected mode relies on a separate helper to load the
> S2 context. Move over to the __load_guest_stage2() helper
> instead.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jade Alglave <jade.alglave@arm.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_mmu.h              | 11 +++--------
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  2 +-
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 05e089653a1a..934ef0deff9f 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -267,9 +267,10 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
>   * Must be called from hyp code running at EL2 with an updated VTTBR
>   * and interrupts disabled.
>   */
> -static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
> +static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
> +						struct kvm_arch *arch)
>  {
> -	write_sysreg(vtcr, vtcr_el2);
> +	write_sysreg(arch->vtcr, vtcr_el2);
>  	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
>  
>  	/*
> @@ -280,12 +281,6 @@ static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long
>  	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
>  }
>  
> -static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
> -						struct kvm_arch *arch)
> -{
> -	__load_stage2(mmu, arch->vtcr);
> -}
> -
>  static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
>  {
>  	return container_of(mmu->arch, struct kvm, arch);
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 9c227d87c36d..a910648bc71b 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -29,7 +29,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
>  static __always_inline void __load_host_stage2(void)
>  {
>  	if (static_branch_likely(&kvm_protected_mode_initialized))
> -		__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> +		__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
>  	else
>  		write_sysreg(0, vttbr_el2);
>  }
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d938ce95d3bd..d4e74ca7f876 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -126,7 +126,7 @@ int __pkvm_prot_finalize(void)
>  	kvm_flush_dcache_to_poc(params, sizeof(*params));
>  
>  	write_sysreg(params->hcr_el2, hcr_el2);
> -	__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> +	__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);

Nit: clearly we're not loading a guest stage-2 here, so maybe the
function should take a more generic name?

Thanks,
Quentin
