Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1002E2C6690
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgK0NSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:18:04 -0500
Received: from foss.arm.com ([217.140.110.172]:41392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgK0NSE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:18:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48B030E;
        Fri, 27 Nov 2020 05:18:03 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF3C3F70D;
        Fri, 27 Nov 2020 05:18:01 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:17:59 +0000
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
        kernel-team@android.com
Subject: Re: [PATCH v4 06/14] arm64: Hook up cmdline parameter to allow
 mismatched 32-bit EL0
Message-ID: <20201127131759.5o5qiv2uwtb6qadl@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-7-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> Allow systems with mismatched 32-bit support at EL0 to run 32-bit
> applications based on a new kernel parameter.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  arch/arm64/kernel/cpufeature.c                  | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..f20188c44d83 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -289,6 +289,13 @@
>  			do not want to use tracing_snapshot_alloc() as it needs
>  			to be done where GFP_KERNEL allocations are allowed.
>  
> +	allow_mismatched_32bit_el0 [ARM64]
> +			Allow execve() of 32-bit applications and setting of the
> +			PER_LINUX32 personality on systems where only a strict
> +			subset of the CPUs support 32-bit EL0. When this
> +			parameter is present, the set of CPUs supporting 32-bit
> +			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0.

Shouldn't we document that a randomly selected 32-bit CPU will be prevented
from being hotplugged out all the time to act as the last man standing for any
currently running 32-bit application.

That was a mouthful! I'm sure you can phrase it better :-)

If we make this the last patch as it was before adding affinity handling, we
can drop patch 4 more easily I think?

Thanks

--
Qais Yousef
