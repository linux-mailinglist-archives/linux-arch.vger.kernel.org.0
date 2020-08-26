Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0532535B8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZRIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 13:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHZRIb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 13:08:31 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC10D20737;
        Wed, 26 Aug 2020 17:08:28 +0000 (UTC)
Date:   Wed, 26 Aug 2020 18:08:26 +0100
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
Message-ID: <20200826170826.GC24545@gaia>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
 <20200824182758.27267-4-catalin.marinas@arm.com>
 <61bba3c1948651a5221b87f2dfa2872f@kernel.org>
 <20200825105450.GA22233@C02TF0J2HF1T.local>
 <8ef4b3d5d860346e47f4238bdb0f2a91@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef4b3d5d860346e47f4238bdb0f2a91@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 25, 2020 at 02:53:47PM +0100, Marc Zyngier wrote:
> On 2020-08-25 11:54, Catalin Marinas wrote:
> > On Tue, Aug 25, 2020 at 09:53:16AM +0100, Marc Zyngier wrote:
> > > On 2020-08-24 19:27, Catalin Marinas wrote:
> > > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > > index 077293b5115f..59b91f58efec 100644
> > > > --- a/arch/arm64/kvm/sys_regs.c
> > > > +++ b/arch/arm64/kvm/sys_regs.c
> > > > @@ -1131,6 +1131,8 @@ static u64 read_id_reg(const struct kvm_vcpu
> > > > *vcpu,
> > > >  		if (!vcpu_has_sve(vcpu))
> > > >  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > > >  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> > > > +	} else if (id == SYS_ID_AA64PFR1_EL1) {
> > > > +		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> > > 
> > > Hiding the capability is fine, but where is the handling of trapping
> > > instructions done? They should result in an UNDEF being injected.
> > 
> > They are a few new MTE-specific MSR/MRS which are trapped at EL2 but
> > since KVM doesn't understand them yet, shouldn't it already inject
> > undef back at EL1? That would be safer regardless of MTE support.
> 
> An UNDEF will be injected, but not without spitting a nastygram in
> the kernel log (look at emulate_sys_reg()).
> 
> The best course of action is to have an entry in the sysreg table
> that would explicitly do the handling.

Something like below. I'll put them in a separate patch, to be reverted
when we get proper MTE support in KVM.

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 59b91f58efec..c7d5d1bae044 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1384,6 +1384,13 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			    const struct sys_reg_desc *r)
+{
+	kvm_inject_undefined(vcpu);
+	return false;
+}
+
 /* sys_reg_desc initialiser for known cpufeature ID registers */
 #define ID_SANITISED(name) {			\
 	SYS_DESC(SYS_##name),			\
@@ -1549,6 +1556,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
 	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
 	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+
+	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs },
+	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs },
+
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
@@ -1573,6 +1584,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
 
+	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs },
+	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs },
+
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 

(still testing, it takes ages to boot a VM inside inside FVP)

-- 
Catalin
