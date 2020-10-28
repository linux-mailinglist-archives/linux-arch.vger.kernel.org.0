Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0178729D8A9
	for <lists+linux-arch@lfdr.de>; Wed, 28 Oct 2020 23:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgJ1Wen (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 18:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbgJ1WcX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:23 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF3224810;
        Wed, 28 Oct 2020 18:56:23 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:56:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201028185620.GK13345@gaia>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-3-will@kernel.org>
 <20201028111204.GB13345@gaia>
 <20201028111713.GA27927@willie-the-truck>
 <20201028112206.GD13345@gaia>
 <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028124049.GC28091@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 12:40:49PM +0000, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 11:49:46AM +0000, Catalin Marinas wrote:
> > On Wed, Oct 28, 2020 at 11:23:43AM +0000, Will Deacon wrote:
> > > On Wed, Oct 28, 2020 at 11:22:06AM +0000, Catalin Marinas wrote:
> > > > On Wed, Oct 28, 2020 at 11:17:13AM +0000, Will Deacon wrote:
> > > > > On Wed, Oct 28, 2020 at 11:12:04AM +0000, Catalin Marinas wrote:
> > > > > > On Tue, Oct 27, 2020 at 09:51:14PM +0000, Will Deacon wrote:
> > > > > > > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > > > > > > +{
> > > > > > > +	return has_cpuid_feature(entry, scope) || __allow_mismatched_32bit_el0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
> > > > > > >  {
> > > > > > >  	bool has_sre;
> > > > > > > @@ -1803,7 +1851,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > > > > > >  		.desc = "32-bit EL0 Support",
> > > > > > >  		.capability = ARM64_HAS_32BIT_EL0,
> > > > > > >  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > > > > > -		.matches = has_cpuid_feature,
> > > > > > > +		.matches = has_32bit_el0,
> > > > > > 
> > > > > > Ah, so this one reports 32-bit EL0 support even if no CPU actually
> > > > > > supports 32-bit (passing the command line option on TX2 would come up
> > > > > > with 32-bit EL0 in dmesg). I'd rather hide the .desc above and print the
> > > > > > information elsewhere when have at least one CPU supporting this.
> > > > > 
> > > > > Yeah, the problem is if a CPU with 32-bit EL0 support was late-onlined,
> > > > > then we would have 32-bit support, so I think this is an oddity that you
> > > > > get when the command line is passed. That said, I could nobble .desc and
> > > > > print it from the .matches function, with a slightly different message
> > > > > when the command line is passed.
> > > > 
> > > > I think we could do a pr_info_once() in update_32bit_cpu_features().
> > > 
> > > Is that called on a system with one CPU?
> > 
> > Ah, it's not.
> > 
> > Anyway, I see your reasoning behind the late CPUs but I don't
> > particularly like abusing the cpufeature support to pretend a
> > SYSTEM_FEATURE is available before knowing any CPU has it (maybe we do
> > it in other cases, I haven't checked).
> 
> Hmm, but that's exactly what this cmdline option is about. We pretend that
> the system has 32-bit EL0 when normally we would say that we don't.

So that's more about force-enabling 32-bit irrespective of whether any
CPU supports it (not just in the mismatched/asymmetric case). Of course,
if the aarch32_el0 mask is empty, the apps would get SIGKILL'ed.

> > Could we not instead add a new feature for asymmetric support that's
> > defined as ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE? This would be allowed
> > for late CPUs and we keep the system_supports_32bit_el0() unchanged.
> 
> I really don't think this gains us anything.

It saves us having to explain to someone passing this option on a TX2
why personality(PER_LINUX32) and even execve() appear to work (well,
until SIGKILL). The lscpu tool, for example, uses personality() to
display whether the CPUs support 32-bit.

Also with PER_LINUX32, /proc/cpuinfo shows the 32-bit HWCAPs. We have
compat_elf_hwcap pre-populated with some stuff which is entirely untrue
if AArch32 is missing.

Thinking about the COMPAT_HWCAPs, do we actually populate them properly
on an asymmetric system if the boot CPU is not AArch32-capable? In my
original patch I had to defer populating boot_cpu_data with AArch32
information until a capable CPU was found. If not,
update_32bit_cpu_features() will set most 32-bit features to 0.

> The current users of system_supports_32bit_el0() are:
> 
>   - The ELF loader
>   - CPU feature sanitisation code
>   - Personality syscall

There three need a relaxed system_supports_32bit_el0(), so we could
change it to check a new relaxed feature.

>   - KVM

Here I think we need the stronger guarantee, no 32-bit allowed in
guests (the original symmetric feature check).

> and, afaict, all of these would need to check the new feature if we added
> it.  I think it would also mean that at least one 32-bit capable CPU would
> have to boot early in order for the new feature to be advertised, which
> feels like an artificial restriction to me, particularly as you could just
> offline it immediately.

How strong requirement is to allow late CPUs here? I think we'd miss the
COMPAT_HWCAPs as we no longer populate them once user-space started,
they are actually setup via smp_cpus_done() -> setup_cpu_features().

-- 
Catalin
