Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D921DEF5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGMRpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 13:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgGMRph (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 13:45:37 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CCB220738;
        Mon, 13 Jul 2020 17:45:35 +0000 (UTC)
Date:   Mon, 13 Jul 2020 18:45:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v6 02/26] arm64: mte: CPU feature detection and initial
 sysreg configuration
Message-ID: <20200713174531.GF15829@gaia>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-3-catalin.marinas@arm.com>
 <2fb4b560-fb2f-7689-05f7-d908b55cd1eb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb4b560-fb2f-7689-05f7-d908b55cd1eb@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 13, 2020 at 11:08:15AM +0100, Steven Price wrote:
> On 03/07/2020 16:36, Catalin Marinas wrote:
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > Add the cpufeature and hwcap entries to detect the presence of MTE on
> > the boot CPUs (primary and secondary). Any late secondary CPU not
> > supporting the feature, if detected during boot, will be parked.
> > 
> > In addition, add the minimum SCTLR_EL1 and HCR_EL2 bits for enabling
> > MTE. Without subsequent setting of MAIR, these bits do not have an
> > effect on tag checking.
> > 
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> 
> This commit causes the feature bit to be exposed to a guest, but we
> don't at this point have any way of handling a guest which attempts to
> use MTE.
> 
> This is 'fixed' by the first patch of my KVM MTE series[1], but perhaps
> the chunk modifying arch/arm64/kvm/sys_regs.c (see below) should be included here
> instead? That way we hide the feature until we're ready for a guest with
> MTE support.
> 
> Steve
>  [1] https://lore.kernel.org/r/20200713100102.53664-2-steven.price@arm.com
> 
> ----8<----
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index baf5ce9225ce..5ca974c93bd4 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1104,6 +1104,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		if (!vcpu_has_sve(vcpu))
>  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> +	} else if (id == SYS_ID_AA64PFR1_EL1) {
> +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>  	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>  		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>  			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |

Thanks Steven. I thought this worked on explicitly enabling the CPUID
for guests but I think I only checked with an old host kernel which was
masking the ID field anyway. I tried it again now and it indeed fails.

I'll fold this in.

-- 
Catalin
