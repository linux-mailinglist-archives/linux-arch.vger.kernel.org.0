Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E1225338B
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHZPYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 11:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgHZPYR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 11:24:17 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3D82075E;
        Wed, 26 Aug 2020 15:24:14 +0000 (UTC)
Date:   Wed, 26 Aug 2020 16:24:12 +0100
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
Message-ID: <20200826152411.GA24545@gaia>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
 <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
 <20200825105450.GA22233@C02TF0J2HF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825105450.GA22233@C02TF0J2HF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 25, 2020 at 11:54:50AM +0100, Catalin Marinas wrote:
> On Tue, Aug 25, 2020 at 09:53:16AM +0100, Marc Zyngier wrote:
> > On 2020-08-24 19:27, Catalin Marinas wrote:
> > > diff --git a/arch/arm64/include/asm/kvm_arm.h
> > > b/arch/arm64/include/asm/kvm_arm.h
> > > index 8a1cbfd544d6..6c3b2fc922bb 100644
> > > --- a/arch/arm64/include/asm/kvm_arm.h
> > > +++ b/arch/arm64/include/asm/kvm_arm.h
> > > @@ -78,7 +78,7 @@
> > >  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> > >  			 HCR_FMO | HCR_IMO)
> > >  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> > > -#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
> > > +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
> > >  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
> > 
> > Why is HCR_ATA only set for nVHE? HCR_EL2.ATA seems to apply to both,
> > doesn't it?
> 
> We need HCR_EL2.ATA to be set when !VHE so that the host kernel can use
> MTE. That said, I think we need to turn it off when running a guest.
> Even if we hide the ID register, the guest may still attempt to enable
> tags on some memory that doesn't support it, leading to unpredictable
> behaviour (well, only if we expose device memory to guests directly;
> Steve's patches will deal with this but for now we just disable MTE in
> guests).

So if we want to properly disable MTE for guests when !VHE (not just the
ID reg), I came up with the diff below. However, given that Steven is
already working on KVM support, I wonder whether we could just make MTE
depend on !VHE temporarily, remove it once we get the full MTE KVM
support. It's up to you (either way, I still need to solve the undef
injection since that affects both VHE and !VHE; patch to follow).

diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index 69eae608d670..51204ac30154 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -32,10 +32,23 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
 	}
 
 	__load_guest_stage2(mmu);
+
+	/* MTE is not supported in guests yet, disable access to tags */
+	if (system_supports_mte()) {
+		u64 val = read_sysreg(hcr_el2);
+		val &= ~HCR_ATA;
+		write_sysreg(val, hcr_el2);
+	}
 }
 
 static void __tlb_switch_to_host(struct tlb_inv_context *cxt)
 {
+	/* Re-enable MTE for the host kernel */
+	if (system_supports_mte()) {
+		u64 val = read_sysreg(hcr_el2);
+		write_sysreg(val | HCR_ATA, hcr_el2);
+	}
+
 	write_sysreg(0, vttbr_el2);
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {

-- 
Catalin
