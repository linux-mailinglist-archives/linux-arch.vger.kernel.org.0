Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5186C38CC83
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhEURrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 13:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:52618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235399AbhEURrL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 13:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 904FD1424;
        Fri, 21 May 2021 10:45:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 445AC3F73D;
        Fri, 21 May 2021 10:45:45 -0700 (PDT)
Date:   Fri, 21 May 2021 18:45:42 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
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
Subject: Re: [PATCH v6 00/21] Add support for 32-bit tasks on asymmetric
 AArch32 systems
Message-ID: <20210521174542.2kojxgzrgdl6nqpx@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will

On 05/18/21 10:47, Will Deacon wrote:
> Hi folks,
> 
> This is the long-awaited v6 of these patches which I last posted at the
> end of last year:
> 
>   v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
>   v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
>   v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
> 
> There was also a nice LWN writeup in case you've forgotten what this is
> about:
> 
> 	https://lwn.net/Articles/838339/
> 
> It's taken me a while to get a v6 of this together, partly due to
> addressing the review feedback on v5, but also because this has now seen
> testing on real hardware which threw up some surprises in suspend/resume,
> SCHED_DEADLINE and compat hwcap reporting. Thanks to Quentin for helping
> me to debug those issues.
> 
> The aim of this series is to allow 32-bit ARM applications to run on
> arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> Unfortunately, such SoCs are real and will continue to be productised
> over the next few years at least. I can assure you that I'm not just
> doing this for fun.
> 
> Changes in v6 include:
> 
>   * Save/restore the affinity mask across execve() to 32-bit and back to
>     64-bit again.
> 
>   * Allow 32-bit deadline tasks, but skip straight to fallback path when
>     determining new affinity mask on execve().
> 
>   * Fixed resume-from-suspend path when the resuming CPU is 64-bit-only
>     by deferring wake-ups for 32-bit tasks until the secondary CPUs are
>     back online.
> 
>   * Bug fixes (compat hwcaps, memory leak, cpuset fallback path).
> 
>   * Documentation for arm64. It's in the divisive .rst format, but please
>     take a look anyway!
> 
> I'm pretty happy with this now and it seems to do the right thing,
> although the new patches in this revision would certainly benefit from
> review. Series based on v5.13-rc1.

It's late Fri and I'm off next week (I'm starting to sense an omen here, it's
the 2nd or 3rd time the post syncs with my holiday), so a bit of a rushed
review but the series looks good to me. Feel free to stick my Reviewed-by for
the series, except patch 13 where I skipped it, given the few comments I had
are addressed.

I did test v5, but not this version. I think it had found better victims to
test it now :-P

Thanks!

--
Qais Yousef
