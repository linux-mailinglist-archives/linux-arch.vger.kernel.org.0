Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1E2CC3B9
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 18:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgLBR2P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 12:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgLBR2P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 12:28:15 -0500
Date:   Wed, 2 Dec 2020 17:27:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606930054;
        bh=ENrxk1To+GUgkJDSxzLowk/dPdrvaLx21Q/VS2M3IfU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=wlJR4iDNLLjYRaIRy0/SpTdBq3VcPMWEgXPncNp3x9rYxTlbC4I1gw5svpY/IizFb
         YEg3UC4s9AXZdk6Ls1xvjn7SBkc2F46ZuYPWmc7fvMxU8cgXgwm7oFxmVGalZV2NwH
         BzDoQgP9AVDzPcplUW1y6rbQyHNRZvnNsVCg6hQQ=
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 03/14] KVM: arm64: Kill 32-bit vCPUs on systems with
 mismatched EL0 support
Message-ID: <20201202172727.GC29813@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-4-will@kernel.org>
 <9bd06b193e7fb859a1207bb1302b7597@kernel.org>
 <20201127115304.GB20564@willie-the-truck>
 <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
 <20201127172434.GA984327@google.com>
 <9de8639549040b4478b312503fd5a23f@kernel.org>
 <20201201165707.GF27783@willie-the-truck>
 <5e59a8f5bc84403ce2c8f26aa874cb1b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e59a8f5bc84403ce2c8f26aa874cb1b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 08:18:03AM +0000, Marc Zyngier wrote:
> On 2020-12-01 16:57, Will Deacon wrote:
> > On Fri, Nov 27, 2020 at 06:16:35PM +0000, Marc Zyngier wrote:
> > > On 2020-11-27 17:24, Quentin Perret wrote:
> > > > On Friday 27 Nov 2020 at 17:14:11 (+0000), Marc Zyngier wrote:
> > > 
> > > [...]
> > > 
> > > > > Yeah, the sanitized read feels better, if only because that is
> > > > > what we are going to read in all the valid cases, unfortunately.
> > > > > read_sanitised_ftr_reg() is sadly not designed to be called on
> > > > > a fast path, meaning that 32bit guests will do a bsearch() on
> > > > > the ID-regs every time they exit...
> > > > >
> > > > > I guess we will have to evaluate how much we loose with this.
> > > >
> > > > Could we use the trick we have for arm64_ftr_reg_ctrel0 to speed this
> > > > up?
> > > 
> > > Maybe. I want to first verify whether this has any measurable impact.
> > > Another possibility would be to cache the last
> > > read_sanitised_ftr_reg()
> > > access, just to see if that helps. There shouldn't be that many code
> > > paths hammering it.
> > 
> > We don't have huge numbers of ID registers, so the bsearch shouldn't be
> > too expensive. However, I'd like to remind myself why we can't index
> > into
> > the feature register array directly as we _should_ know all of this
> > stuff
> > at compile time, right?
> 
> Simply because it's not indexed by ID reg. It's just an ordered collection,
> similar to the for sys_reg emulation in KVM. You can compute the index
> ahead of time, but just not at compile time. At least not with the
> way the arm64_ftr_regs array is built.

FWIW, if your testing shows that the bsearch() is costing us, I've hacked
up an interface to access the ID registers directly (see below) which I
can include with this series.

Will

--->8

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index da250e4741bd..23766104d756 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -599,7 +599,49 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
 void __init setup_cpu_features(void);
 void check_local_cpu_capabilities(void);
 
+#define ARM64_FTR_REG2IDX(id)	id ## _IDX
+enum arm64_ftr_reg_idx {
+	ARM64_FTR_REG2IDX(SYS_ID_PFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_PFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_DFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR2_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR3_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR2_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR3_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR4_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR5_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR4_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_ISAR6_EL1),
+	ARM64_FTR_REG2IDX(SYS_MVFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_MVFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_MVFR2_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_PFR2_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_DFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_MMFR5_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64PFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64PFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64ZFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64DFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64DFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64ISAR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64ISAR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64MMFR0_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64MMFR1_EL1),
+	ARM64_FTR_REG2IDX(SYS_ID_AA64MMFR2_EL1),
+	ARM64_FTR_REG2IDX(SYS_ZCR_EL1),
+	ARM64_FTR_REG2IDX(SYS_CTR_EL0),
+	ARM64_FTR_REG2IDX(SYS_DCZID_EL0),
+	ARM64_FTR_REG2IDX(SYS_CNTFRQ_EL0),
+
+	ARM64_FTR_REG_IDX_MAX,
+};
+
 u64 read_sanitised_ftr_reg(u32 id);
+u64 read_sanitised_ftr_reg_by_idx(enum arm64_ftr_reg_idx idx);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f36c4f62f69..05223352db5d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -546,16 +546,18 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 	ARM64_FTR_END,
 };
 
-#define ARM64_FTR_REG(id, table) {		\
-	.sys_id = id,				\
-	.reg = 	&(struct arm64_ftr_reg){	\
-		.name = #id,			\
-		.ftr_bits = &((table)[0]),	\
-	}}
+#define ARM64_FTR_REG(id, table)					\
+	[id ## _IDX] = {							\
+		.sys_id = id,						\
+		.reg	= &(struct arm64_ftr_reg) {			\
+			.name		= #id,				\
+			.ftr_bits	= &((table)[0]),		\
+		}							\
+	}
 
 static const struct __ftr_reg_entry {
 	u32			sys_id;
-	struct arm64_ftr_reg 	*reg;
+	struct arm64_ftr_reg	*reg;
 } arm64_ftr_regs[] = {
 
 	/* Op1 = 0, CRn = 0, CRm = 1 */
@@ -607,7 +609,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
 
 	/* Op1 = 3, CRn = 0, CRm = 0 */
-	{ SYS_CTR_EL0, &arm64_ftr_reg_ctrel0 },
+	[ARM64_FTR_REG2IDX(SYS_CTR_EL0)] = { SYS_CTR_EL0, &arm64_ftr_reg_ctrel0 },
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
 
 	/* Op1 = 3, CRn = 14, CRm = 0 */
@@ -1116,6 +1118,18 @@ u64 read_sanitised_ftr_reg(u32 id)
 }
 EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
+u64 read_sanitised_ftr_reg_by_idx(enum arm64_ftr_reg_idx idx)
+{
+	struct arm64_ftr_reg *regp;
+
+	if (WARN_ON((unsigned)idx >= ARM64_FTR_REG_IDX_MAX))
+		return 0;
+
+	regp = arm64_ftr_regs[idx].reg;
+	return regp->sys_val;
+}
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg_by_idx);
+
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
 
-- 
2.29.2.576.ga3fc446d84-goog

