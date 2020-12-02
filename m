Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEE2CC415
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 18:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLBRnf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 12:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLBRnf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 12:43:35 -0500
Date:   Wed, 2 Dec 2020 17:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606930974;
        bh=cqmV/I9FRZ4kYw4yyZj/9mTxHnFQnGQs3KzuxScuNO8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPNDX4Y6a/KFdERBe6ZlJGjU8wbI/C1LlTJNYV9/Jb779ie1B/mgOVK74wQyVQlEI
         CJmAjK1AjgcOmRuS7LUdRfDU3AZzhLLU4tmHif4kpoX6IXvCXly/f6HVZHkdEiVaxy
         ySa6YEOtZFQ+pHd1RMQhC0Hbfi3HwSvLI4DZNJUc=
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
Message-ID: <20201202174247.GB29939@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-5-will@kernel.org>
 <20201127131217.skekrybqjdidm5ki@e107158-lin.cambridge.arm.com>
 <20201201165633.GC27783@willie-the-truck>
 <20201202135216.7jilpcvocnqqp5aj@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202135216.7jilpcvocnqqp5aj@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 01:52:16PM +0000, Qais Yousef wrote:
> On 12/01/20 16:56, Will Deacon wrote:
> > On Fri, Nov 27, 2020 at 01:12:17PM +0000, Qais Yousef wrote:
> > > On 11/24/20 15:50, Will Deacon wrote:
> > > > Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.
> > > > 
> > > > Ensure that 32-bit applications always take the slow-path when returning
> > > > to userspace on a system with mismatched support at EL0, so that we can
> > > > avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > 
> > > nit: We drop this patch at the end. Can't we avoid it altogether instead?
> > 
> > I did it like this so that the last patch can be reverted for
> > testing/debugging, but also because I think it helps the structure of the
> > series.
> 
> Cool. I had a comment about the barrier(), you were worried about
> cpu_affinity_invalid() being inlined by the compiler and then things get
> mangled such that TIF_NOTIFY_RESUME clearing is moved after the call as you
> described? Can the compiler move things if cpu_affinity_invalid() is a proper
> function call (not inlined)?

I think function calls implicitly clobber memory, but you'd have to annotate
the thing as noinline to prevent it being inlined.

Will
