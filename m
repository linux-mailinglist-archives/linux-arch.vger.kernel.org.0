Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B92B9358
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 14:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKSNMr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 08:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgKSNMr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 08:12:47 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CC52222A;
        Thu, 19 Nov 2020 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605791564;
        bh=+S1H0ZJpI+XEJQFoYwrcrygpnJ+0WlSbLdnlvQ3oIAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwnHgZxHP8mA72dLl+N1D1ijUGgvL48bEfydoyKdJw0kCsH7hurie2mO1R1i2q/xR
         d+ZGYDXjrWiC1kZq5o38c0ehtfEQvVEVLzAPy2RjlUQGkFivVKHEldZ0c0wEf+N8UZ
         TEOeuRZVLsRMX2oRy5EFkwQ7cihGGQsv9enII3NM=
Date:   Thu, 19 Nov 2020 13:12:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 02/14] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201119131236.GC4331@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-3-will@kernel.org>
 <jhjblftwpqq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjblftwpqq.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Valentin,

Thanks for the review.

On Thu, Nov 19, 2020 at 11:27:41AM +0000, Valentin Schneider wrote:
> 
> On 13/11/20 09:37, Will Deacon wrote:
> > +const struct cpumask *system_32bit_el0_cpumask(void)
> > +{
> > +	if (!system_supports_32bit_el0())
> > +		return cpu_none_mask;
> > +
> > +	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > +		return cpu_32bit_el0_mask;
> > +
> > +	return cpu_present_mask;
> > +}
> 
> Nit: this is used in patch 13 to implement arch_cpu_allowed_mask(). Since
> that latter defaults to cpu_possible_mask, this probably should too.

My original thinking was that, in a system where 32-bit EL0 support is
detected at boot and we're not handling mismatches, then it would be nice
to avoid saying that late CPUs are all 32-bit capable given that they will
fail to be onlined if they're not.

However, the reality is that we don't currently distinguish between the
present and possible masks on arm64 so it doesn't make any difference. It's
also not useful to userspace, because if the cores aren't online then so
what? Your observation above is another nail in the coffin, so I'll change
this to the possible mask as you suggest.

Cheers,

Will
