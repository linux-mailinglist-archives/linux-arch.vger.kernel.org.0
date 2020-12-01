Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04182CA922
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392206AbgLAQ5V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391923AbgLAQ5V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEA32076C;
        Tue,  1 Dec 2020 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841800;
        bh=Lv7GIMUtEGurVreC2UmCreL5UbLTF5Qoi61IUV5s8/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4L+aw0SQFzqPN8jvBANSDCIAYxMrudTWGcnfxHKtqDacHg1IBsstwIxnKr+E9wlz
         4MoupL6pY0f2SPiGLb8g33bOY0ig8QG8yPMCF7ThFizJ+ozAQGCV4ZJTNbJmLBeSAo
         F/P9sTDcS3FnKyaTawnnOqzOvz0cw2wMUnaZXTNE=
Date:   Tue, 1 Dec 2020 16:56:34 +0000
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
        kernel-team@android.com
Subject: Re: [PATCH v4 04/14] arm64: Kill 32-bit applications scheduled on
 64-bit-only CPUs
Message-ID: <20201201165633.GC27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-5-will@kernel.org>
 <20201127131217.skekrybqjdidm5ki@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127131217.skekrybqjdidm5ki@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 01:12:17PM +0000, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> > Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.
> > 
> > Ensure that 32-bit applications always take the slow-path when returning
> > to userspace on a system with mismatched support at EL0, so that we can
> > avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> 
> nit: We drop this patch at the end. Can't we avoid it altogether instead?

I did it like this so that the last patch can be reverted for
testing/debugging, but also because I think it helps the structure of the
series.

> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index a8184cad8890..bcb6ca2d9a7c 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -911,6 +911,19 @@ static void do_signal(struct pt_regs *regs)
> >  	restore_saved_sigmask();
> >  }
> >  
> > +static bool cpu_affinity_invalid(struct pt_regs *regs)
> > +{
> > +	if (!compat_user_mode(regs))
> > +		return false;
> 
> Silly question. Is there an advantage of using compat_user_mode() vs
> is_compat_task()? I see the latter used in the file although struct pt_regs
> *regs is passed to the functions calling it.
> 
> Nothing's wrong with it, just curious.

Not sure about advantages, but is_compat_task() is available in core code,
whereas compat_user_mode() is specific to arm64. The former implicitly
operates on 'current' and just checks thread flag, whereas the latter
actually goes and looks at mode field of the spsr to see what we're
going to be returning into.

Will
