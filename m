Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8383E2C6C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 16:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhHFOZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhHFOZR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Aug 2021 10:25:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0939C0613CF
        for <linux-arch@vger.kernel.org>; Fri,  6 Aug 2021 07:25:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so9127812wms.2
        for <linux-arch@vger.kernel.org>; Fri, 06 Aug 2021 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cSeT0W6nMXWssnlqJp8Z8IJyv8VXh5EkL7xMtCUxbZo=;
        b=rTvOTFZrYKap4OeFRQmOdby67/SMy4EclOGQvSbCVcKowzIGH+vfZ58I4oJ+094wjK
         Tndqrd+HE4X1GfXNTJv9G6Mrl9EQF0henRAcC3PYey2ZE3I2oJ6DW0DoFDVUD41e3+uU
         e63/xjTQhUEdJS5AnNzq94Ttve77A0+7RmfWuMJ5dkpw69gSZmjuQsGRKw4fvV6wzKGn
         J8UPk89tMiYU+kc6yrvMvI4Ni6Eu+EhbzuOAOcHndPYxTGB3zyK2NMq6M7bjzrLS0InO
         Qf+47FFxQOzkojBCPILMWjazUkqz0P2HErji3eoiohr4Bl/0o/7Z+O31xQifteOokVc8
         LWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSeT0W6nMXWssnlqJp8Z8IJyv8VXh5EkL7xMtCUxbZo=;
        b=QbwJHJU44DH8R/oq/KEATA0euQfRX9D0kgn87Sr3WTDeDlKnmu302VC7aow2lsC6NG
         +4yEx4WF5QliffpDQlnaiQCF7BfEO5U8LuKd5femNdN21oihDsSgIsY9Ij+V6TiJyxoS
         Z5IGF5HF81dsE/FpGEOK9OfCRE6MsAleES+eHC5E8t+xdZ8j4abowPLAvVI1Ud6wsBqi
         YDx2TrSHNXshgATsY5D8jZaz1Xv0/1IH2SvJgRPPOhacLhOkAIsSUDrSAp45i3uWzs3e
         nF3B9ksgYuT5arRDFbbpak+kZqb06Bw7o0r+yS4JMtUB3rOxuUOkQbPYFVpNZj2952cF
         K1/g==
X-Gm-Message-State: AOAM532rVF0IGLoiT7MBYtp0plucKh4zFSoT+9oBcVpafqVQJqiEcffg
        e4sTn5E0L1/t1QzhmfQl0gJUmQ==
X-Google-Smtp-Source: ABdhPJy7p/Et1Nr62zf/Pd2hl1nK7Slpb+mjAFunudSgaOucOCVT1s4BHvF8R31IyxeA9a2VeRqjcg==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3538410wmc.95.1628259900037;
        Fri, 06 Aug 2021 07:25:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:41d5:61f3:25d7:c384])
        by smtp.gmail.com with ESMTPSA id m9sm9460025wrz.75.2021.08.06.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 07:24:59 -0700 (PDT)
Date:   Fri, 6 Aug 2021 15:24:56 +0100
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: arm64: Upgrade VMID accesses to
 {READ,WRITE}_ONCE
Message-ID: <YQ1GOAqlG9+25XS4@google.com>
References: <20210806113109.2475-1-will@kernel.org>
 <20210806113109.2475-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806113109.2475-6-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 06 Aug 2021 at 12:31:08 (+0100), Will Deacon wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> Since TLB invalidation can run in parallel with VMID allocation,
> we need to be careful and avoid any sort of load/store tearing.
> Use {READ,WRITE}_ONCE consistently to avoid any surprise.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jade Alglave <jade.alglave@arm.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_mmu.h      | 7 ++++++-
>  arch/arm64/kvm/arm.c                  | 2 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 4 ++--
>  arch/arm64/kvm/mmu.c                  | 2 +-
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 934ef0deff9f..5828dd8fa738 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -252,6 +252,11 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
>  
> +/*
> + * When this is (directly or indirectly) used on the TLB invalidation
> + * path, we rely on a previously issued DSB so that page table updates
> + * and VMID reads are correctly ordered.
> + */
>  static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
>  {
>  	struct kvm_vmid *vmid = &mmu->vmid;
> @@ -259,7 +264,7 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
>  	u64 cnp = system_supports_cnp() ? VTTBR_CNP_BIT : 0;
>  
>  	baddr = mmu->pgd_phys;
> -	vmid_field = (u64)vmid->vmid << VTTBR_VMID_SHIFT;
> +	vmid_field = (u64)READ_ONCE(vmid->vmid) << VTTBR_VMID_SHIFT;
>  	return kvm_phys_to_vttbr(baddr) | vmid_field | cnp;
>  }
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..658f76067f46 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -571,7 +571,7 @@ static void update_vmid(struct kvm_vmid *vmid)
>  		kvm_call_hyp(__kvm_flush_vm_context);
>  	}
>  
> -	vmid->vmid = kvm_next_vmid;
> +	WRITE_ONCE(vmid->vmid, kvm_next_vmid);
>  	kvm_next_vmid++;
>  	kvm_next_vmid &= (1 << kvm_get_vmid_bits()) - 1;
>  
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d4e74ca7f876..55ae97a144b8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -109,8 +109,8 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
>  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
>  	mmu->arch = &host_kvm.arch;
>  	mmu->pgt = &host_kvm.pgt;
> -	mmu->vmid.vmid_gen = 0;
> -	mmu->vmid.vmid = 0;
> +	WRITE_ONCE(mmu->vmid.vmid_gen, 0);
> +	WRITE_ONCE(mmu->vmid.vmid, 0);

I'm guessing it should be safe to omit those? But they certainly don't
harm and can serve as documentation anyway, so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin

>  
>  	return 0;
>  }
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3155c9e778f0..b1a6eaec28ff 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -485,7 +485,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  	mmu->arch = &kvm->arch;
>  	mmu->pgt = pgt;
>  	mmu->pgd_phys = __pa(pgt->pgd);
> -	mmu->vmid.vmid_gen = 0;
> +	WRITE_ONCE(mmu->vmid.vmid_gen, 0);
>  	return 0;
>  
>  out_destroy_pgtable:
> -- 
> 2.32.0.605.g8dce9f2422-goog
> 
