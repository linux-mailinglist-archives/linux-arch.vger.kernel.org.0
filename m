Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17D2A29B2
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgKBLpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 06:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgKBLow (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 06:44:52 -0500
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F59321556;
        Mon,  2 Nov 2020 11:44:48 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:44:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201102114444.GC21082@gaia>
References: <20201028111204.GB13345@gaia>
 <20201028111713.GA27927@willie-the-truck>
 <20201028112206.GD13345@gaia>
 <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030161353.GC32582@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 04:13:53PM +0000, Will Deacon wrote:
> On Fri, Oct 30, 2020 at 11:18:47AM +0000, Catalin Marinas wrote:
> > On Thu, Oct 29, 2020 at 10:20:48PM +0000, Will Deacon wrote:
> > >     This means that if the first 32-bit-capable core is onlined late, then
> > >     it will only get the base capabilities, but I think that's fine and
> > >     consistent with our overall handling of hwcaps (which cannot appear
> > >     dynamically to userspace).
> > 
> > Yes but such bare 32-bit mode is entirely useless and I don't think we
> > should even pretend we have 32-bit. The compat hwcaps here would be
> > "half thumb fastmult edsp tls idiva idivt lpae evtstrm", statically
> > filled in. It's missing major bits like "vfp" and "neon" which are
> > necessary for the general purpose 32-bit EABI.
> 
> So? If we found such a CPU during boot, would we refuse to online it because
> we consider it "entirely useless"? No!

We _do_ online it but as a 64-bit only CPU if there were no early 32-bit
CPUs since we are not updating the compat hwcaps anyway (and that's
handled automatically by WEAK_LOCAL_CPU_FEATURE; we do this in a few
places already).

> That said, given that it's _very_
> likely for the late CPUs to support vfp and neon, we could set those caps
> speculatively if the 64-bit cores have fpsimd (late onlining would be
> prevented for cores lacking those). Does the architecture allow you to
> implement both AArch64 and AArch32 at EL0, but only have fpsimd for AArch64?

Probably not but I don't want to butcher the cpufeature support further
and have compat hwcaps derived from ID_AA64* regs. I find this hack even
worse and I'd rather live with the partial hwcap information (and hope
user space doesn't read hwcaps anyway ;)).

I don't see why we should change this code further when the requirement
to the mobile vendors is to simply allow a 32-bit CPU to come up early.

> > As I said above, I think we would be even more inconsistent w.r.t.
> > HWCAPs if we require at least one early AArch32-capable CPU, otherwise
> > don't expose 32-bit at all. I don't see what we gain by allowing all
> > 32-bit CPUs to come in late, other than maybe saving an entry in the
> > cpufeature array.
> 
> It's a combination of there not being a good reason to prevent the
> late-onlining and not gaining anything from the additional feature (I've
> already shown why it doesn't help with the vast majority of callsites).

I underlined above, this is not about preventing late onlining, only
preventing late 32-bit support. Late AArch32-capable CPUs will be
onlined just fine, only that if we haven't got any prior 32-bit CPU, we
no longer report the feature and the sysfs mask.

All I'm asking is something along the lines of the diff below instead of
forcing ARM64_HAS_32BIT_EL0 always on (untested):

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 42868dbd29fd..f73631aeedae 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -65,7 +65,8 @@
 #define ARM64_HAS_ARMv8_4_TTL			55
 #define ARM64_HAS_TLB_RANGE			56
 #define ARM64_MTE				57
+#define ARM64_HAS_WEAK_32BIT_EL0		58
 
-#define ARM64_NCAPS				58
+#define ARM64_NCAPS				59
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f7e7144af174..f8da673a9a20 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -584,7 +584,16 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 
 static inline bool system_supports_32bit_el0(void)
 {
-	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
+	return __allow_mismatched_32bit_el0 ?
+		cpus_have_const_cap(ARM64_HAS_WEAK_32BIT_EL0) :
+		cpus_have_const_cap(ARM64_HAS_32BIT_EL0)
+}
+
+static inline bool system_has_mismatched_32bit_el0(void)
+{
+	return __allow_mismatched_32bit_el0 &&
+		cpus_have_const_cap(ARM64_HAS_WEAK_32BIT_EL0) &&
+		!cpus_have_const_cap(ARM64_HAS_32BIT_EL0)
 }
 
 static inline bool system_supports_4kb_granule(void)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..fd7554602c5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1809,6 +1809,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
 		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
 	},
+	{
+		.capability = ARM64_HAS_WEAK_32BIT_EL0,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
+	},
 #ifdef CONFIG_KVM
 	{
 		.desc = "32-bit EL1 Support",
