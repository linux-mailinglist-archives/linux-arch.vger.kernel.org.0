Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CA38F442
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhEXUXW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 16:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhEXUXW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 16:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46E6B611B0;
        Mon, 24 May 2021 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621887713;
        bh=6RQbeZvmHXBMt1SBEvj3/LaSGxCxDFKh6HhXV2ArOG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrk3isTbZPPXvOC+CovDArTMGcqXbhESJwjjvs5Lg3lcjHy0br1AINvTzwqRGHVie
         PGiNFnx/d8ZMAkTENyirJgidZ1KLVN/daTrLjqJ2yjOAxDezC8TOEC0LP7t1242mcV
         irhl2pgdxhRavUJ4MOcibx3NQJ0kSaHkEyS6Yo0gpzK9oB8pU9l/tXTbR9M5Qe6Elz
         4bRHwxSIaWtVoKwjqQx9q0IqOn2p7LKV73bMX4s03AWvfx2vObgEmXCCzGcWKi/qJX
         TH3giUR/SK5oonVkFButmNZ9rWR7o0tA39JRRl/jaEWeguI99KwwCP5YQ73RzZ0Bo1
         paS9ftr+WVSJg==
Date:   Mon, 24 May 2021 21:21:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 02/21] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210524202146.GC15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-3-will@kernel.org>
 <20210521152255.tosr4jwok6cjg6sf@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521152255.tosr4jwok6cjg6sf@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 04:22:55PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > When confronted with a mixture of CPUs, some of which support 32-bit
> > applications and others which don't, we quite sensibly treat the system
> > as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> > 
> > Unfortunately, some crazy folks have decided to build systems like this
> > with the intention of running 32-bit applications, so relax our
> > sanitisation logic to continue to advertise 32-bit support to userspace
> > on these systems and track the real 32-bit capable cores in a cpumask
> > instead. For now, the default behaviour remains but will be tied to
> > a command-line option in a later patch.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpucaps.h    |   3 +-
> 
> Heads up. I just tried to apply this on 5.13-rc2 and it failed because cpucaps.
> was removed; it's autogenerated now.
> 
> See commit 0c6c2d3615ef: ()"arm64: Generate cpucaps.h")

Yup, cheers. I'll sort that out once we're at the stage where we're merging
patches.

Will
