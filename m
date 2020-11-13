Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698BD2B1846
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMJgi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgKMJgg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:36:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EE222240;
        Fri, 13 Nov 2020 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260196;
        bh=Awbze+yn+sds2zWgzVstLWw9uJr4cE6in8SvDz0W3C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQWpJ/KPcFLuU9qRwqAVsOjXoZWMHlyxIG0jZaGNU0Kzkml7x7qqhmuCj1Ut2G2s6
         8LYuupsLS6ia26YI2GYqDrcAbQlziwz0ucqBbQxmltYbtZXBWrlUYXGBDbtsabuD2R
         q+0rkeYJlXuPW54IH7qyJN6ryDoVZKQMfcqk1+/0=
Date:   Fri, 13 Nov 2020 09:36:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201113093630.GA21075@willie-the-truck>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-3-will@kernel.org>
 <20201111191043.GA5125@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111191043.GA5125@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 11, 2020 at 07:10:44PM +0000, Catalin Marinas wrote:
> On Mon, Nov 09, 2020 at 09:30:18PM +0000, Will Deacon wrote:
> > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > +{
> > +	if (!has_cpuid_feature(entry, scope))
> > +		return allow_mismatched_32bit_el0;
> 
> I still don't like overriding the cpufeature mechanism in this way. What about
> something like below? It still doesn't fit perfectly but at least the
> capability represents what was detected in the system. We then decide in
> system_supports_32bit_el0() whether to allow asymmetry. There is an
> extra trick to park a non-AArch32 capable CPU in has_32bit_el0() if it
> comes up late and the feature has already been advertised with
> !allow_mismatched_32bit_el0.

I deliberately allow late onlining of 64-bit-only cores and I don't think
this is something we should forbid (although it's not clear from your patch
when allow_mismatched_32bit_el0 gets set). Furthermore, killing CPUs from
the matches callback feels _very_ dodgy to me, as it's invoked indirectly
by things such as this_cpu_has_cap().

> I find it clearer, though I probably stared at it more than at your
> patch ;).

Yeah, swings and roundabouts...

I think we're quibbling on implementation details a bit here whereas we
should probably be focussing on what to do about execve() and CPU hotplug.
Your patch doesn't apply on top of my series or replace this one, so there's
not an awful lot I can do with it. I'm about to post a v3 with a tentative
solution for execve(), so please could you demonstrate your idea on top of
that so I can see how it fits together?

I'd like to move on from the "I don't like this" (none of us do) discussion
and figure out the functional aspects, if possible. We can always paint it
a different colour later on, but we don't even have a full solution yet.

Thanks,

Will
