Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C338CC5A
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhEURit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 13:38:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232624AbhEURit (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 13:38:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7621424;
        Fri, 21 May 2021 10:37:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42003F73D;
        Fri, 21 May 2021 10:37:23 -0700 (PDT)
Date:   Fri, 21 May 2021 18:37:21 +0100
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
Subject: Re: [PATCH v6 21/21] Documentation: arm64: describe asymmetric
 32-bit support
Message-ID: <20210521173721.untjfglvxja6v6ot@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-22-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-22-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/18/21 10:47, Will Deacon wrote:
> Document support for running 32-bit tasks on asymmetric 32-bit systems
> and its impact on the user ABI when enabled.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |   3 +
>  Documentation/arm64/asymmetric-32bit.rst      | 149 ++++++++++++++++++
>  Documentation/arm64/index.rst                 |   1 +
>  3 files changed, 153 insertions(+)
>  create mode 100644 Documentation/arm64/asymmetric-32bit.rst
> 

[...]

> +Cpusets
> +-------
> +
> +The affinity of a 32-bit task may include CPUs that are not explicitly
> +allowed by the cpuset to which it is attached. This can occur as a
> +result of the following two situations:
> +
> +  - A 64-bit task attached to a cpuset which allows only 64-bit CPUs
> +    executes a 32-bit program.
> +
> +  - All of the 32-bit-capable CPUs allowed by a cpuset containing a
> +    32-bit task are offlined.
> +
> +In both of these cases, the new affinity is calculated according to step
> +(2) of the process described in `execve(2)`_ and the cpuset hierarchy is
> +unchanged irrespective of the cgroup version.

nit: Should we call out that we're breaking cpuset-v1 behavior? Don't feel
strongly about it.

Cheers

--
Qais Yousef
