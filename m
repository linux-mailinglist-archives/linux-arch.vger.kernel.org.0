Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0822D8FF
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jul 2020 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGYRkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jul 2020 13:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgGYRkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Jul 2020 13:40:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20514206D7;
        Sat, 25 Jul 2020 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595698815;
        bh=sJTStXJxf1wWNfeh1Vyqzn+5Ew232NcAG80ITNfG5hI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uUkwBFhOHVDjpU7noEGFnVI9DSAoxP2OMDAudhOzaP1GS/psPb4m3M44mvCX+IojX
         xLTQveOr84GVFSSBW3fFF2ds+maI2ShlY5vmyl+b2F4RmKk1ltK0djQfnBtcVcBwTc
         AAXGU3+mxr47wJ9VkoxCZnvT9sMbCB6K5gBCF/Ww=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzO9d-00EsjE-IF; Sat, 25 Jul 2020 18:40:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 25 Jul 2020 18:40:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        steven.price@arm.com, mark.rutland@arm.com, ascull@google.com,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com
Subject: Re: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in
 unmap_stage2_range function
In-Reply-To: <20200724134315.805-1-yezhenyu2@huawei.com>
References: <20200724134315.805-1-yezhenyu2@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, steven.price@arm.com, mark.rutland@arm.com, ascull@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-07-24 14:43, Zhenyu Ye wrote:
> Now in unmap_stage2_range(), we flush tlbs one by one just after the
> corresponding pages cleared.  However, this may cause some performance
> problems when the unmap range is very large (such as when the vm
> migration rollback, this may cause vm downtime too loog).

You keep resending this patch, but you don't give any numbers
that would back your assertion.

> This patch moves the kvm_tlb_flush_vmid_ipa() out of loop, and
> flush tlbs by range after other operations completed.  Because we
> do not make new mapping for the pages here, so this doesn't violate
> the Break-Before-Make rules.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h |  2 ++
>  arch/arm64/kvm/hyp/tlb.c         | 36 ++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/mmu.c             | 11 +++++++---
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h 
> b/arch/arm64/include/asm/kvm_asm.h
> index 352aaebf4198..ef8203d3ca45 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -61,6 +61,8 @@ extern char __kvm_hyp_vector[];
> 
>  extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t 
> ipa);
> +extern void __kvm_tlb_flush_vmid_range(struct kvm *kvm, phys_addr_t 
> start,
> +				       phys_addr_t end);
>  extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>  extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
> 
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index d063a576d511..4f4737a7e588 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -189,6 +189,42 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct
> kvm *kvm, phys_addr_t ipa)
>  	__tlb_switch_to_host(kvm, &cxt);
>  }
> 
> +void __hyp_text __kvm_tlb_flush_vmid_range(struct kvm *kvm, 
> phys_addr_t start,
> +					   phys_addr_t end)
> +{
> +	struct tlb_inv_context cxt;
> +	unsigned long addr;
> +
> +	start = __TLBI_VADDR(start, 0);
> +	end = __TLBI_VADDR(end, 0);
> +
> +	dsb(ishst);
> +
> +	/* Switch to requested VMID */
> +	kvm = kern_hyp_va(kvm);
> +	__tlb_switch_to_guest(kvm, &cxt);
> +
> +	if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
> +		__tlbi(vmalls12e1is);

And what is this magic value based on? You don't even mention in the
commit log that you are taking this shortcut.

> +		goto end;
> +	}
> +
> +	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> +		__tlbi(ipas2e1is, addr);
> +
> +	dsb(ish);
> +	__tlbi(vmalle1is);
> +
> +end:
> +	dsb(ish);
> +	isb();
> +
> +	if (!has_vhe() && icache_is_vpipt())
> +		__flush_icache_all();
> +
> +	__tlb_switch_to_host(kvm, &cxt);
> +}
> +

I'm sorry, but without numbers backing this approach for a number
of workloads and a representative set of platforms, this is
going nowhere.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
