Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F129DF1E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgJ2A7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 20:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbgJ1WRc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:32 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665E0246BE;
        Wed, 28 Oct 2020 11:22:09 +0000 (UTC)
Date:   Wed, 28 Oct 2020 11:22:06 +0000
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
Message-ID: <20201028112206.GD13345@gaia>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-3-will@kernel.org>
 <20201028111204.GB13345@gaia>
 <20201028111713.GA27927@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111713.GA27927@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 11:17:13AM +0000, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 11:12:04AM +0000, Catalin Marinas wrote:
> > On Tue, Oct 27, 2020 at 09:51:14PM +0000, Will Deacon wrote:
> > > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > > +{
> > > +	return has_cpuid_feature(entry, scope) || __allow_mismatched_32bit_el0;
> > > +}
> > > +
> > >  static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
> > >  {
> > >  	bool has_sre;
> > > @@ -1803,7 +1851,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >  		.desc = "32-bit EL0 Support",
> > >  		.capability = ARM64_HAS_32BIT_EL0,
> > >  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > -		.matches = has_cpuid_feature,
> > > +		.matches = has_32bit_el0,
> > 
> > Ah, so this one reports 32-bit EL0 support even if no CPU actually
> > supports 32-bit (passing the command line option on TX2 would come up
> > with 32-bit EL0 in dmesg). I'd rather hide the .desc above and print the
> > information elsewhere when have at least one CPU supporting this.
> 
> Yeah, the problem is if a CPU with 32-bit EL0 support was late-onlined,
> then we would have 32-bit support, so I think this is an oddity that you
> get when the command line is passed. That said, I could nobble .desc and
> print it from the .matches function, with a slightly different message
> when the command line is passed.

I think we could do a pr_info_once() in update_32bit_cpu_features().

-- 
Catalin
