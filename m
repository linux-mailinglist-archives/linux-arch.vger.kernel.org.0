Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FE2AF64C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKKQ1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 11:27:06 -0500
Received: from foss.arm.com ([217.140.110.172]:57652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbgKKQ1F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Nov 2020 11:27:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F040101E;
        Wed, 11 Nov 2020 08:27:04 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D273F6CF;
        Wed, 11 Nov 2020 08:27:02 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:27:00 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201111162700.p4sem2fup5qjjbqz@e107158-lin.cambridge.arm.com>
References: <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
 <20201106130007.GA10605@willie-the-truck>
 <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
 <20201109135259.GA14526@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109135259.GA14526@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/09/20 13:52, Will Deacon wrote:
> On Fri, Nov 06, 2020 at 02:48:35PM +0000, Qais Yousef wrote:
> > On 11/06/20 13:00, Will Deacon wrote:
> > > On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> > > > FWIW I have my v3 over here in case it's of any help. It solves the problem of
> > > > HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> > > > with 32bit features then.
> > > > 
> > > > 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3
> > > 
> > > Cheers, I've done something similar. I was hoping to post it today, but I've
> > > been side-tracked with bug fixing this morning. The main headache I ended up
> > > with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
> > > are 32-bit capable. What do you do in that case?
> > 
> > Do you mean if CPUs 0-3 were 32bit capable and we boot with maxcpus=4 then
> > attempt to bring the remaining 64bit-only cpus online later?
> 
> Right. I think we will refuse to online them. I'll post my attempt at
> handling that shortly.

Sorry for the delayed response.

You're right, I tried that and they refuse to come online. We missed that tbh.

Haven't thought what we should do yet. I tried your v2 and it failed similarly.

I usually have a similar hunk in my testing to check how the kernel perceives
the 32bit support when I execute a binary:

	diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
	index f447d313a9c5..a9549e55a6c8 100644
	--- a/arch/arm64/include/asm/cpufeature.h
	+++ b/arch/arm64/include/asm/cpufeature.h
	@@ -611,6 +611,9 @@ static inline bool system_supports_32bit_el0(void)
	 {
		u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);

	+       pr_err("System supports symmetric 32bit el0: %d\n", id_aa64pfr0_32bit_el0(pfr0));
	+       pr_err("System supports Asymmetric 32bit el0: %ld\n", static_branch_unlikely(&arm64_mismatched_32bit_el0));
	+
		return id_aa64pfr0_32bit_el0(pfr0) ||
		       static_branch_unlikely(&arm64_mismatched_32bit_el0);
	 }

In your v2 both conditions are true. In my series we see the system as
symmetric if we boot the 32bit capable cpus _only_.

> > Haven't tried that tbh. What symptoms do you expect to see? I can try it out.
> > I'm off for the remainder of the day, but can spend few mins to run an
> > experiment for sure.
> 
> No probs; I've been taking Friday afternoons off to burn holiday anyway, so
> you didn't miss anything!

:-)

Thanks

--
Qais Yousef
